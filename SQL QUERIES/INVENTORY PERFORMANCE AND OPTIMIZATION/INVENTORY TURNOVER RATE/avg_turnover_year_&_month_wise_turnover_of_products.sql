-- INVENTORY TURNOVER RATE
-- Calculate the inventory turnover rate for each Product_Id (e.g., SUM(Units_Sold) / AVG(Inventory_Level) over a specific period).

-- avy inventory turnover of products in year 2022 & 2023
-- this can be used to identify fast selling top poroducts
select Product_ID, Category, AVG(inventory_turnover) avg_turnover, YEAR from
(SELECT dim_product.Product_ID, dim_product.Category, SUM(fact_inventory_sales.Units_Sold) /
AVG(fact_inventory_sales.Inventory_Level) inventory_turnover, dim_date.month, dim_date.year
from dim_product join fact_inventory_sales
on dim_product.Product_ID = fact_inventory_sales.Product_ID
join dim_date on dim_date.date = fact_inventory_sales.date
GROUP BY Product_ID, month, YEAR
order by inventory_turnover desc) as a
group by Product_ID, Category, YEAR
order by avg_turnover desc;

-- month wise inventory turnover of individual products of year 2022 & 2023
-- this can be used to analyze turnover trend of any product month wise
SELECT dim_product.Product_ID, dim_product.Category,(SUM(fact_inventory_sales.Units_Sold) /
AVG(fact_inventory_sales.Inventory_Level)) inventory_turnover, dim_date.month, dim_date.year
from dim_product join fact_inventory_sales
on dim_product.Product_ID = fact_inventory_sales.Product_ID
join dim_date on dim_date.date = fact_inventory_sales.date
GROUP BY Product_ID, month, year
order by inventory_turnover desc;