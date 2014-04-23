CREATE TABLE [dbo].[Code]
(
[CodeID] [int] NOT NULL,
[CodeTypeID] [int] NOT NULL,
[Prefix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Seed] [int] NOT NULL,
[Length] [int] NOT NULL,
[IncrementStep] [int] NOT NULL,
[Count] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Code] ADD CONSTRAINT [PK_Code] PRIMARY KEY CLUSTERED  ([CodeID]) ON [PRIMARY]
GO
