CREATE TABLE [dbo].[CompanyChangeRequest]
(
[CompanyChangeRequestID] [int] NOT NULL IDENTITY(1, 1),
[CompanyID] [int] NULL,
[CompanyName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactPersonID] [int] NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationScope] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationExpireDate] [datetime] NULL,
[ResponsiblePersonID] [int] NOT NULL,
[EffectiveDate] [datetime] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[QualityManagerConfirmStatusID] [int] NULL,
[QualityManagerConfirmDate] [datetime] NULL,
[QualityManagerPersonID] [int] NULL,
[AdministratorConfirmStatusID] [int] NULL,
[AdministratorConfirmDate] [datetime] NULL,
[AdministratorPersonID] [int] NULL,
[Address] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyChangeRequest] ADD CONSTRAINT [PK_CompanyChangeRequest] PRIMARY KEY CLUSTERED  ([CompanyChangeRequestID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_CompanyChangeRequest_ConfirmStatus1] FOREIGN KEY ([AdministratorConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] ADD CONSTRAINT [FK_CompanyChangeRequest_Person2] FOREIGN KEY ([AdministratorPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_CompanyChangeRequest_Company] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company] ([CompanyID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_CompanyChangeRequest_Person] FOREIGN KEY ([ContactPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_CompanyChangeRequest_ConfirmStatus] FOREIGN KEY ([QualityManagerConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] ADD CONSTRAINT [FK_CompanyChangeRequest_Person3] FOREIGN KEY ([QualityManagerPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[CompanyChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_CompanyChangeRequest_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
