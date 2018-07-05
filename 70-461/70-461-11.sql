USE AdventureWorks2012;

INSERT INTO Production.ProductCategory
		(Name
		, rowguid
		, ModifiedDate
		)
VALUES ('Widgets', NEWID(), GETDATE())
		,
		('MoreWidgets', NEWID(), GETDATE());

SELECT *
FROM Production.ProductCategory;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.1
	, ModifiedDate = GETDATE()
FROM Production.Product AS p
	INNER JOIN Production.ProductSubcategory AS ps
		ON p.ProductSubcategoryID = ps.ProductSubcategoryID
WHERE ps.ProductCategoryID = 1;

SELECT Name
	, ProductsubcategoryID
	, ModifiedDate
FROM Production.Product
ORDER BY ModifiedDate DESC;

SELECT *
FROM Production.ProductCategory;

DELETE FROM Production.ProductCategory
WHERE ProductCategoryID > 4;