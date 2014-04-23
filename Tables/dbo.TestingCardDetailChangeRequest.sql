CREATE TABLE [dbo].[TestingCardDetailChangeRequest]
(
[TestingCardChangeRequestID] [int] NOT NULL,
[TestingCardID] [int] NULL,
[TestingSubStepID] [int] NOT NULL,
[IsInvalid] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetailChangeRequest_IsValid] DEFAULT ((0)),
[IsChecked] [bit] NOT NULL CONSTRAINT [DF_TestingCardDetailChangeRequest_IsChecked] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetailChangeRequest] ADD CONSTRAINT [PK_TestingCardDetailChangeRequest_1] PRIMARY KEY CLUSTERED  ([TestingCardChangeRequestID], [TestingSubStepID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardDetailChangeRequest] ADD CONSTRAINT [FK_TestingCardDetailChangeRequest_TestingCardChangeRequest] FOREIGN KEY ([TestingCardChangeRequestID]) REFERENCES [dbo].[TestingCardChangeRequest] ([TestingCardChangeRequestID])
GO
ALTER TABLE [dbo].[TestingCardDetailChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardDetailChangeRequest_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
ALTER TABLE [dbo].[TestingCardDetailChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardDetailChangeRequest_TestingSubStep] FOREIGN KEY ([TestingSubStepID]) REFERENCES [dbo].[TestingSubStep] ([TestingSubStepID])
GO
