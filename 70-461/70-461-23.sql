USE AdventureWorks2012;

--User defined functions

CREATE FUNCTION Sales.uf_MostRecentCustomerOrderDate(@CustomerID int)
	RETURNS datetime
AS
BEGIN;
	DECLARE @MostRecentOrderDate datetime;

	SELECT @MostRecentOrderDate = MAX(OrderDate)
	FROM Sales.SalesOrderHeader
	WHERE CustomerID = @CustomerID;

	RETURN @MostRecentOrderDate;
END;

SELECT Sales.uf_MostRecentCustomerOrderDate(11344);


CREATE FUNCTION Sales.uf_CustomersOrderDates(@CustomerID int)
	RETURNS TABLE
AS
RETURN
	SELECT OrderDate
	FROM Sales.SalesOrderHeader
	WHERE CustomerID = @CustomerID;

SELECT OrderDate
FROM Sales.uf_CustomersOrderDates(11334);


CREATE FUNCTION Sales.uf_ContactOrderDetails(@ContactsWithOrders bit)
	RETURNS @ContactOrderDetails TABLE (CustomerID int)
AS
BEGIN
	IF @ContactsWithOrders = 1
	BEGIN
		INSERT INTO @ContactOrderDetails
		SELECT CustomerID
		FROM Sales.Customer AS c
		WHERE EXISTS (SELECT * FROM Sales.SalesOrderHeader AS soh WHERE c.CustomerID = soh.CustomerID);
	END
	ELSE
	BEGIN
		INSERT INTO @ContactOrderDetails
		SELECT CustomerID
		FROM Sales.Customer AS c
		WHERE NOT EXISTS (SELECT * FROM Sales.SalesOrderHeader AS soh WHERE c.CustomerID = soh.CustomerID);
	END	
	RETURN;
END;

SELECT CustomerID
FROM Sales.uf_ContactOrderDetails(0);


SELECT c.CustomerID,
	sod.Orderdate
FROM Sales.Customer AS c
	CROSS APPLY Sales.uf_CustomersOrderDates(c.CustomerID) AS sod;