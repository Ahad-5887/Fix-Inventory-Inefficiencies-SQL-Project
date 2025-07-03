-- StockOut_OverStock_Analysis

-- Identify specific Product_Ids that frequently experience stockouts, leading to missed sales and poor customer experience.
SELECT 
    dim_product.Product_ID,
    dim_store.Store_Id_Region,
    COUNT(fact_inventory_sales.Product_ID) Times_StockOut
FROM
    dim_product
        JOIN
    fact_inventory_sales ON dim_product.Product_ID = fact_inventory_sales.Product_ID
        JOIN
    dim_date ON dim_date.date = fact_inventory_sales.date
        JOIN
    dim_store ON dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
WHERE
    Inventory_Level < Units_Sold
GROUP BY Product_ID , Store_Id_Region;

-- Identify Product_Ids that are consistently overstocked, contributing to increased warehousing costs and locked working capital.
SELECT 
    dim_product.Product_ID,
    dim_store.Store_Id_Region,
    COUNT(fact_inventory_sales.Product_ID) Times_OverStock
FROM
    dim_product
        JOIN
    fact_inventory_sales ON dim_product.Product_ID = fact_inventory_sales.Product_ID
        JOIN
    dim_date ON dim_date.date = fact_inventory_sales.date
        JOIN
    dim_store ON dim_store.Store_Id_Region = fact_inventory_sales.Store_Id_Region
WHERE
    Inventory_Level > Units_Sold
        AND (Inventory_Level - Units_Sold) > (SELECT 
            (1.28 * STDDEV(Units_Sold) * SQRT(1))
        FROM
            fact_inventory_sales)
GROUP BY Product_ID , Store_Id_Region;
