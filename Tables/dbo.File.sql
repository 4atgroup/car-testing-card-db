CREATE TABLE [dbo].[File]
(
[FileID] [int] NOT NULL IDENTITY(1, 1),
[FileName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FilePath] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[File] ADD CONSTRAINT [PK_File] PRIMARY KEY CLUSTERED  ([FileID]) ON [PRIMARY]
GO
