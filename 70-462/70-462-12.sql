USE AdventureWorks2012;

CREATE LOGIN [Pedro/Users] FROM Windows;


CREATE LOGIN [Mylogin2] WITH PASSWORD=N'1234' MUST_CHANGE
	, DEFAULT_DATABASE=[AdventureWorks2012]
	, CHECK_EXPIRATION=ON
	, CHECK_POLICY=ON;

ALTER SERVER ROLE [public]
ADD MEMBER [Mylogin2];
GO

CREATE SERVER ROLE [MyServerRole];

ALTER SERVER ROLE [MyServerRole]
ADD MEMBER [Mylogin2];
GO

sp_srvrolepermission'dbcreator';

GRANT view server state TO [Mylogin2];