CREATE DATABASE ps1;
CREATE TABLE `dim_date` (
  `date` varchar(255) NOT NULL,
  `Seasonality` text,
  `Day_of_Week` int DEFAULT NULL,
  `Month` int DEFAULT NULL,
  `Quarter` int DEFAULT NULL,
  `Year` int DEFAULT NULL,
  PRIMARY KEY (`date`)
);
CREATE TABLE `dim_product` (
  `Product_ID` varchar(255) NOT NULL,
  `Category` text,
  PRIMARY KEY (`Product_ID`)
);
CREATE TABLE `dim_store` (
  `Store_ID` text,
  `Region` text,
  `Store_Id_Region` varchar(255) NOT NULL,
  PRIMARY KEY (`Store_Id_Region`)
);
CREATE TABLE `fact_inventory_sales` (
  `date` varchar(255) DEFAULT NULL,
  `Product_ID` varchar(255) DEFAULT NULL,
  `Store_Id_Region` varchar(255) DEFAULT NULL,
  `Inventory_Level` int DEFAULT NULL,
  `Units_Sold` int DEFAULT NULL,
  `Units_Ordered` int DEFAULT NULL,
  `Demand_Forecast` float DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Discount` int DEFAULT NULL,
  `Weather_Condition` text,
  `Holiday/Promotion` int DEFAULT NULL,
  `Competitor_Pricing` float DEFAULT NULL,
  KEY `date` (`date`),
  KEY `Product_ID` (`Product_ID`),
  KEY `Store_Id_Region` (`Store_Id_Region`),
  CONSTRAINT `fact_inventory_sales_ibfk_1` FOREIGN KEY (`date`) REFERENCES `dim_date` (`date`),
  CONSTRAINT `fact_inventory_sales_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `dim_product` (`Product_ID`),
  CONSTRAINT `fact_inventory_sales_ibfk_3` FOREIGN KEY (`Store_Id_Region`) REFERENCES `dim_store` (`Store_Id_Region`)
);