USE AdventureWorks2012;


SELECT COUNT(*) AS 'TotalContacts'
	, COUNT(MiddleName) AS 'ContactsWihtMiddleName'
FROM Person.Person;


SELECT SUM(soh.TotalDue) AS 'SalesAmount'
	, st.Name
	, st.[Group]
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
	, st.[Group];

-- regels in de inner join van de vorige
SELECT *
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID;


SELECT SUM(soh.TotalDue) AS 'SalesAmount'
	, st.Name
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
HAVING SUM(soh.TotalDue) > 18000000;

SELECT SUM(soh.TotalDue) AS 'SalesAmount'
	, st.Name
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
WHERE st.Name IN ('Northwest','Southwest','Southeast','Northeast')
GROUP BY st.Name
HAVING SUM(soh.TotalDue) > 18000000;

CREATE VIEW Sales.vSalesByCatgory
AS
SELECT soh.TotalDue
	, pc.Name AS Category
	, ps.Name AS SubCatetory
	, p.Name AS Product
FROM Sales.SalesOrderHeader AS soh
	INNER JOIN Sales.SalesOrderDetail AS sod ON soh.SalesOrderID = sod.SalesOrderDetailID
	INNER JOIN Production.Product AS p ON sod.ProductID = p.ProductID
	INNER JOIN Production.ProductSubCategory AS ps ON p.ProductSubCategoryID = ps.ProductSubcategoryID
	INNER JOIN Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID;

SELECT Category
	, SubCatetory
	, Product
	, SUM(TotalDue) AS 'TotalSold'
FROM Sales.vSalesByCatgory
WHERE Category = 'Clothing'
GROUP BY Category
	, SubCatetory
	, Product
WITH ROLLUP
ORDER BY Category
	, SubCatetory
	, Product;

SELECT Category
	, SubCatetory
	, Product
	, SUM(TotalDue) AS 'TotalSold'
FROM Sales.vSalesByCatgory
WHERE Category = 'Clothing'
GROUP BY Category
	, SubCatetory
	, Product
WITH CUBE
ORDER BY Category
	, SubCatetory
	, Product;

SELECT Category
	, SubCatetory
	, Product
	, SUM(TotalDue) AS 'TotalSold'
FROM Sales.vSalesByCatgory
WHERE Category = 'Clothing'
GROUP BY GROUPING SETS ((Category, SubCatetory)
	, (SubCatetory)
	, (Product))
ORDER BY Category
	, SubCatetory
	, Product;

SELECT Category
	, GROUPING(Category) AS CategoryTotal
	, SubCatetory
	, GROUPING(SubCatetory) AS SubCategoryTotal
	, Product
	, GROUPING(Product) AS ProductTotal
	, SUM(TotalDue) AS 'TotalSold'
FROM Sales.vSalesByCatgory
WHERE Category = 'Clothing'
GROUP BY Category
	, SubCatetory
	, Product
WITH CUBE
ORDER BY Category
	, SubCatetory
	, Product;

SELECT GROUPING_ID(Category, SubCatetory, Product) AS TotalBitmap
	, Category
	, SubCatetory
	, Product
	, SUM(TotalDue) AS 'TotalSold'
FROM Sales.vSalesByCatgory
WHERE Category = 'Clothing'
GROUP BY Category
	, SubCatetory
	, Product
WITH CUBE
ORDER BY Category
	, SubCatetory
	, Product;