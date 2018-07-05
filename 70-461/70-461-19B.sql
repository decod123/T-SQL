CREATE DATABASE ExistingDatabase;
GO
USE ExistingDatabase;

CREATE TABLE dbo.Customers
	(
	CustomerID int NOT NULL IDENTITY(1,1),
	Name varchar(100) NOT NULL,
	EmailAddress varchar(100)
	);
GO
CREATE TABLE dbo.Orders
	(
	OrderID int NOT NULL IDENTITY(1,1),
	OrderDate date NOT NULL,
	ShipDate date NULL,
	CustomerID int NOT NULL
	);
GO

ALTER TABLE dbo.Orders
ADD CONSTRAINT DF_OrderDate_CurrentDate DEFAULT GETDATE() FOR OrderDate;

ALTER TABLE dbo.Orders
ADD CONSTRAINT CK_Orders_ShipDateIsNullOrAfterOrderDate CHECK(ShipDate IS NULL OR ShipDate >= OrderDate);

ALTER TABLE dbo.Customers
ADD CONSTRAINT AK_Customers_EmailAdress UNIQUE(EmailAddress);

ALTER TABLE dbo.Customers
ADD CONSTRAINT PK_Customers_CustomerID PRIMARY KEY(CustomerID);

ALTER TABLE dbo.Orders
ADD CONSTRAINT PK_Orders_OrderID PRIMARY KEY(OrderID);

ALTER TABLE dbo.Orders
ADD CONSTRAINT FK_Orders_Customers_CustomerID FOREIGN KEY(CustomerID) REFERENCES dbo.Customers(CustomerID);