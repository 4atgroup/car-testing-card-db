CREATE TABLE [dbo].[TestingStep]
(
[TestingStepID] [int] NOT NULL,
[TestingStepName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OrderNumber] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingStep] ADD CONSTRAINT [PK_TestingStep] PRIMARY KEY CLUSTERED  ([TestingStepID]) ON [PRIMARY]
GO
