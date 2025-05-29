USE AdventureWorksDW2022;
GO
-- First List all tables, and then preview important tables 
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
SELECT TOP 10 * FROM FactInternetSales;
SELECT TOP 10 * FROM DimProduct;
SELECT TOP 10 * FROM DimProductCategory;
SELECT TOP 10 * FROM DimProductSubcategory;

-- Define Total Sales and Quantity per product that shows the top-selling products in revenue and volume  which is core KPI
SELECT p.EnglishProductName As Product,
SUM(f.SalesAmount) As TotalSales,
Sum(f.OrderQuantity) As TotalQuantity
From FactInternetSales f
JOIN  DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
ORDER BY TotalSales DESC; 

-- Gross profit by product, product with high sales might have low profit. This helps business stakeholders prioritize.
SELECT p.EnglishProductName AS Product,
SUM(f.SalesAmount) AS TotalSales,
SUM(f.TotalProductCost) AS TotalCost,
SUM(f.SalesAmount - f.TotalProductCost) AS GrossProfit
FROM FactInternetSales f
JOIN DimProduct p ON p.ProductKey = f.ProductKey
GROUP BY p.EnglishProductName
ORDER BY GrossProfit DESC;

-- Monthly Sales Trend, this trend line helps visualize seasonal patterns or growth over time in Power BI
SELECT FORMAT(d.FullDateAlternateKey, 'yyyy-MM') AS [Month],
Sum(f.SalesAmount) AS MonthlySales
FROM FactInternetSales f
JOIN DimDate d ON d.DateKey = f.OrderDateKey
GROUP BY FORMAT(d.FullDateAlternateKey, 'yyyy-MM')
ORDER BY Month DESC;

-- Sales by Product Category
SELECT cat.EnglishProductCategoryName AS ProductCategory,
sub.EnglishProductSubcategoryName AS ProductSubcategory,
SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
GROUP BY cat.EnglishProductCategoryName, sub.EnglishProductSubcategoryName
ORDER BY TotalSales DESC;
