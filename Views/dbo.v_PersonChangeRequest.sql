SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.v_PersonChangeRequest
AS
SELECT     pch.PersonChangeRequestID, pch.PersonID, pch.FirstName, pch.LastName, pch.Email, pch.Mobile, pch.IDNo, pch.CompanyID, c.CompanyName, 
                      act.AccountTypeName, p.FirstName AS OldFirstName, p.LastName AS OldLastName, p.Email AS OldEmail, p.Mobile AS OldMobile, p.IDNo AS OldIDNo, 
                      p.CompanyID AS OldCompanyID, cOld.CompanyName AS OldCompanyName, actOld.AccountTypeName AS OldAccountTypeName, pch.AccountTypeID, 
                      pch.QualityManagerConfirmStatusID, pch.AdministratorConfirmStatusID, pch.QualityManagerPersonID, pch.AdministratorPersonID
FROM         dbo.PersonChangeRequest AS pch INNER JOIN
                      dbo.Company AS c ON c.CompanyID = pch.CompanyID INNER JOIN
                      dbo.AccountType AS act ON act.AccountTypeID = pch.AccountTypeID LEFT OUTER JOIN
                      dbo.Person AS p ON p.PersonID = pch.PersonID LEFT OUTER JOIN
                      dbo.Company AS cOld ON cOld.CompanyID = p.CompanyID LEFT OUTER JOIN
                      dbo.AccountType AS actOld ON actOld.AccountTypeID = p.AccountTypeID
GO
