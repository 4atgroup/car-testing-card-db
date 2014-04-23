SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.v_TestingCardDetail
AS
SELECT     ts.TestingStepName, sbt.TestingSubStepName, t.TestingCardID, t.TestingSubStepID, t.IsValid, LTRIM(RTRIM('step' + CAST(t.TestingSubStepID AS char))) 
                      AS stepName
FROM         dbo.TestingCardDetail AS t INNER JOIN
                      dbo.TestingSubStep AS sbt ON sbt.TestingSubStepID = t.TestingSubStepID INNER JOIN
                      dbo.TestingStep AS ts ON ts.TestingStepID = sbt.TestingStepID
GO
