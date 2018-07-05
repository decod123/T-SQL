USE AdventureWorks2012;

SELECT pc.Name AS 'ProductCategoryName'
	, ps.Name AS 'ProductSubCategoryName'
FROM Production.ProductCategory AS pc
	INNER JOIN Production.ProductSubcategory AS ps
	ON pc.ProductCategoryID = ps.ProductCategoryID
FOR XML RAW('ProductCategory'), ROOT('ProductCategories'), ELEMENTS;

SELECT Category.Name AS 'CategoryName'
	, SubCategory.Name AS 'SubCategoryName'
FROM Production.ProductCategory AS Category
	INNER JOIN Production.ProductSubcategory AS SubCategory
	ON Category.ProductCategoryID = SubCategory.ProductCategoryID
FOR XML AUTO, ROOT('Categories'), ELEMENTS;

SELECT pc.ProductCategoryID AS '@ID'
	, pc.Name
FROM Production.ProductCategory AS pc
FOR XML PATH('Category'), ROOT('Categories');

