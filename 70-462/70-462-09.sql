USE AdventureWorks2012;


--Row estimate
EXEC sp_estimate_data_compression_savings 'Production', 'Product', NULL, NULL, 'ROW';
--Page estimate
EXEC sp_estimate_data_compression_savings 'Production', 'Product', NULL, NULL, 'PAGE';


--compression
ALTER TABLE [Production].[Product] REBUILD PARTITION = ALL
WITH
(
DATA_COMPRESSION = Row --Page, None
);


--Simplest partition table
CREATE TABLE T1
	(
	col1 int
	);

SELECT * FROM sys.partitions
WHERE OBJECT_NAME([object_id]) = 'T1';


--Create filegroups and commit files to filegroups (for each)
ALTER DATABASE DemoDatabase
ADD FILEGROUP [FG1];

ALTER DATABASE DemoDatabase
ADD FILE
(
NAME = FG1File,
FILENAME = 'C:\MyDBs\FG1File.ndf'
) TO FILEGROUP FG1;

--Create partitions function and add to filegroups
CREATE PARTITION FUNCTION myrangePF1 (int)
AS RANGE LEFT FOR VALUES (1, 500, 1000);

CREATE PARTITION SCHEME myrangePS1
AS PARTITION myrangePF1
TO (FG1, FG2, FG3, FG4);

--Apply the partition (ID is column)
CREATE CLUSTERED INDEX clustID ON dbo.T1(ID)
ON myrangePS1(ID);

--Look partitions up.
SELECT * FROM sys.partitions
WHERE OBJECT_NAME([object_id]) = 'T1';

--Switch data between partitions
--Tables have to be identical (e.g. both a clustered index and both in the same file group (disk location))
ALTER TABLE dbo.T1
SWITCH PARTITION 4
TO dbo.CustomersArchive PARTITION 1;