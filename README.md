# Swiggy Instamart Sales & Inventory Analysis (SQL)

## 📌 Project Overview
This project analyzes FMCG sales and inventory data for **Swiggy Instamart** in the Delhi-NCR region. It demonstrates advanced SQL techniques to solve real-world retail challenges like inventory turnover, regional performance, and revenue growth.

## 📊 Business Problems Solved
1. **Inventory Efficiency:** Identified slow-moving stock to reduce waste.
2. **Regional Performance:** Analyzed dark-store efficiency across Delhi, Noida, and Gurgaon.
3. **Revenue Growth:** Calculated Month-over-Month (MoM) growth using Window Functions.
4. **Pareto Analysis:** Identified the top 20% of stores generating 80% of total revenue.

## 🛠️ Technical Skills Demonstrated
- **Joins & Aggregations**
- **Subqueries**
- **Common Table Expressions (CTEs)**
- **Window Functions** (`RANK`, `LAG`, `SUM OVER`)
- **Data Modeling** (Primary/Foreign Key relationships)

## 🗄️ Database Schema
The analysis is based on three normalized tables: `products`, `store_locations`, and `sales_transactions`.

## 🚀 Key Insights & Recommendations
- **Insight:** South Delhi and Noida Hubs generate 80% of revenue. 
- **Action:** Prioritize 100% stock availability in these hubs to prevent churn to Zepto/Blinkit.
- **Insight:** High-stock/Low-sale items (e.g., Tata Tea Gold) are taking up shelf space.
- **Action:** Recommended app-based 'Flash Deals' to clear slow-moving inventory.
