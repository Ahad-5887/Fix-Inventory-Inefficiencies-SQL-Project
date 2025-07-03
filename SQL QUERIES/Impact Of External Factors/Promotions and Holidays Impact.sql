-- Impact of External Factors
-- Promotions and Holidays Impact

-- Quantify the average uplift in Units_Sold during Holiday/Promotion periods (where Holiday/Promotion = 1) compared to non-promotion periods for key Categorys.
WITH CategorySales AS (
    SELECT
        dim_product.Category,
        fis.Units_Sold,
        fis.`Holiday/Promotion`
    FROM
        fact_inventory_sales fis
	JOIN dim_product on dim_product.Product_ID = fis.Product_ID
),
AggregatedCategorySales AS (
    SELECT
        Category,
        AVG(CASE WHEN `Holiday/Promotion` = 1 THEN Units_Sold ELSE NULL END) AS Avg_Units_Sold_Promotion,
        AVG(CASE WHEN `Holiday/Promotion` = 0 THEN Units_Sold ELSE NULL END) AS Avg_Units_Sold_NonPromotion
    FROM
        CategorySales
    GROUP BY
        Category
)
SELECT
    Category,
    Avg_Units_Sold_Promotion,
    Avg_Units_Sold_NonPromotion,
    (Avg_Units_Sold_Promotion - Avg_Units_Sold_NonPromotion) AS Uplift_Absolute,
    CASE
        WHEN Avg_Units_Sold_NonPromotion > 0 THEN ((Avg_Units_Sold_Promotion - Avg_Units_Sold_NonPromotion) / Avg_Units_Sold_NonPromotion) * 100
        ELSE NULL 
    END AS Uplift_Percentage
FROM
    AggregatedCategorySales
ORDER BY
    Uplift_Percentage DESC;
    
-- How does Discount influence Units_Sold across different products and categories?
SELECT 
    dim_product.Category,
    dim_product.Product_ID,
    AVG(Discount) AS Avg_Discount,
    SUM(Units_Sold) AS Total_Units_Sold,
    AVG(Units_Sold) AS Avg_Units_Sold
FROM 
    fact_inventory_sales
JOIN 
    dim_product
    ON fact_inventory_sales.Product_ID = dim_product.Product_ID
GROUP BY 
    Category, Product_ID
ORDER BY 
    Category, Avg_Discount DESC;
    
-- Total Units Sold w.r.t. Discount
SELECT 
    Discount, 
    SUM(Units_Sold) AS Total_Units_Sold
FROM 
    fact_inventory_sales
GROUP BY 
    Discount
ORDER BY 
    Discount;
