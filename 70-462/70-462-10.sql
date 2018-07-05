USE master;

sp_configure 'show advanced options', 1;
reconfigure;
--show advanced options
--backup compression default
--blocked process threshold (s)
--clr enabled
--Database Mail XPs
--fill factor (%)
--max degree of parallelism
--remote access
--remote admin connections
--xp cmdshell

--Change authentication modes (to Windows only authentication in this case)
USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 1
GO
