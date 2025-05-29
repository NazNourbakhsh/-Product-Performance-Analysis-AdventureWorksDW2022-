-- Creating views that are reusable and easier to manage in Power BI. They also abstract the logic from the report.
CREATE VIEW vw_ProductSales AS
SELECT p.EnglishProductName As Product,
SUM(f.SalesAmount) As TotalSales,
Sum(f.OrderQuantity) As TotalQuantity
From FactInternetSales f
JOIN  DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName;

