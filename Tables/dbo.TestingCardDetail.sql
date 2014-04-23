CREATE TABLE [dbo].[TestingCardDetail]
(
[TestingCardID] [int] NOT NULL,
[TestingSubStepID] [int] NOT NULL,
[IsInvalid] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetail_IsValid] DEFAULT ((0)),
[IsChecked] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetail_IsChecked] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetail] ADD CONSTRAINT [PK_TestingCardDetail] PRIMARY KEY CLUSTERED  ([TestingCardID], [TestingSubStepID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetail] ADD CONSTRAINT [FK_TestingCardDetail_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
ALTER TABLE [dbo].[TestingCardDetail] ADD CONSTRAINT [FK_TestingCardDetail_TestingSubStep] FOREIGN KEY ([TestingSubStepID]) REFERENCES [dbo].[TestingSubStep] ([TestingSubStepID])
GO
