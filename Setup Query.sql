-- Table creation products,store_locations,sales_transactions
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_cost DECIMAL(10, 2),
    unit_price DECIMAL(10, 2), -- Added to calculate revenue
    current_stock INT );
    
   CREATE TABLE store_locations (
    store_id INT PRIMARY KEY,
    city VARCHAR(50),
    region VARCHAR(50), 
    store_type VARCHAR(50) );


CREATE TABLE sales_transactions (
    transaction_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (store_id) REFERENCES store_locations(store_id));
   
   -- Inserting Data into tables
    INSERT INTO products VALUES 
(101, 'Lays Magic Masala', 'Snacks', 15.00, 20.00, 500),
(102, 'Coca-Cola 500ml', 'Beverages', 30.00, 40.00, 300),
(103, 'Amul Taaza Milk', 'Dairy', 24.00, 27.00, 50),
(104, 'Doritos Nachos', 'Snacks', 40.00, 50.00, 200),
(105, 'Red Bull', 'Beverages', 100.00, 125.00, 150),
(106, 'Haldiram Bhujia', 'Snacks', 35.00, 45.00, 600),
(107, 'Tata Tea Gold', 'Beverages', 120.00, 150.00, 100),
(108, 'Britannia Biscuits', 'Snacks', 25.00, 30.00, 400),
(109, 'Monster Energy', 'Beverages', 95.00, 110.00, 80),
(110, 'Bingo Mad Angles', 'Snacks', 15.00, 20.00, 450);


INSERT INTO store_locations VALUES 
(1, 'Delhi', 'South Delhi', 'Hub'),
(2, 'Delhi', 'West Delhi', 'Mini-Store'),
(3, 'Noida', 'Sector 62', 'Hub'),
(4, 'Gurgaon', 'DLF Phase 3', 'Hub'),
(5, 'Ghaziabad', 'Indirapuram', 'Mini-Store');


INSERT INTO sales_transactions VALUES 
(5001, 101, 1, 10, '2026-05-01'), (5002, 102, 1, 5, '2026-05-02'),
(5003, 103, 3, 20, '2026-05-02'), (5004, 105, 4, 2, '2026-05-03'),
(5005, 101, 4, 15, '2026-05-04'), (5006, 106, 2, 30, '2026-05-05'),
(5007, 102, 5, 10, '2026-05-06'), (5008, 109, 1, 4, '2026-05-07'),
(5009, 103, 1, 12, '2026-05-08'), (5010, 107, 3, 1, '2026-05-09'),
(5011, 101, 3, 50, '2026-05-10'), (5012, 104, 4, 10, '2026-04-15');