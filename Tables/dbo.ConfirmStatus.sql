CREATE TABLE [dbo].[ConfirmStatus]
(
[ConfirmStatusID] [int] NOT NULL IDENTITY(1, 1),
[ConfirmStatusName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConfirmStatus] ADD CONSTRAINT [PK_ConfirmStatus] PRIMARY KEY CLUSTERED  ([ConfirmStatusID]) ON [PRIMARY]
GO
