USE	AdventureWorks2012;

SELECT Firstname
	, ISNULL(MiddleName, 'Not available') AS 'IsnullMiddlename'
	, COALESCE(MiddleName, 'Not available') AS 'IsnullMiddlename'
	, LastName
FROM Person.Person;

SELECT MAX(soh.OrderDate) AS 'MostRecentOrderDate' 
	, YEAR(MAX(soh.OrderDate)) AS 'MostRecentOrderYear'
	, DATEPART(YEAR, MAX(soh.OrderDate)) AS 'MostRecentOrderYearDatePart'
	, c.CustomerID
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID;


SELECT DATEDIFF(day, MAX(soh.OrderDate), GETDATE()) AS 'DaysSinceLastOrder'
	, c.CustomerID
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.Customer AS c ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID;

SELECT EOMONTH(GETDATE());

SELECT CHARINDEX('speaker', 'Setting up surround sound involves a lot of speakers and lots of cable');
SELECT PATINDEX('%speaker%', 'Setting up surround sound involves a lot of speakers and lots of cable');

SELECT CONCAT(Name, ' costs ', ListPrice) AS 'Display'
FROM Production.Product
WHERE ListPrice > 0;

SELECT Name + ' costs ' + CAST(ListPrice AS nvarchar) AS 'Display'
FROM Production.Product
WHERE ListPrice > 0;

SELECT TRY_PARSE('1/100/2017' AS date);

SELECT CHOOSE(3, 'Item 1', 'Item 2', 'Item 3');

SELECT CHOOSE(3, FirstName, LastName, FirstName + ' ' + LastName)
FROM Person.Person;

SELECT IIF(ListPrice > 0, 'Normal product', 'Internal component') AS ProductInfor
	, Name
FROM Production.Product;