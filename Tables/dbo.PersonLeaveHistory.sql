CREATE TABLE [dbo].[PersonLeaveHistory]
(
[PersonLeaveHistoryID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NOT NULL,
[StartDate] [date] NOT NULL,
[EndDate] [date] NULL,
[ResponsiblePersonID] [int] NOT NULL,
[EffectiveDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeaveHistory] ADD CONSTRAINT [PK_PersonLeaveHistory_1] PRIMARY KEY CLUSTERED  ([PersonLeaveHistoryID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeaveHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveHistory_Person1] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeaveHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeaveHistory_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
