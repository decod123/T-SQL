USE AdventureWorks2012;

-- subquery
-- show difference between product price en average product price
SELECT Name
	, ListPrice
	, ListPrice - (SELECT AVG(ListPrice) FROM Production.Product) AS DifferenceFromAverage
FROM Production.Product;

-- create a dynamic table
-- subquery in a FROM line
-- show list price compared to the average for that subcategory
SELECT p.Name
	, p.ProductSubcategoryID
	, p.ListPrice
	, ap.AverageListPrice
	, p.ListPrice - ap.AverageListPrice AS DifferenceFromAverage
FROM Production.Product AS p
	INNER JOIN (SELECT ProductSubcategoryID
				, AVG(ListPrice) AS AverageListPrice
				FROM Production.Product
				GROUP BY ProductSubcategoryID) AS ap
	ON p.ProductSubcategoryID = ap.ProductSubcategoryID;

-- subquery in a WHERE line
-- all customers who have placed an order
-- IN statement
SELECT c.PersonID
FROM Sales.Customer AS c
WHERE c.CustomerID IN (SELECT soh.CustomerID 
						FROM Sales.SalesOrderHeader AS soh);
-- CustomerID has to be linked to info person table

-- EXISTS statement
SELECT c.PersonID
FROM Sales.Customer AS c
WHERE EXISTS (SELECT soh.CustomerID 
					FROM Sales.SalesOrderHeader AS soh
					WHERE soh.CustomerID = c.CustomerID);

-- UNION statement (DISTINCT)
-- retreive all names and email addresses from Contact and ProductReview
SELECT FirstName + ' ' + LastName AS 'FullName'
FROM Person.Person	
UNION ALL
SELECT ReviewerName
FROM Production.ProductReview;
