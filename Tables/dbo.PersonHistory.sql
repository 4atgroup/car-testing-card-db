CREATE TABLE [dbo].[PersonHistory]
(
[PersonHierarchyID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NOT NULL,
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Mobile] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemIDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyID] [int] NOT NULL,
[AccountTypeID] [int] NOT NULL,
[FileID] [int] NULL,
[Password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NOT NULL,
[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_PersonHistory_CreateDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonHistory] ADD CONSTRAINT [PK_PersonHistory] PRIMARY KEY CLUSTERED  ([PersonHierarchyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonHistory_AccountType] FOREIGN KEY ([AccountTypeID]) REFERENCES [dbo].[AccountType] ([AccountTypeID])
GO
ALTER TABLE [dbo].[PersonHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonHistory_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO
ALTER TABLE [dbo].[PersonHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonHistory_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[PersonHistory] ADD CONSTRAINT [FK_PersonHistory_Person1] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonHistory_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
