--Testing unique constraint
--EmailAddress must be unique
--Second insert should fail
INSERT INTO dbo.Customers (Name,EmailAddress)
	VALUES ('Christopher', 'test@trainsignal.com');

INSERT INTO dbo.Customers (Name,EmailAddress)
	VALUES ('Christopher', 'test@trainsignal.com');

--Test Foreign Key constraint
--First will fail, second will succeed
INSERT INTO dbo.Orders (CustomerID, OrderDate, ShipDate)
	VALUES (2, '1/1/2012', '2/1/2012');

INSERT INTO dbo.Orders (CustomerID, OrderDate, ShipDate)
	VALUES (1, '1/1/2012', '2/1/2012');

-- Test check constraint
-- ShipDate is before OrderDate
INSERT INTO dbo.Orders (CustomerID, OrderDate, ShipDate)
	VALUES (1, '1/1/2012', '2/1/2011');

--Test the default constraint
	INSERT INTO dbo.Orders (CustomerID)
	VALUES (1);

SELECT *
FROM dbo.Orders;