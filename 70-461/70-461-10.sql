USE AdventureWorks2012;

SELECT FirstName
	, LastName
FROM Person.Person
WHERE LastName = 'Harrison';


DECLARE @sql nvarchar(500) = 'SELECT FirstName , LastName FROM Person.Person WHERE LastName = @LastName';
DECLARE @paramdef nvarchar(500) = '@LastName nvarchar(50)';
EXECUTE sp_executesql @sql, @paramdef, @LastName = 'Harrison';