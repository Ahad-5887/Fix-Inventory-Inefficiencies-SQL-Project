-- Weather and Competitor Pricing Influence

-- Analyze the impact of different Weather_Conditions on Units_Sold for specific Categorys (e.g., do Units_Sold for groceries increase during "Rainy" days?).
WITH A AS (SELECT dim_product.category Category, SUM(fact_inventory_sales.Units_Sold) Sales , fact_inventory_sales.Weather_Condition
from fact_inventory_sales join dim_product on dim_product.Product_ID = fact_inventory_sales.Product_ID
GROUP BY Category, Weather_Condition)
SELECT 
	Category,
    Sales,
    Weather_Condition,
    row_number() over (PARTITION BY Category order by Sales desc) AS rankings
    from A
    GRouP BY Category, Weather_Condition;


-- Investigate the relation between Competitor_Pricing and your Units_Sold and Price for similar products.
SELECT 
    dim_product.Product_ID,
    dim_product.Category,
    AVG(Units_Sold),
    ROUND(AVG(Price), 2) OurPrice,
    ROUND(AVG(Competitor_Pricing), 2) CompPrice
FROM
    fact_inventory_sales
        JOIN
    dim_product ON dim_product.Product_ID = fact_inventory_sales.Product_ID
GROUP BY Product_ID , Category;


