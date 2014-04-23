CREATE TABLE [dbo].[PersonScheduleChangeRequest]
(
[PersonScheduleChangeRequestID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NULL,
[ResponsiblePersonID] [int] NULL,
[CreateDate] [datetime] NULL,
[QualityManagerConfirmStatusID] [int] NULL,
[QualityManagerConfirmDate] [datetime] NULL,
[QualityManagerPersonID] [int] NULL,
[AdministratorConfirmStatusID] [int] NULL,
[AdministratorConfirmDate] [datetime] NULL,
[AdministratorPersonID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] ADD CONSTRAINT [PK_PersonScheduleChangeRequest] PRIMARY KEY CLUSTERED  ([PersonScheduleChangeRequestID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleChangeRequest_AdminConfirmStatus] FOREIGN KEY ([AdministratorConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] ADD CONSTRAINT [FK_PersonScheduleChangeRequest_Person2] FOREIGN KEY ([AdministratorPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleChangeRequest_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleChangeRequest_QualityManagerConfirmStatus] FOREIGN KEY ([QualityManagerConfirmStatusID]) REFERENCES [dbo].[ConfirmStatus] ([ConfirmStatusID])
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] ADD CONSTRAINT [FK_PersonScheduleChangeRequest_Person3] FOREIGN KEY ([QualityManagerPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleChangeRequest_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
