CREATE TABLE [dbo].[PersonLeave]
(
[PersonID] [int] NOT NULL,
[StartDate] [date] NOT NULL,
[EndDate] [date] NULL,
[ResponsiblePersonID] [int] NOT NULL,
[EffectiveDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeave] ADD CONSTRAINT [PK_PersonLeave_1] PRIMARY KEY CLUSTERED  ([PersonID], [StartDate]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PersonLeave] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeave_Person1] FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[PersonLeave] WITH NOCHECK ADD CONSTRAINT [FK_PersonLeave_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
