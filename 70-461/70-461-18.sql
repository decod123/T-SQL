CREATE DATABASE DemoDatabase;

USE DemoDatabase;

CREATE TABLE Orders
	(
	OrderID int NOT NULL,
	OrderDate date NOT NULL,
	ShippingDate date NULL
	);

SELECT *
FROM Orders;

ALTER TABLE Orders
ADD CustomerID int NOT NULL;

ALTER TABLE Orders
ALTER COLUMN OrderDate datetime NOT NULL; 

ALTER TABLE Orders
DROP COLUMN CustomerID;