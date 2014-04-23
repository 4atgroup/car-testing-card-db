CREATE TABLE [dbo].[PersonDay]
(
[PersonID] [int] NOT NULL,
[AttendanceDate] [date] NOT NULL,
[StartTime] [time] (0) NULL,
[EndTime] [time] (0) NULL,
[BreakStartTime] [time] (0) NULL,
[BreakEndTime] [time] (0) NULL,
[IsLeave] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonDay] ADD CONSTRAINT [PK_PersonDay] PRIMARY KEY CLUSTERED  ([PersonID], [AttendanceDate]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonDay] WITH NOCHECK ADD CONSTRAINT [FK_PersonDay_Person] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
