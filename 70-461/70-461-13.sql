USE AdventureWorks2012;

BEGIN TRANSACTION

UPDATE Person.Person
	SET Lastname = 'Harrison';

SELECT FirstName
	, LastName
FROM Person.Person;

ROLLBACK TRANSACTION;