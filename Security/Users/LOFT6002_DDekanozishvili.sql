IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'LOFT6002\DDekanozishvili')
CREATE LOGIN [LOFT6002\DDekanozishvili] FROM WINDOWS
GO
CREATE USER [LOFT6002\DDekanozishvili] FOR LOGIN [LOFT6002\DDekanozishvili]
GO
