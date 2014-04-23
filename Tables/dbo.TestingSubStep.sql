CREATE TABLE [dbo].[TestingSubStep]
(
[TestingSubStepID] [int] NOT NULL,
[TestingSubStepName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TestingStepID] [int] NULL,
[OrderNumber] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingSubStep] ADD CONSTRAINT [PK_TestingSubStep] PRIMARY KEY CLUSTERED  ([TestingSubStepID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingSubStep] ADD CONSTRAINT [FK_TestingSubStep_TestingStep] FOREIGN KEY ([TestingStepID]) REFERENCES [dbo].[TestingStep] ([TestingStepID])
GO
