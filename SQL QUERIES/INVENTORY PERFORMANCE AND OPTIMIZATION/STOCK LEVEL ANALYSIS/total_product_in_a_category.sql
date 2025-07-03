-- total products in a category

SELECT 
    Category, COUNT(Product_ID) total_products
FROM
    ps1.dim_product
GROUP BY Category
ORDER BY total_products DESC;