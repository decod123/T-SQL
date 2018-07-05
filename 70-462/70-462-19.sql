USE AdventureWorks2012;

--RPO recovery point objective
--RTO recovery time objective

--full backups
BACKUP DATABASE AdventureWorks2012
TO DISK = 'c:\MyDBs\AdventureWorks2012.bak'
WITH INIT, FORMAT, STATS = 10;
--INIT initialize, creates a new file, otherwize more backups in one file
--FORMAT formats the file everytime, also the header
-- STATS = 10 shows completion stats as it's going, show every 10 percent

--striping backup over two files, needs FORMAT!
BACKUP DATABASE AdventureWorks2012
TO
	DISK = 'c:\MyDBs\AdventureWorks2012.bak',
	DISK = 'c:\MyDBs\AdventureWorks2012-2.bak'
WITH INIT, FORMAT, STATS = 10;

--Log backups
BACKUP LOG AdventureWorks2012
TO DISK = 'c:\MyDBs\AdventureWorks2012-1.trn'
WITH STATS = 10;

BACKUP LOG AdventureWorks2012
TO DISK = 'c:\MyDBs\AdventureWorks2012-2.trn'
WITH STATS = 10;

--differential backup
--differential bakcup files are cumulative
BACKUP DATABASE AdventureWorks2012
TO DISK = 'c:\MyDBs\AdventureWorks2012.bak'
WITH INIT, FORMAT, STATS = 10, DIFFERENTIAL;

--filegroup backups
BACKUP DATABASE AdventureWorks2012
FILEGROUP = 'FG1',
FILEGROUP = 'FG2'
TO DISK = 'c:\MyDBs\AdventureWorks2012.bak'
WITH INIT, FORMAT, STATS = 10;

--system backups
BACKUP DATABASE master
TO DISK = 'c:\MyDBs\master.bak'
WITH INIT, FORMAT, STATS = 10;
--model (not that important), msdb, tempdb (fails)

--system log backups
BACKUP LOG msdb
TO DISK = 'c:\MyDBs\master.trn'
WITH INIT, FORMAT, STATS = 10;