-- Supplier Performance
-- Order Fulfillment and Discrepancies

-- By analyzing the relationship between Units_Ordered (number of units ordered for restocking on that day), subsequent Inventory_Level changes, and Units_Sold, can you infer potential supplier delivery delays or incomplete orders that lead to stockouts or affect inventory availability?
WITH DailyInventoryChanges AS (
    SELECT
        Date,
        Product_Id AS Product_ID,
        Store_Id_Region AS Store_Id_Region,
        Inventory_Level AS Inventory_Level,
        Units_Sold AS Units_Sold,
        Units_Ordered AS Units_Ordered,
        LAG(Inventory_Level, 1) OVER (PARTITION BY Product_Id, Store_Id_Region ORDER BY Date) AS Previous_Day_Inventory_Level
    FROM
        Fact_Inventory_Sales
),
CalculatedFulfillment AS (
    SELECT
        Date,
        Product_ID,
        Store_Id_Region,
        Inventory_Level,
        Units_Sold,
        Units_Ordered,
        Previous_Day_Inventory_Level,
        (Inventory_Level - Previous_Day_Inventory_Level + Units_Sold) AS Calculated_Inflow
    FROM
        DailyInventoryChanges
    WHERE
        Previous_Day_Inventory_Level IS NOT NULL
)
SELECT
    Date,
    Product_ID,
    Store_Id_Region,
    Units_Ordered,
    Calculated_Inflow,
    (Units_Ordered - Calculated_Inflow) AS Order_Fulfillment_Discrepancy,
    Inventory_Level,
    Units_Sold,
    CASE
        WHEN (Units_Ordered - Calculated_Inflow) > 15 THEN 'Potential Under-Fulfillment'
        WHEN (Units_Ordered - Calculated_Inflow) < -15 THEN 'Potential Over-Fulfillment/Return'
        ELSE 'Normal Fulfillment'
    END AS Fulfillment_Status,
    CASE
        WHEN Inventory_Level <= 30 AND Units_Ordered > 0 AND (Units_Ordered - Calculated_Inflow) > 0 THEN 'Potential Stockout'
        ELSE 'Normal Inventory'
    END AS Stockout_Status
FROM
    CalculatedFulfillment
WHERE
    ABS(Units_Ordered - Calculated_Inflow) > 15
    OR (Inventory_Level <= 30 AND Units_Ordered > 0 AND (Units_Ordered - Calculated_Inflow) > 0)
ORDER BY
    Order_Fulfillment_Discrepancy DESC, Date, Product_ID, Store_Id_Region;