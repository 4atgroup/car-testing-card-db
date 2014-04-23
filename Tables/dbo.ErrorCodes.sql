CREATE TABLE [dbo].[ErrorCodes]
(
[error_id] [int] NOT NULL IDENTITY(1, 1),
[description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorCodes] ADD CONSTRAINT [PK__ErrorCod__DA71E16C06CD04F7] PRIMARY KEY CLUSTERED  ([error_id]) ON [PRIMARY]
GO
