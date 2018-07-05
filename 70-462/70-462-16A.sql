USE AdventureWorks2012;

BEGIN TRAN
SELECT * FROM Person.Address (xlock)
WHERE PostalCode BETWEEN '75001' AND '76200'
--goto blocking 2 before commiting
COMMIT TRAN;

--update
BEGIN TRAN
UPDATE Person.Address
SET PostalCode = '75001'
WHERE PostalCode BETWEEN '75001' AND '76200'
--goto blocking 2 before commiting
ROLLBACK;

SET NOCOUNT ON
WHILE 1 = 1
BEGIN
DELETE TOP(10)
FROM Person.Address
WHERE PostalCode BETWEEN '75001' AND '76200'
END;