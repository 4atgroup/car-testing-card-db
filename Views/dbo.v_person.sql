SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[v_person]
AS
SELECT     p.PersonID, p.FirstName, p.LastName, p.IDNo, p.Email, ac.AccountTypeName, p.CompanyID, p.SystemIDNo, p.AccountTypeID, p.ResponsiblePersonID, 
                      p.EffectiveDate, p.Mobile, p.FileID, dbo.Company.CompanyName, p.Password
FROM         dbo.Person AS p INNER JOIN
                      dbo.AccountType AS ac ON ac.AccountTypeID = p.AccountTypeID INNER JOIN
                      dbo.Company ON p.CompanyID = dbo.Company.CompanyID

GO
