USE AdventureWorks2012;

CREATE VIEW HumanResources.vEmployeeList
AS
	SELECT c.FirstName,
			c.LastName,
			c.EmailPromotion,
			e.HireDate
	FROM Person.Person AS c
		INNER JOIN HumanResources.Employee AS e ON c.BusinessEntityID = e.BusinessEntityID;

SELECT LastName + ', ' + Firstname AS 'FullName',
	EmailPromotion,
	HireDate
FROM HumanResources.vEmployeeList
WHERE LastName LIKE 'H%'
ORDER BY LastName;