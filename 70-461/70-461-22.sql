USE AdventureWorks2012;

CREATE PROCEDURE Production.up_Category_Insert
	@Name nvarchar(50)
AS
INSERT INTO Production.ProductCategory(Name)
VALUES(@Name);
SELECT SCOPE_IDENTITY();

DROP PROCEDURE Production.up_Category_Insert;

DECLARE @Name nvarchar(50) = 'Createdfrom';
EXEC Production.up_Category_Insert @Name;
