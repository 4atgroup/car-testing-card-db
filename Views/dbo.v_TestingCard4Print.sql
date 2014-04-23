SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [dbo].[v_TestingCard4Print] as 
SELECT  
tt.*,
p.FirstName,
p.LastName,
c.CompanyName,
c.FileID,
pvt.[1] as StepValue1
,pvt.[2] as StepValue2
,pvt.[3] as StepValue3
,pvt.[4] as StepValue4
,sbt.TestingStepName
,tss.TestingSubStepName as SubStepName1
,tss2.TestingSubStepName as SubStepName2
,tss3.TestingSubStepName as SubStepName3
,tss4.TestingSubStepName as SubStepName4
FROM    ( SELECT    tcd.TestingCardID ,
                    tcd.TestingSubStepID % 10 AS ColumnID ,
                    tcd.TestingSubStepID / 10 AS RowID ,
                    CAST(tcd.IsValid AS INT) AS IsValid
          FROM      dbo.TestingCardDetail tcd
          
        ) AS TCD PIVOT ( SUM(IsValid) FOR ColumnID IN ( [1], [2], [3], [4] ) ) AS pvt
        INNER JOIN dbo.TestingSubStep AS TSS ON pvt.rowid * 10 + 1 = TSS.TestingSubStepID
        INNER JOIN dbo.TestingSubStep AS TSS2 ON pvt.rowid * 10 + 2 = TSS2.TestingSubStepID
        left join dbo.TestingSubStep AS TSS3 ON pvt.rowid * 10 + 3 = TSS3.TestingSubStepID
        left join dbo.TestingSubStep AS TSS4 ON pvt.rowid * 10 + 4 = TSS4.TestingSubStepID
        join dbo.TestingStep sbt on sbt .TestingStepID = pvt.rowid
        join dbo.TestingCard AS tt ON tt.TestingCardID = pvt.TestingCardID INNER JOIN
        dbo.Person AS p ON tt.ResponsiblePersonID = p.PersonID INNER JOIN
        dbo.Company AS c ON c.CompanyID = p.CompanyID
GO
