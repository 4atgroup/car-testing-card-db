IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'LOFT6002\KKatselashvili')
CREATE LOGIN [LOFT6002\KKatselashvili] FROM WINDOWS
GO
CREATE USER [LOFT6002\KKatselashvili] FOR LOGIN [LOFT6002\KKatselashvili]
GO
