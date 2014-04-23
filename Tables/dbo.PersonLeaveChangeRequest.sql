CREATE TABLE [dbo].[PersonLeaveChangeRequest]
(
[PersonLeaveChangeRequestID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NOT NULL,
[StartDate] [date] NOT NULL,
[EndDate] [date] NULL,
[ResponsiblePersonID] [int] NOT NULL,
[EffectiveDate] [datetime] NOT NULL,
[CreateDate] [datetime] NOT NULL,
[QualityManagerConfirmStatusID] [int] NULL,
[QualityManagerConfirmDate] [datetime] NULL,
[QualityManagerPersonID] [int] NULL,
[AdministratorConfirmStatusID] [int] NULL,
[AdministratorConfirmDate] [datetime] NULL,
[AdministratorPersonID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] ADD CONSTRAINT [PK_PersonLeaveChangeRequest_1] PRIMARY KEY CLUSTERED  ([PersonLeaveChangeRequestID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveChangeRequest_ConfirmStatus1] FOREIGN KEY ([AdministratorConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] ADD CONSTRAINT [FK_PersonLeaveChangeRequest_Person3] FOREIGN KEY ([AdministratorPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveChangeRequest_Person1] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveChangeRequest_ConfirmStatus] FOREIGN KEY ([QualityManagerConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] ADD CONSTRAINT [FK_PersonLeaveChangeRequest_Person4] FOREIGN KEY ([QualityManagerPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveChangeRequest_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeaveChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveChangeRequest_Person2] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
