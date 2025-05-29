CREATE VIEW vw_SalesByMonth AS 
SELECT FORMAT(d.FullDateAlternateKey, 'yyyy-MM') AS [Month],
Sum(f.SalesAmount) AS MonthlySales
FROM FactInternetSales f
JOIN DimDate d ON d.DateKey = f.OrderDateKey
GROUP BY FORMAT(d.FullDateAlternateKey, 'yyyy-MM');