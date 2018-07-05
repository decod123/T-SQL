USE Adventureworks2012;

BEGIN TRY
	BEGIN TRANSACTION;

	UPDATE Production.ProductCategory
	SET Name = 'Widgets'
	WHERE ProductCategoryID = 1;

	DELETE FROM Production.ProductSubcategory
	WHERE ProductSubCategoryID = 1;

	COMMIT TRANSACTION;
END TRY
--Nothing is allowed in here.
BEGIN CATCH
	--If we're in here, we know something went wrong.
	--Rollback the transaction
	ROLLBACK TRANSACTION;
	--Error handling
	PRINT ERROR_MESSAGE();
	THROW;

END CATCH

RAISEERROR('This is an error message', 16, 1);

THROW 50000, 'This is an error message', 1;