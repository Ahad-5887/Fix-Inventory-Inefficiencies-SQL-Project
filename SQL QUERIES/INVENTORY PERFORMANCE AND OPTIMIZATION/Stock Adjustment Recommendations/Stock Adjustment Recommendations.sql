-- Stock Adjustment Recommendations
-- Based on your analysis of turnover, stockouts, and overstocking, which Product_Ids at which Store_Ids require specific Inventory_Level adjustments (e.g., increase order quantity, reduce order quantity, liquidate excess stock) to reduce holding costs?


with stock_out as (SELECT dim_product.Product_ID Product_Id, dim_store.Store_Id_Region, count(fact_inventory_sales.Product_ID) AS Times_StockOut
from dim_product join fact_inventory_sales on dim_product.Product_ID = fact_inventory_sales.Product_ID
join dim_date on dim_date.date = fact_inventory_sales.date
join dim_store on dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
where Inventory_Level < Units_Sold
Group By Product_ID, Store_Id_Region),

Over_Stock as (SELECT dim_product.Product_ID Product_Id, dim_store.Store_Id_Region, count(fact_inventory_sales.Product_ID) AS Times_OverStock
from dim_product join fact_inventory_sales on dim_product.Product_ID = fact_inventory_sales.Product_ID
join dim_date on dim_date.date = fact_inventory_sales.date
join dim_store on dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
where Inventory_Level > Units_Sold and (Inventory_Level - Units_Sold) > (select (1.28 * stddev(Units_Sold) * sqrt(1)) from fact_inventory_sales) -- safe_stock here
Group By Product_ID, Store_Id_Region),

monthly_turnover as (SELECT dim_product.Product_ID Product_Id, dim_product.Category,(SUM(fact_inventory_sales.Units_Sold) /
AVG(fact_inventory_sales.Inventory_Level)) AS inventory_turnover, dim_date.month, dim_date.year
from dim_product join fact_inventory_sales
on dim_product.Product_ID = fact_inventory_sales.Product_ID
join dim_date on dim_date.date = fact_inventory_sales.date
GROUP BY Product_ID, month, year
order by inventory_turnover desc),

Products as (Select Product_Id, Category from dim_Product)

SELECT Products.Product_Id Product_Id, Products.Category ,AVG(Over_Stock.Times_OverStock) Times_OverStock, AVG(Stock_Out.Times_StockOut) Times_StockOut, AVG(monthly_turnover.inventory_turnover) Turnover
from monthly_turnover join Over_Stock on Over_Stock.Product_Id = monthly_turnover.Product_Id
join Stock_Out on Stock_Out.Product_Id = monthly_turnover.Product_Id
join Products on Products.Product_Id = monthly_turnover.Product_Id
Group by Product_Id;



