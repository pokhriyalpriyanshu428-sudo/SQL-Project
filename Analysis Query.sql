-- 1. List products with low stock (under 100 units) to trigger reorder alerts.
SELECT product_name, current_stock 
FROM products 
WHERE current_stock < 100;

-- 2. Count total transactions in 'South Delhi'.
SELECT COUNT(*) AS total_txns 
FROM sales_transactions st
JOIN store_locations sl ON st.store_id = sl.store_id
WHERE sl.region = 'South Delhi';

-- 3. Find unique categories of products sold in Gurgaon.
SELECT DISTINCT p.category 
FROM products p
JOIN sales_transactions st ON p.product_id = st.product_id
JOIN store_locations sl ON st.store_id = sl.store_id
WHERE sl.city = 'Gurgaon';

-- 4. Calculate total quantity sold for 'Lays Magic Masala'.
SELECT SUM(quantity) AS total_sold 
FROM sales_transactions 
WHERE product_id = 101;

-- 5. Sort stores by city in ascending order.
SELECT * FROM store_locations ORDER BY city ASC;

-- 6. Total Revenue per Category.
SELECT p.category, SUM(st.quantity * p.unit_price) AS total_revenue
FROM sales_transactions st
JOIN products p ON st.product_id = p.product_id
GROUP BY p.category;

-- 7. Identify the Top 3 highest revenue-generating stores.
SELECT sl.region, sl.city, SUM(st.quantity * p.unit_price) AS store_revenue
FROM sales_transactions st
JOIN store_locations sl ON st.store_id = sl.store_id
JOIN products p ON st.product_id = p.product_id
GROUP BY sl.region, sl.city
ORDER BY store_revenue DESC
LIMIT 3;

-- 8. Find products that have never been sold.
SELECT product_name 
FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM sales_transactions);

-- 9. Average quantity sold per transaction by store type.
SELECT sl.store_type, AVG(st.quantity) AS avg_qty
FROM sales_transactions st
JOIN store_locations sl ON st.store_id = sl.store_id
GROUP BY sl.store_type;

-- 10. List transactions where the quantity sold is higher than the average quantity of all sales.
SELECT * FROM sales_transactions 
WHERE quantity > (SELECT AVG(quantity) FROM sales_transactions);

-- 11. Ranking products by revenue within each category.
WITH CategoryRevenue AS (
    SELECT p.category, p.product_name, SUM(st.quantity * p.unit_price) AS revenue
    FROM sales_transactions st
    JOIN products p ON st.product_id = p.product_id
    GROUP BY 1, 2
)
SELECT category, product_name, revenue,
       RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rnk
FROM CategoryRevenue;

-- 12. Month-over-Month (MoM) Sales Growth.
WITH MonthlySales AS (
    SELECT DATE_TRUNC('month', sale_date) AS txn_month,
           SUM(quantity * unit_price) AS monthly_revenue
    FROM sales_transactions st
    JOIN products p ON st.product_id = p.product_id
    GROUP BY 1
)
SELECT txn_month, monthly_revenue,
       LAG(monthly_revenue) OVER (ORDER BY txn_month) AS prev_month_revenue
FROM MonthlySales;

-- 13. Running Total of Sales for the South Delhi Hub.
SELECT sale_date, 
       SUM(quantity * unit_price) OVER (ORDER BY sale_date) AS running_total
FROM sales_transactions st
JOIN products p ON st.product_id = p.product_id
WHERE store_id = 1;

-- 14. Identifying 'Slow-Moving' Stock (Low Sales vs. High Stock).
SELECT p.product_name, p.current_stock, COALESCE(SUM(st.quantity), 0) AS total_sold
FROM products p
LEFT JOIN sales_transactions st ON p.product_id = st.product_id
GROUP BY 1, 2
HAVING COALESCE(SUM(st.quantity), 0) < 5 AND p.current_stock > 100;

-- 15. Pareto Analysis: Stores contributing to top 80% of revenue.
WITH StoreSales AS 
(SELECT store_id, SUM(quantity * unit_price) AS revenue
    FROM sales_transactions st
    JOIN products p ON st.product_id = p.product_id
    GROUP BY 1),
RunningPercentage AS 
(SELECT store_id, revenue,
           SUM(revenue) OVER (ORDER BY revenue DESC) / SUM(revenue) OVER () AS cum_pct
    FROM StoreSales)
SELECT * FROM RunningPercentage WHERE cum_pct <= 0.85;