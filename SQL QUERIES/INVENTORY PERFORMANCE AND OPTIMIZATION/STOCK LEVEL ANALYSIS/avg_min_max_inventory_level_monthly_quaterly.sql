-- STOCK LEVEL ANALYSIS
-- What are the average, minimum, and maximum Inventory_Level (product units available at the beginning of the day) for each Product_Id across all Store_Ids on a monthly or quarterly basis?

-- Quarter wise
SELECT dim_product.Product_ID ,round(avg(fact_inventory_sales.Inventory_Level)) Average_Inventory_Level, min(fact_inventory_sales.Inventory_Level) Min_Inventory_Level, max(fact_inventory_sales.Inventory_Level) Max_Inventory_Level, dim_date.Quarter, dim_date.Year Year
from fact_inventory_sales join dim_product
on fact_inventory_sales.Product_ID = dim_product.Product_ID
JOIN dim_store on dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
JOIN dim_date on dim_date.Date = fact_inventory_sales.date
GROUP BY dim_date.Quarter, dim_date.Year, dim_product.Product_ID
order by Year, dim_product.Product_ID, Quarter;

-- Monthly wise
SELECT dim_product.Product_ID ,round(avg(fact_inventory_sales.Inventory_Level)) Average_Inventory_Level, min(fact_inventory_sales.Inventory_Level) Min_Inventory_Level, max(fact_inventory_sales.Inventory_Level) Max_Inventory_Level, dim_date.Month, dim_date.Year Year
from fact_inventory_sales join dim_product
on fact_inventory_sales.Product_ID = dim_product.Product_ID
JOIN dim_store on dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
JOIN dim_date on dim_date.Date = fact_inventory_sales.date
GROUP BY dim_date.Month, dim_date.Year, dim_product.Product_ID
order by Year, dim_product.Product_ID, Month;

