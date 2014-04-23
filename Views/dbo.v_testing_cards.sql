SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[v_testing_cards] 
as
select tc.*,c.CompanyID From dbo.TestingCard  tc 
left join person p on tc.ResponsiblePersonID = p.PersonID
left join company c on c.CompanyID = p.CompanyID
GO
