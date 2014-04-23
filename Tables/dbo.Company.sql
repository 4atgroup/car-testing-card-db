CREATE TABLE [dbo].[Company]
(
[CompanyID] [int] NOT NULL IDENTITY(1, 1),
[CompanyName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactPersonID] [int] NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationScope] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationExpireDate] [datetime] NULL,
[ResponsiblePersonID] [int] NULL,
[EffectiveDate] [datetime] NOT NULL,
[IDNo] [char] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyLogoFileID] [int] NULL,
[Address] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccreditationLogoFileID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED  ([CompanyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [FK_Company_File_AccreditationLogo] FOREIGN KEY ([AccreditationLogoFileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [FK_Company_File_CompanyLogo] FOREIGN KEY ([CompanyLogoFileID]) REFERENCES [dbo].[File] ([FileID])
GO
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [FK_Company_Person] FOREIGN KEY ([ContactPersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
ALTER TABLE [dbo].[Company] ADD CONSTRAINT [FK_Company_Person1] FOREIGN KEY ([ResponsiblePersonID]) REFERENCES [dbo].[Person] ([PersonID])
GO
