CREATE TABLE [dbo].[PersonScheduleHistory]
(
[PersonScheduleHistoryID] [int] NOT NULL IDENTITY(1, 1),
[PersonID] [int] NOT NULL,
[WeekDayNumber] [int] NOT NULL,
[StartTime] [time] (0) NULL,
[EndTime] [time] (0) NULL,
[BreakStartTime] [time] (0) NULL,
[BreakEndTime] [time] (0) NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NOT NULL,
[CreateDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleHistory] ADD CONSTRAINT [PK_PersonScheduleHistory] PRIMARY KEY CLUSTERED  ([PersonScheduleHistoryID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleHistory_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonScheduleHistory] WITH NOCHECK ADD CONSTRAINT [FK_PersonScheduleHistory_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
