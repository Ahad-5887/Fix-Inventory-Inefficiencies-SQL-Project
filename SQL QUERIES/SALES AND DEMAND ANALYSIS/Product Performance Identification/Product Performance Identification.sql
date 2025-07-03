-- B. Sales & Demand Analysis
-- Product Performance Identification:

-- Rank the fast-selling Product_Ids (by total Units_Sold) overall, and within each Category.
WITH RecentSalesByCategory AS (
    SELECT
        dim_product.Product_ID,
        dim_product.Category,
        fis.Units_Sold
    FROM
        fact_inventory_sales fis
	JOIN 
		dim_product on dim_product.Product_Id = fis.Product_Id)
    SELECT
        Product_ID,
        Category,
        SUM(Units_Sold) AS Total_Units_Sold,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY SUM(Units_Sold) DESC) AS Rank_Within_Category
    FROM
        RecentSalesByCategory
    GROUP BY
        Product_ID,
        Category
	ORDER BY
    Category, Rank_Within_Category;