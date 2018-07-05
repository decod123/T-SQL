USE AdventureWorks2012;

WITH SalesData(TotalSold, OrderYear, TerritoryName)
AS (
	SELECT SUM(soh.TotalDue) AS 'TotalSold'
		, YEAR(soh.OrderDate) AS 'OrderYear'
		, st.Name AS 'TerritoryName'
	FROM Sales.SalesOrderHeader AS soh
	INNER JOIN Sales.SalesTerritory AS st ON soh.TerritoryID = st.TerritoryID
	GROUP BY YEAR(soh.OrderDate)
		, st.Name
	)
SELECT *
FROM SalesData
	PIVOT (SUM(TotalSold)
		FOR OrderYear IN ([2005], [2006], [2007], [2008])) AS pvt;

-- retrieve all people who have placed an order
SELECT CustomerID
FROM Sales.Customer
INTERSECT
SELECT CustomerID
FROM Sales.SalesOrderHeader;

-- retrieve all people who have not placed an order
SELECT CustomerID
FROM Sales.Customer
EXCEPT
SELECT CustomerID
FROM Sales.SalesOrderHeader;

-- intersect with CTE (common table expression)
WITH ContactsWithOrders
AS (
	SELECT CustomerID
	FROM Sales.Customer
	INTERSECT
	SELECT CustomerID
	FROM Sales.SalesOrderHeader
	)
SELECT c.FirstName
	, c.LastName
	, c.EmailAddress
FROM Sales.Customer AS c
	INNER JOIN ContactsWithOrders AS cwo ON c.CustomerID = cwo.CustomerID;

-- ORDER BY
SELECT TOP 10 FirstName
	, LastName
	, EmailPromotion
FROM Person.Person
ORDER BY LastName DESC
	, FirstName DESC;
