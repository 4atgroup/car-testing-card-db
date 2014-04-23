IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'WebUser')
CREATE LOGIN [WebUser] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [WebUser] FOR LOGIN [WebUser]
GO
