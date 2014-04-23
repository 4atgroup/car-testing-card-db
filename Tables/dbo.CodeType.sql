CREATE TABLE [dbo].[CodeType]
(
[CodeTypeID] [int] NOT NULL,
[TItle] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CodeType] ADD CONSTRAINT [PK_CodeType] PRIMARY KEY CLUSTERED  ([CodeTypeID]) ON [PRIMARY]
GO
