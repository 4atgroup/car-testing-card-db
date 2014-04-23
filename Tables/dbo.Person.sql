CREATE TABLE [dbo].[Person]
(
[PersonID] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Mobile] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemIDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyID] [int] NULL,
[AccountTypeID] [int] NOT NULL,
[FileID] [int] NULL,
[Password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NOT NULL CONSTRAINT [DF_Person_UpdateDate] DEFAULT (getdate())
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [PK_Person_1] PRIMARY KEY CLUSTERED  ([PersonID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [FK_Person_AccountType] FOREIGN KEY ([AccountTypeID]) REFERENCES [dbo].[AccountType] ([AccountTypeID])
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [FK_Person_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [FK_Person_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[Person] ADD CONSTRAINT [FK_Person_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
