CREATE TABLE [dbo].[CompanyHistory]
(
[CompanyHistoryID] [int] NOT NULL IDENTITY(1, 1),
[CompanyID] [int] NOT NULL,
[CompanyHistoryName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactPersonID] [int] NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationScope] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationExpireDate] [datetime] NULL,
[ResponsiblePersonID] [int] NOT NULL,
[EffectiveDate] [datetime] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[Address] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyHistory] ADD CONSTRAINT [PK_CompanyHistory] PRIMARY KEY CLUSTERED  ([CompanyHistoryID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyHistory] WITH NOCHECK ADD CONSTRAINT [FK_CompanyHistory_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO
ALTER TABLE [dbo].[CompanyHistory] WITH NOCHECK ADD CONSTRAINT [FK_CompanyHistory_Person] FOREIGN KEY ([ContactPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyHistory] ADD CONSTRAINT [FK_CompanyHistory_Person2] FOREIGN KEY ([ContactPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyHistory] WITH NOCHECK ADD CONSTRAINT [FK_CompanyHistory_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyHistory] ADD CONSTRAINT [FK_CompanyHistory_Person3] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
