CREATE TABLE [dbo].[TestingCardDetailHistory]
(
[TestingCardHistoryID] [int] NOT NULL,
[TestingCardID] [int] NOT NULL,
[TestingSubStepID] [int] NOT NULL,
[IsInvalid] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetailHistory_IsValid] DEFAULT ((0)),
[IsChecked] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetailHistory_IsChecked] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetailHistory] ADD CONSTRAINT [PK_TestingCardDetailHistory_1] PRIMARY KEY CLUSTERED  ([TestingCardHistoryID], [TestingSubStepID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetailHistory] ADD CONSTRAINT [FK_TestingCardDetailHistory_TestingCardHistory] FOREIGN KEY ([TestingCardHistoryID]) REFERENCES [dbo].[TestingCardHistory] ([TestingCardHistoryID])
GO
ALTER TABLE [dbo].[TestingCardDetailHistory] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardDetailHistory_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
ALTER TABLE [dbo].[TestingCardDetailHistory] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardDetailHistory_TestingSubStep] FOREIGN KEY ([TestingSubStepID]) REFERENCES [dbo].[TestingSubStep] ([TestingSubStepID])
GO
