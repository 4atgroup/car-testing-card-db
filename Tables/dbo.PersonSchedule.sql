CREATE TABLE [dbo].[PersonSchedule]
(
[PersonID] [int] NOT NULL,
[WeekDayNumber] [int] NOT NULL,
[StartTime] [time] (0) NULL,
[EndTime] [time] (0) NULL,
[BreakStartTime] [time] (0) NULL,
[BreakEndTime] [time] (0) NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonSchedule] ADD CONSTRAINT [PK_PersonSchedule] PRIMARY KEY CLUSTERED  ([PersonID], [WeekDayNumber]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonSchedule] WITH NOCHECK ADD CONSTRAINT [FK_PersonSchedule_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonSchedule] ADD CONSTRAINT [FK_PersonSchedule_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
