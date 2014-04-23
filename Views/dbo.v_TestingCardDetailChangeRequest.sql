SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW dbo.v_TestingCardDetailChangeRequest
AS
SELECT     TestingCardID, TestingSubStepID, IsValid, LTRIM(RTRIM('step' + CAST(TestingSubStepID AS char))) AS stepName, TestingCardChangeRequestID
FROM         dbo.TestingCardDetailChangeRequest AS t
GO
