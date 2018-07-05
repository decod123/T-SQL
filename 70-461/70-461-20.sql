DROP DATABASE DemoDatabase;

CREATE DATABASE DemoDatabase;

USE DemoDataBase;

CREATE TABLE dbo.Customers
	(
	CustomerID int IDENTITY(1,1) NOT NULL,
	Name varchar(50) NOT NULL,
	IsActive bit NOT NULL CONSTRAINT DF_Customers_IsActive DEFAULT(1),
	CONSTRAINT PK_Customers_CustomerID PRIMARY KEY(CustomerID)
	);

CREATE TABLE dbo.CustomersArchive
	(
	CustomerID int NOT NULL,
	OldName varchar(50) NOT NULL,
	NewName varchar(50) NOT NULL
	);


CREATE TRIGGER I_D_Customers_MarkCustomersAsInactive
ON dbo.Customers
INSTEAD OF DELETE
AS
	BEGIN
		SET NOCOUNT ON; --suppress the number of rows affected
		
		UPDATE dbo.Customers
		SET IsActive = 0
		FROM dbo.Customers AS c
			INNER JOIN deleted AS d ON c.CustomerID = d.CustomerID;
	END;


INSERT INTO dbo.Customers(Name)
VALUES ('Christopher');

SELECT *
FROM dbo.Customers;

DELETE FROM dbo.Customers
WHERE CustomerID = 1;

CREATE TRIGGER A_U_Customers_CustomersArchiveChanges
ON dbo.Customers
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON; --suppress the number of rows affected
		
	INSERT INTO dbo.CustomersArchive(CustomerID, OldName, NewName)
	SELECT i.CustomerID,
		d.Name, --old name
		i.Name --new name
		FROM deleted AS d
		INNER JOIN inserted AS i ON d.CustomerID = i.CustomerID
			AND d.Name <> i.Name --ensure the name has changed;
END;


INSERT INTO dbo.Customers(Name)
VALUES ('Brian');

UPDATE dbo.Customers
SET Name = 'Dave'
WHERE Name = 'Brian';

SELECT *
FROM dbo.CustomersArchive;

--test modification of data that does not change the name