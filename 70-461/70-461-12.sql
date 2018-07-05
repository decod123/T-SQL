USE AdventureWorks2012;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
OUTPUT INSERTED.Name
	, DELETED.Listprice AS 'OldPrice'
	, INSERTED.ListPrice AS 'NewPrice'
-- INTO Table
WHERE ProductSubcategoryID = 1;

CREATE TABLE dbo.Target
(
	EmployeeID Int,
	EmployeeName nvarchar(20),
	CONSTRAINT Target_PK PRIMARY KEY(EmployeeID)
);
CREATE TABLE dbo.Source
(
	EmployeeID Int,
	EmployeeName nvarchar(20),
	CONSTRAINT Source_PK PRIMARY KEY(EmployeeID)
);
GO
INSERT INTO dbo.Target(EmployeeID, EmployeeName)
VALUES(100, 'Karin'), (101, 'Donna'), (102, 'Christopher');

INSERT INTO dbo.Source(EmployeeID, EmployeeName)
VALUES(102, 'Source Change'), (103, 'Susan'), (104, 'Dave');

MERGE dbo.Target AS T
USING dbo.Source AS S
	ON T.EmployeeID = S.EmployeeID
WHEN MATCHED THEN
	UPDATE SET T.EmployeeName = S.EmployeeName
WHEN NOT MATCHED THEN
	INSERT VALUES (S.EmployeeID, S.EmployeeName)
OUTPUT $action AS 'Action'
	, DELETED.EmployeeID AS 'OldEmployeeID'
	, DELETED.EmployeeName AS 'OldEmployeeName'
	, INSERTED.EmployeeID AS 'NewEmployeeID'
	, INSERTED.EmployeeName AS 'NewEmplyeeName';

SELECT *
FROM dbo.Target;