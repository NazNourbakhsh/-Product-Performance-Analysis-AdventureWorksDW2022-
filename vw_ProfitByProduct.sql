CREATE VIEW vw_ProfitByProduct AS
SELECT p.EnglishProductName AS Product,
SUM(f.SalesAmount) AS TotalSales,
SUM(f.TotalProductCost) AS TotalCost,
SUM(f.SalesAmount - f.TotalProductCost) AS GrossProfit
FROM FactInternetSales f
JOIN DimProduct p ON p.ProductKey = f.ProductKey
GROUP BY p.EnglishProductName;