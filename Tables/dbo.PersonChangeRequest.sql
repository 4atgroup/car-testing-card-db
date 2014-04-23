CREATE TABLE [dbo].[PersonChangeRequest]
(
[PersonChangeRequestID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NULL,
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
[EffectiveDate] [datetime] NOT NULL CONSTRAINT [DF_PersonChangeRequest_UpdateDate] DEFAULT (getdate()),
[CreateDate] [datetime] NOT NULL,
[QualityManagerConfirmStatusID] [int] NULL,
[AdministratorConfirmStatusID] [int] NULL,
[QualityManagerPersonID] [int] NULL,
[QualityManagerConfirmDate] [datetime] NULL,
[AdministratorConfirmDate] [datetime] NULL,
[AdministratorPersonID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonChangeRequest] ADD CONSTRAINT [PK_PersonChangeRequest_1] PRIMARY KEY CLUSTERED  ([PersonChangeRequestID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_AccountType] FOREIGN KEY ([AccountTypeID]) REFERENCES [dbo].[AccountType] ([AccountTypeID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_AdminConfirmStatus] FOREIGN KEY ([AdministratorConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_AdminPerson] FOREIGN KEY ([AdministratorPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_QualityManagerConfirmStatus] FOREIGN KEY ([QualityManagerConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonChangeRequest_QualityManagerPerson] FOREIGN KEY ([QualityManagerPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonChangeRequest] ADD CONSTRAINT [FK_PersonChangeRequest_ResponsiblePerson] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
