CREATE TABLE [dbo].[ChangeRequestReason]
(
[ChangeRequestReasonID] [int] NOT NULL,
[Title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChangeRequestReason] ADD CONSTRAINT [PK_ChangeRequestReason] PRIMARY KEY CLUSTERED  ([ChangeRequestReasonID]) ON [PRIMARY]
GO
