USE AdventureWorks2012;

--blocking 2
SELECT * FROM Person.Address --with no lock
WHERE PostalCode = '75012';