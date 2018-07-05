USE [DemoDatabase];

CREATE USER [Mylogin] FOR LOGIN [Mylogin] WITH DEFAULT_SCHEMA=[dbo];
CREATE USER [Mylogin2] FOR LOGIN [Mylogin2] WITH DEFAULT_SCHEMA=[dbo];

CREATE PROCEDURE sp1
AS
SELECT @@SERVERNAME;

--change context
EXECUTE AS USER = 'Mylogin';

sp1

--revert context
revert;

-- give permissions to user, globally or to table
GRANT EXECUTE TO [Mylogin];
GRANT SELECT, DELETE, INSERT ON [dbo].[T1] TO [Mylogin];

--create role
CREATE ROLE [ROWeb];

--add user to role
ALTER ROLE [ROWeb]
ADD MEMBER [Mylogin];



--add permissions to roles
GRANT EXECUTE TO [ROWeb];

--create a schema with owner
CREATE SCHEMA [MoDe] AUTHORIZATION [Mylogin];

--create table in schema
CREATE TABLE MoDe.Table2
(
Col1 int
);

--grant rights to shcema, mylogin is already owner
GRANT EXECUTE ON SCHEMA::MoDe TO [Mylogin2];


ALTER AUTHORIZATION ON dbo.T1 TO [dbo];

--Query system objects
SELECT * FROM sys.objects;
SELECT * FROM sys.schemas;

--alter the owner of a table
ALTER AUTHORIZATION ON dbo.T1 TO [Mylogin];

--alter the owner of a schema
ALTER AUTHORIZATION ON SCHEMA::MoDe TO [Mylogin];
-- :: is a scope qualifier

--permissions chains

CREATE PROCEDURE spCustoQuery
AS
SELECT * FROM dbo.Customers;

GRANT EXECUTE ON spCustoQuery TO [Mylogin];
DENY SELECT ON dbo.Customers TO [Mylogin];

EXECUTE AS USER = 'Mylogin';

--denied if Mylogin is not owner of schema dbo
SELECT * FROM dbo.Customers;
--still runs, implied permission, 1 check because of same owner
spCustoQuery;

revert;

--look out for unintended privilege escalation!