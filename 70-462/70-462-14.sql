DROP DATABASE Logtest;

CREATE DATABASE Logtest
ON
(
NAME = LogtestData1,
FILENAME = 'D:\RDSDBDATA\DATA\LogtestData1.mdf'
)
LOG ON
(
NAME = LogtestLog1,
FILENAME = 'D:\RDSDBDATA\DATA\LogtestLog1.ldf'
);

ALTER DATABASE Logtest
SET RECOVERY SIMPLE;

USE Logtest;

CREATE TABLE TLogtest
(
Column1 int
);

--inspect log usage
DBCC SQLPERF(logspace);

--check the logWaitDesc before the op.
SELECT name, recovery_model_desc, log_reuse_wait_desc FROM sys.databases;

--generate log activity in the Logtest DB
BEGIN TRAN
INSERT Logtest..TLogtest
SELECT * FROM AdventureWorks2012.Production.Product
UNION ALL
SELECT * FROM AdventureWorks2012.Production.Product
UNION ALL
SELECT * FROM AdventureWorks2012.Production.Product;


--don't commit the tran just yet
COMMIT TRAN;
SELECT @@trancount;