--detach database
sp_detach_db 'NewDatabase', 'true';

SELECT * FROM sys.databases;

--attach database
CREATE DATABASE NewDatabase
ON (FILENAME = 'D:\rdsdbdata\DATA\NewDatabase_Data.mdf')
FOR ATTACH ;

--filegroups
SELECT * FROM sys.filegroups;
SELECT * FROM sys.database_files;
SELECT * FROM sys.data_spaces;

SELECT df.file_id, df.name, ds.name AS Filegroup
FROM sys.database_files AS df
INNER JOIN sys.data_spaces AS ds
ON df.data_space_id = ds.data_space_id;

--move database files
ALTER DATABASE [Food]
MODIFY FILE
(
name = Food_Data,
filename = 'D:\RDSDBDATA\DATA\Food_Data.mdf'
);

--select all filenames of all databases
SELECT * FROM sys.master_files;

--restart database
USE master;

ALTER DATABASE [ExistingDatabase]
SET offline;

ALTER DATABASE [ExistingDatabase]
SET online;