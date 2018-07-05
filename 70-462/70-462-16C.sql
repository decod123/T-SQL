USE AdventureWorks2012;

SELECT * FROM sys.sysprocesses
WHERE blocked > 0;

SELECT * FROM sys.dm_tran_locks;

dbcc inputbuffer(72);