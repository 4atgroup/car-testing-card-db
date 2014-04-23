CREATE TABLE [dbo].[TestingCardFileChangeRequest]
(
[TestingCardChangeRequestID] [int] NOT NULL,
[TestingCardID] [int] NOT NULL,
[FileID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardFileChangeRequest] ADD CONSTRAINT [PK_TestingCardFileChangeRequest] PRIMARY KEY CLUSTERED  ([TestingCardChangeRequestID], [FileID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardFileChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardFileChangeRequest_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[TestingCardFileChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardFileChangeRequest_TestingCardChangeRequest] FOREIGN KEY ([TestingCardChangeRequestID]) REFERENCES [dbo].[TestingCardChangeRequest] ([TestingCardChangeRequestID])
GO
ALTER TABLE [dbo].[TestingCardFileChangeRequest] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardFileChangeRequest_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
