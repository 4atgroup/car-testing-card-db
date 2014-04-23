CREATE TABLE [dbo].[TestingCardFile]
(
[TestingCardID] [int] NOT NULL,
[FileID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardFile] ADD CONSTRAINT [PK_TestingCardFile] PRIMARY KEY CLUSTERED  ([TestingCardID], [FileID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCardFile] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardFile_File] FOREIGN KEY ([FileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[TestingCardFile] WITH NOCHECK ADD CONSTRAINT [FK_TestingCardFile_TestingCard] FOREIGN KEY ([TestingCardID]) REFERENCES [dbo].[TestingCard] ([TestingCardID])
GO
