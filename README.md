# 📊 Solving Inventory Inefficiencies Using SQL

## 🚀 Project Overview

This project was undertaken as part of the **Summer Projects 2025** by the **Consulting & Analytics Club at IIT Guwahati**. 🌟  
It addresses critical inventory management challenges faced by **Urban Retail Co.**, a rapidly expanding mid-sized retail chain. 🏬  

Urban Retail Co. operates with over **5,000 diverse Stock Keeping Units (SKUs)** across **five physical stores** 🛒 spread across the East, West, North, and South regions, supported by a complex logistics network of regional warehouses. 📦

✨ **The Challenge:**  
Urban Retail Co. was struggling significantly with maintaining optimal inventory levels due to reactive, manual decision-making and a lack of integrated data analytics. This led to:
* 🚫 Frequent stockouts of fast-moving products.
* 📈 Overstocking of slow-moving items.
* ⏳ Lack of real-time SKU performance insights and supplier reliability.
* 🔍 Poor visibility across products, stores, and regions.

🎯 **My Objective:**  
To transform Urban Retail Co.'s raw sales, inventory, and warehouse data into actionable insights through SQL-driven analytics — addressing stockouts, overstocking, inefficiencies, and enhancing overall supply chain performance.

---

## 🗃️ Dataset

📁 The original dataset:
- 📄 `inventory_forecasting.csv` — unstructured sales & inventory data with **over 109k+ entries**.  

I cleaned and normalized it using **Excel** into a **star schema** with 4 tables:
- 🗓️ `dim_date.csv` — Date dimension.
- 📋 `dim_product.csv` — Product catalog.
- 🏪 `dim_store.csv` — Store & region info.
- 📊 `fact_inventory_sales.csv` — Fact table of transactions.

The schema follows a normalized ⭐ star schema and is visualized in:  
🖼️ `ERD DIAGRAM`
🖼️ `SCHEMAS`


---

## 🔍 Key Findings & Insights

The project deployed robust SQL-based analytics across four domains:  

📌 **Inventory Performance & Optimization.**  
📌 **Sales & Demand Analysis.**  
📌 **Impact of External Factors.**  
📌 **Inferred Supplier Performance.**



### 🪙 Inventory Performance & Optimization
* Product **P0061** had the highest average inventory; **P0175** the lowest.
* Clothing in the **North** region held the maximum inventory value; Groceries in the **West** had the minimum.
* 📈 Inventory turnover improved slightly from 2022 → 2023, but room remains for categories with lower turnover.
* 🔔 High-risk stockouts identified for **P0069, P0133, P0178, P0125, P0016** — needing urgent reorder point adjustments.
* 📦 Overstock prevalent in **P0031, P0126, P0057, P0017, P0066**, while stockouts occurred most with **P0153, P0083, P0175, P0178, P0126**.
* ⚖️ Mixed-signal products (**P0066, P0126**) show erratic patterns and need deeper investigation.

### 🛒 Sales & Demand Analysis
* Bestsellers by category:
  - 👕 Clothing: **P0057, P0046, P0133, P0187, P0125**
  - 📱 Electronics: **P0171, P0183, P0031, P0159, P0175**
  - 🪑 Furniture: **P0067, P0153, P0079, P0116**
  - 🥫 Groceries: **P0094**
  - 🧸 Toys: **P0017**
* 🗓️ Clear seasonal patterns: Winter & Summer = peak; Spring = weakest. Unique Summer peak for **P0094 (Groceries)**.

### 🌦️ Impact of External Factors
* 🎉 Promotions & holidays increased sales ~20%.
* 💸 Optimal discount range: **0–10%**, maximizing volume without steep price cuts.
* 🌧️ Weather impacts:
  - Clothing ↑ in Snowy & Rainy seasons.
  - Electronics & Furniture ↓ in Rainy seasons.
  - Groceries ↓ slightly in Snowy seasons.
  - Toys steady across seasons.

### 🚚 Supplier Performance (Inferred)
* 📦 Order fulfillment discrepancies identified by comparing Units Ordered & Delivered (Calculated Inflow).
* Under-fulfillment suspected for products with high stockouts like **P0153, P0083, P0175, P0178, P0126**.

---

## 💡 Recommendations

✅ **Targeted Inventory Adjustments**
- Increase orders for fast-selling, stockout-prone items (e.g., P0178, P0149, P0153).
- Reduce orders & explore liquidation for slow-moving overstocked items (e.g., P0070, P0171, P0183, P0031).

✅ **Dynamic Reorder Point System**
- Move away from static thresholds.
- Use demand forecasts + 1-day lead time + 90% service level (Z=1.28) for proactive planning.

✅ **Enhance Forecasting with External Factors**
- Incorporate seasonality, promotions & weather into demand forecasting.

✅ **Strengthen Supplier Dialogue**
- Leverage supplier performance insights to improve delivery reliability.

✅ **Automate Monitoring**
- Alerts for low inventory, fulfillment gaps, and major forecast deviations.

---

## 📦 Deliverables
- 💻 SQL scripts for:
  - Stock level calculations & low inventory detection
  - Reorder point estimation
  - Inventory turnover analysis
  - KPI summary reports
- 🖼️ ERD & schema diagram.
- 📊 KPI dashboard & executive summary.
- 📄 Detailed findings & actionable recommendations.

---

## 📈 Expected Business Impact

By implementing these recommendations, Urban Retail Co. can achieve:
- 🚀 Smarter, data-driven inventory decisions.
- 🔄 Significant reduction in stockouts & overstock.
- 📈 Improved supply chain efficiency & predictability.
- 😀 Higher customer satisfaction due to better product availability.
- 💰 Boosted profitability through reduced costs & maximized sales.

---

## 📄 Resources

📚 All files & folders used in this project:

### 📁 Folders
- [`DATA`](DATA) — Contains cleaned & structured data:
  - 🗓️ [`dim_date.csv`](DATA/Dim_Date.csv) — Date dimension.
  - 📋 [`dim_product.csv`](DATA/Dim_Product.csv) — Product catalog.
  - 🏪 [`dim_store.csv`](DATA/Dim_Store.csv) — Store & region info.
  - 📊 [`fact_inventory_sales.csv`](DATA/Fact_Inventory_Sales.csv) — Fact table of transactions.

- SQL Queries — Organized by analytical domains:
  - 📂 [`INVENTORY PERFORMANCE AND OPTIMIZATION`](SQL%20QUERIES/INVENTORY%20PERFORMANCE%20AND%20OPTIMIZATION/) — Queries for stock levels, reorder points, turnover, overstock & stockout detection.
  - 📂 [`SALES AND DEMAND ANALYSIS`](SQL%20QUERIES/SALES%20AND%20DEMAND%20ANALYSIS/) — Queries for product performance, seasonality, and demand patterns.
  - 📂 [`Impact Of External Factors`](SQL%20QUERIES/Impact%20Of%20External%20Factors/) — Queries for analyzing the effect of promotions, discounts, weather, and holidays.
  - 📂 [`Supplier Performance`](SQL%20QUERIES/Supplier%20Performance/) — Queries for inferred supplier fulfillment performance & discrepancies.

- 📊 [`Power BI`](./POWER%20BI/) — Contains KPI dashboards built in Power BI showcasing key insights & visualizations.

- 📄 [`Results`](RESULT%20EXCEL%20FILE/) — Contains CSV output files generated by running SQL queries, summarizing the findings.

### 📄 Standalone Dataset
- 📄 [`inventory_forecasting.csv`](./inventory_forecasting.csv) — Original unstructured dataset (over 109k+ entries), located at the root of the repository.

### 📄 Documents
- 📑 [`Solving Inventory Inefficiency using SQL.pdf`](./Solving%20Inventory%20Inefficiency%20using%20SQL.pdf) — Project brief & context.
- 📑 [`Executive Summary.pdf`](./Executive%20Summary.pdf) — Detailed findings & recommendations.

### 🖼️ Diagrams
- 🖼️ [`ERD DIAGRAM`](https://github.com/Ahad-5887/Fix-Inventory-Inefficiencies-SQL-Project/blob/main/ERD%20DIAGRAM%20AND%20SCHEMAS/ERD%20DIAGRAM.pdf) — Database relationships.
- 🖼️ [`SCHEMAS`](https://github.com/Ahad-5887/Fix-Inventory-Inefficiencies-SQL-Project/blob/main/ERD%20DIAGRAM%20AND%20SCHEMAS/SCHEMAS.sql) — Database schema.

---

## 👨‍💻 Author
- ✍️ Ahad Ansari

---
