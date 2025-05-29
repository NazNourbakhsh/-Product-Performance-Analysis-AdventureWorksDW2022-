CREATE VIEW vw_SalesByProductCategory AS 
SELECT cat.EnglishProductCategoryName AS ProductCategory,
sub.EnglishProductSubcategoryName AS ProductSubcategory,
SUM(f.SalesAmount) AS TotalSales
FROM FactInternetSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
JOIN DimProductSubcategory sub ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
JOIN DimProductCategory cat ON sub.ProductCategoryKey = cat.ProductCategoryKey
GROUP BY cat.EnglishProductCategoryName, sub.EnglishProductSubcategoryName;