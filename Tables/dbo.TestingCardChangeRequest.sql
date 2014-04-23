CREATE TABLE [dbo].[TestingCardChangeRequest]
(
[TestingCardChangeRequestID] [int] NOT NULL IDENTITY(1, 1),
[ReasonID] [int] NULL,
[ReasonDescription] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TestingCardID] [int] NULL,
[Number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TestingCardNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VIN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarModel] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarSerialNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Odometer] [decimal] (8, 2) NULL,
[OwnerName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OwnerIDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsValid] [bit] NULL,
[IsFirstTesting] [bit] NULL,
[FirnishNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirnishDate] [date] NULL,
[Comment] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NULL,
[CreateDate] [datetime] NULL,
[QualityManagerConfirmStatusID] [int] NULL,
[QualityManagerConfirmDate] [datetime] NULL,
[QualityManagerPersonID] [int] NULL,
[AdministratorConfirmStatusID] [int] NULL,
[AdministratorConfirmDate] [datetime] NULL,
[AdministratorPersonID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] ADD CONSTRAINT [PK_TestingCardChangeRequest] PRIMARY KEY CLUSTERED  ([TestingCardChangeRequestID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardChangeRequest_ConfirmStatus1] FOREIGN KEY ([AdministratorConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] ADD CONSTRAINT [FK_TestingCardChangeRequest_Person3] FOREIGN KEY ([AdministratorPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardChangeRequest_ConfirmStatus] FOREIGN KEY ([QualityManagerConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardChangeRequest_Person] FOREIGN KEY ([QualityManagerPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] ADD CONSTRAINT [FK_TestingCardChangeRequest_ChangeRequestReason] FOREIGN KEY ([ReasonID]) REFERENCES [dbo].[ChangeRequestReason] ([ChangeRequestReasonID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] ADD CONSTRAINT [FK_TestingCardChangeRequest_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[TestingCardChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardChangeRequest_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
