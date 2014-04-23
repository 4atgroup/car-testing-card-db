CREATE TABLE [dbo].[AccountType]
(
[AccountTypeID] [int] NOT NULL IDENTITY(1, 1),
[AccountTypeName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountType] ADD CONSTRAINT [PK_AccountType] PRIMARY KEY CLUSTERED  ([AccountTypeID]) ON [PRIMARY]
GO
