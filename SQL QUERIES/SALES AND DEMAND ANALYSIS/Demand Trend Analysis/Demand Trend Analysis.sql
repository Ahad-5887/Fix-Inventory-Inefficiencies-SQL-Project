-- SALES AND DEMAND ANALYSIS
-- Demand Trend Analysis

-- Analyze how Units_Sold and Demand_Forecast vary by Seasonality for different Categorys. 
WITH SalesAndDemand AS (SELECT SUM(Units_Sold) total_sales, ROUND(SUM(Demand_Forecast)) expected_demand, Seasonality, Category
from fact_inventory_sales
join dim_date on dim_date.date = fact_inventory_sales.date
join dim_product on dim_product.product_id = fact_inventory_sales.Product_ID
GROUP BY Category, Seasonality
order by sum(Units_Sold) DESC)
SELECT 
	Category, 
    Seasonality, 
    total_sales, 
    expected_demand, 
    row_number() over (partition by Category order by total_sales desc) AS Ranking
from SalesAndDemand
group by Category, Seasonality
order by Category, Ranking;

-- What are the peak and off-peak seasons for various product groups? 
WITH SalesAndDemand AS (SELECT SUM(Units_Sold) total_sales, ROUND(SUM(Demand_Forecast)) expected_demand, Seasonality, Category, dim_product.Product_ID
from fact_inventory_sales
join dim_date on dim_date.date = fact_inventory_sales.date
join dim_product on dim_product.product_id = fact_inventory_sales.Product_ID
GROUP BY Product_ID, Category, Seasonality
order by sum(Units_Sold) DESC),
RankingofSalesAndDemand AS (SELECT Product_Id , Category, Seasonality, total_sales, expected_demand, row_number() over (partition by Product_Id order by total_sales desc) AS Ranking
from SalesAndDemand
group by Category, Seasonality, Product_Id
order by Product_Id, Ranking)
SELECT 
	Product_Id, 
    Category, 
    Seasonality, 
    total_sales, 
    expected_demand, 
    Ranking
FROM RankingofSalesAndDemand;
-- ALL PRODUCT OF RESPECTIVE CATEGORY HAS PEAK IN THERE WINTERS AN THEN SUMMER BUT IN PRODUCT (P0094) IT  HAS PEAK IN SUMMER AND THEN WINTER
-- PEAK SEASON ARE WINTER AND SUMMER
-- OFF PEAK SEASON ARE AUTUMN AND Spring
-- winter > summer > autumn > spring