USE DemoDatabase;

SELECT *
FROM sys.databases;

--AutoClose; deallocates all objects from memory for a specified database
SELECT name, is_auto_close_on
FROM sys.databases;

ALTER DATABASE [DemoDatabase]
SET auto_close on;

ALTER DATABASE [DemoDatabase]
SET auto_close off;

--AutoShrink; automatically shrinks a database every 30 minutes, but can cause severe fragmentation
SELECT name, is_auto_shrink_on
FROM sys.databases;

ALTER DATABASE [DemoDatabase]
SET auto_shrink on;

ALTER DATABASE [DemoDatabase]
SET auto_shrink off;

--Recovery models; simple, bulk logged, full
SELECT name, recovery_model_desc
FROM sys.databases;

ALTER DATABASE [DemoDatabase]
SET recovery BULK_LOGGED;
--options: SIMPLE, BULK_LOGGED, FULL

--statistics
SELECT name, is_auto_update_stats_on, is_auto_update_stats_async_on
FROM sys.databases;

ALTER DATABASE [DemoDatabase]
SET auto_update_statistics_async on;

ALTER DATABASE [DemoDatabase]
SET auto_update_statistics_async off;

--restricting access
ALTER DATABASE [DemoDatabase]
SET multi_user;
--options: single_user, restricted_user, multi_user
