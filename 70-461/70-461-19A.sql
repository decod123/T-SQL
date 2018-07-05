CREATE DATABASE NewDatabase;
GO
USE NewDatabase;

CREATE TABLE dbo.Customers
	(
	CustomerID int NOT NULL IDENTITY(1,1),
	Name varchar(100) NOT NULL,
	EmailAddress varchar(100) CONSTRAINT AK_Customers_EmailAdress UNIQUE,
	CONSTRAINT PK_Customers_CustomerID PRIMARY KEY(CustomerID)
	);
GO
CREATE TABLE dbo.Orders
	(
	OrderID int NOT NULL IDENTITY(1,1),
	OrderDate date NOT NULL CONSTRAINT DF_OrderDate_CurrentDate DEFAULT GetDate(),
	ShipDate date NULL,
	CustomerID int NOT NULL,
	CONSTRAINT CK_Orders_ShipDateIsNullOrAfterOrderDate CHECK(ShipDate IS NULL OR ShipDate >= OrderDate),
	CONSTRAINT PK_Orders_OrderID PRIMARY KEY(OrderID),
	CONSTRAINT FK_Orders_Customers_CustomerID FOREIGN KEY(CustomerID) REFERENCES dbo.Customers(CustomerID)
	);
GO