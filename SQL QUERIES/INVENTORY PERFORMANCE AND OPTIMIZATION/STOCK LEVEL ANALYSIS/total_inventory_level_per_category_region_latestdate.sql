-- STOCK LEVEL ANALYSIS
-- total inventory per category

-- What is the total Inventory_Level per Category and Region at the latest available Date?
SELECT 
    dim_product.category,
    dim_store.Region,
    SUM(fact_inventory_sales.Inventory_Level) total_inventory_level
FROM
    fact_inventory_sales
        JOIN
    dim_product ON fact_inventory_sales.Product_ID = dim_product.Product_ID
        JOIN
    dim_store ON fact_inventory_sales.Store_Id_Region = dim_store.Store_Id_Region
        JOIN
    dim_date ON fact_inventory_sales.Date = dim_date.Date
WHERE
    dim_date.date = (SELECT 
            MAX(date)
        FROM
            dim_date)
GROUP BY category , Region
ORDER BY category , Region , total_inventory_level;
