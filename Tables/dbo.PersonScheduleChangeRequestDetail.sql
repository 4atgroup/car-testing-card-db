CREATE TABLE [dbo].[PersonScheduleChangeRequestDetail]
(
[PersonScheduleChangeRequestID] [int] NOT NULL,
[WeekDayNumber] [int] NOT NULL,
[StartTime] [time] (0) NULL,
[EndTime] [time] (0) NULL,
[BreakStartTime] [time] (0) NULL,
[BreakEndTime] [time] (0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequestDetail] ADD CONSTRAINT [PK_PersonScheduleChangeRequestDetails] PRIMARY KEY CLUSTERED  ([PersonScheduleChangeRequestID], [WeekDayNumber]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonScheduleChangeRequestDetail] ADD CONSTRAINT [FK_PersonScheduleChangeRequestDetails_PersonScheduleChangeRequest] FOREIGN KEY ([PersonScheduleChangeRequestID]) REFERENCES [dbo].[PersonScheduleChangeRequest] ([PersonScheduleChangeRequestID])
GO
