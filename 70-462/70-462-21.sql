USE AdventureWorks2012;

--detecting defragmentation
SELECT * FROM sys.dm_db_index_physical_stats(NULL, NULL, NULL, NULL, NULL)
--DBId, ObjectId,IndexId,Partition, Mode
--Object_Name(Object_Id) as ObjName, Database_Id DB_ID('CompressionDemo') 