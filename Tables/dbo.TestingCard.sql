CREATE TABLE [dbo].[TestingCard]
(
[TestingCardID] [int] NOT NULL IDENTITY(1, 1),
[Number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TestingCardNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VIN] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarModel] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CarSerialNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Odometer] [decimal] (8, 2) NULL,
[OwnerName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OwnerIDNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsValid] [bit] NULL,
[IsFirstTesting] [bit] NULL,
[FirnishNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirnishDate] [date] NULL,
[Comment] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCard] ADD CONSTRAINT [PK_TestingCard] PRIMARY KEY CLUSTERED  ([TestingCardID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TestingCard] ADD CONSTRAINT [FK_TestingCard_Person] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
