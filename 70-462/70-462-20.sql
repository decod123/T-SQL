USE AdventureWorks2012;

--simple full restore
RESTORE DATABASE AdventureWorks2012
FROM DISK = 'c:\AdventureWorks.bak'
WITH REPLACE, STATS = 10;

--restore with move
RESTORE FILELISTONLY
FROM DISK = 'c:\AdventureWorks.bak'

RESTORE DATABASE AdventureWorks2012
FROM DISK = 'c:\AdventureWorks.bak'
WITH
MOVE 'AdventureWorks2012' TO 'C:\MyDBs\AdventureWorks2012.mdf',
MOVE 'AdventureWorks2012Log' TO 'C:\MyDBs\AdventureWorks2012Log.ldf',
REPLACE, STATS = 10;

--restore under a different name
RESTORE FILELISTONLY
FROM DISK = 'c:\AdventureWorks.bak'

RESTORE DATABASE AdventureWorks2012-2
FROM DISK 'c:\AdventureWorks.bak'
WITH
MOVE 'AdventureWorks2012' TO 'C:\MyDBs\AdventureWorks2012-2.mdf',
MOVE 'FG1File' TO 'C:\MyDBs\FG1File-2.ndf',
MOVE 'FG2File' TO 'C:\MyDBs\FG2File-2.ndf',
MOVE 'FG3File' TO 'C:\MyDBs\FG3File-2.ndf',
MOVE 'FG4File' TO 'C:\MyDBs\FG4File-2.ndf',
MOVE 'AdventureWorks2012Log' TO 'C:\MyDBs\AdventureWorks2012Log-2.ldf',
REPLACE, STATS = 10;

--restoring Logs
RESTORE DATABASE AdventureWorks2012
FROM DISK = 'c:\AdventureWorks.bak'
WITH
STATS = 10, NORECOVERY;

RESTORE LOG AdventureWorks2012
FROM DISK = 'c:\AdventureWorksLog1.trn'
WITH
STATS = 10, NORECOVERY;

RESTORE LOG AdventureWorks2012
FROM DISK = 'c:\AdventureWorksLog2.trn'
WITH
STATS = 10, NORECOVERY;

RESTORE LOG AdventureWorks2012
FROM DISK = 'c:\AdventureWorksLog3.trn'
WITH
STATS = 10, NORECOVERY;

RESTORE DATABASE AdventureWorks2012
WITH RECOVERY;

-- replace NoRecovery with standby = 'c:\MyDBs\Restore.txt'
-- puts unfinished transactions in a file and makes DB read only

--restore differentials
--after restoring the DB, restore the last differential backup
RESTORE DATABASE AdventureWorks2012
FROM DISK = 'c:\AdventureWorks.diff'
WITH
STATS = 10, NORECOVERY;
--after that, restore logs