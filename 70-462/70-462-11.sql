USE AdventureWorks2012;

DBCC DropCleanBuffers;

DBCC ShrinkDatabase(N'DemoDatabase', 10);

sp_helpfile;

DBCC ShrinkFile('masterlog', 5);

DBCC FreeProcCache;

DBCC CheckDB(AdventureWorks2012);

ALTER DATABASE AdventureWorks2012
SET single_user;
DBCC CheckDB(AdventureWorks2012, repair_allow_data_loss);
--Schedule a job?, because of backing up corruption
DBCC CheckTable;

DBCC SQLPerf(logspace);

DBCC InputBuffer(70);

SELECT * FROM dbo.Customers;

SELECT * FROM sys.sysprocesses;

--Help: books online
DBCC help('checkdb');
DBCC help('?');
--search internet for undocumented DBCC
