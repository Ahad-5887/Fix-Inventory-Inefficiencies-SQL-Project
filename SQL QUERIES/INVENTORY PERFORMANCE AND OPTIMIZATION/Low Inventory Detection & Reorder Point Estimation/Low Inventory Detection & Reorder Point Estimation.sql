-- Low Inventory Detection & Reorder Point Estimation

-- Identify Product_Id and Store_Id combinations where the Inventory_Level_Region (beginning of day stock) falls below a predefined reorder point or a calculated safety stock threshold, indicating potential stockouts
-- ASSUMPTIONS - Lead Time (1 Days), Service Level (90%) Z- Score = 1.28

WITH ProductStoreDemandMetrics AS (
    SELECT
        fis.Product_ID,
        fis.Store_Id_Region,
        AVG(fis.Units_Sold) AS Avg_Daily_Demand,
        STDDEV(fis.Units_Sold) AS StdDev_Daily_Demand
    FROM
        fact_inventory_sales as fis
    GROUP BY
        fis.Product_ID,
        fis.Store_Id_Region
),
CalculatedReorderPoints AS (
    SELECT
        pm.Product_ID,
        pm.Store_Id_Region,
        (1.28 * pm.StdDev_Daily_Demand * SQRT(1)) AS Safety_Stock, -- LT = 1 day and z-score (90%)=1.28
        ((pm.Avg_Daily_Demand * 1) + (1.28 * pm.StdDev_Daily_Demand * SQRT(1))) AS Reorder_Point -- LT = 1 day
    FROM
        ProductStoreDemandMetrics pm
)
SELECT
    fis.Product_ID,
    fis.Store_Id_Region,
    dd.Date AS Observation_Date,
    fis.Inventory_Level,
    crp.Reorder_Point,
    crp.Safety_Stock,
    fis.Units_Sold,
    fis.Demand_Forecast,
    CASE
        WHEN fis.Inventory_Level < crp.Reorder_Point THEN 'Below Reorder Point (Potential Stockout)'
        ELSE 'Above Reorder Point'
    END AS Stock_Status
FROM
    fact_inventory_sales fis
JOIN
    dim_date dd ON fis.Date = dd.Date
JOIN
    CalculatedReorderPoints crp
    ON fis.Product_ID = crp.Product_ID AND fis.Store_Id_Region = crp.Store_Id_Region
WHERE
    fis.Inventory_Level < crp.Reorder_Point 

ORDER BY
    fis.Product_ID, fis.Store_Id_Region, dd.Date;
    
-- Number Of potential Stock Out Events
WITH ProductStoreDemandMetrics AS (
    SELECT
        fis.Product_ID,
        fis.Store_Id_Region, 
        AVG(fis.Units_Sold) AS Avg_Daily_Demand,
        STDDEV(fis.Units_Sold) AS StdDev_Daily_Demand
    FROM
        fact_inventory_sales fis
    GROUP BY
        fis.Product_ID,
        fis.Store_Id_Region 
),
CalculatedReorderPoints AS (
    SELECT
        pm.Product_ID,
        pm.Store_Id_Region,
        (1.28 * pm.StdDev_Daily_Demand * SQRT(1)) AS Safety_Stock, -- LT = 1 day
        ((pm.Avg_Daily_Demand * 1) + (1.28 * pm.StdDev_Daily_Demand * SQRT(1))) AS Reorder_Point -- LT = 1 day
    FROM
        ProductStoreDemandMetrics pm
)
SELECT
    fis.Product_ID,
    fis.Store_Id_Region, 
    COUNT(*) AS Number_Of_Potential_Stockout_Events
FROM
    fact_inventory_sales fis
JOIN
    CalculatedReorderPoints crp
    ON fis.Product_ID = crp.Product_ID AND fis.Store_Id_Region = crp.Store_Id_Region
WHERE
    fis.Inventory_Level < crp.Reorder_Point
GROUP BY
    fis.Product_ID,
    fis.Store_Id_Region
ORDER BY
    Number_Of_Potential_Stockout_Events DESC;