SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INS_PersonScheduleChangeRequest](
@PersonID int=NULL,
@WeekDayNumber int,
@StartTime time=NULL,
@EndTime time=NULL,
@BreakStartTime time=NULL,
@BreakEndTime time=NULL,
@ResponsiblePersonID int=null,
@EffectiveDate datetime,
@QualityManagerConfirmStatusID int=NULL,
@QualityManagerPersonID int=NULL,
@AdministratorConfirmStatusID int=NULL,
@AdministratorPersonID int=NULL,
@PersonChangeRequestID int=NULL)as BEGIN  BEGIN TRY 
 INSERT INTO dbo.PersonScheduleChangeRequest([PersonID],
[WeekDayNumber],
[StartTime],
[EndTime],
[BreakStartTime],
[BreakEndTime],
[ResponsiblePersonID],
[EffectiveDate],
[QualityManagerConfirmStatusID],
[QualityManagerPersonID],
[AdministratorConfirmStatusID],
[AdministratorPersonID],
[PersonChangeRequestID]) values (@PersonID,
@WeekDayNumber,
@StartTime,
@EndTime,
@BreakStartTime,
@BreakEndTime,
@ResponsiblePersonID,
@EffectiveDate,
@QualityManagerConfirmStatusID,
@QualityManagerPersonID,
@AdministratorConfirmStatusID,
@AdministratorPersonID,
@PersonChangeRequestID)
SELECT SCOPE_IDENTITY() AS [result] 
 END TRY BEGIN CATCH 	DECLARE @ErrorMessage NVARCHAR(4000);
				DECLARE @ErrorSeverity INT;
				DECLARE @ErrorState INT;
				DECLARE @ErrorNumber INT
				DECLARE @ErrorObject varchar(64),@ErrorLine int;

				SELECT  @ErrorNumber = ERROR_NUMBER()  ,
                     @ErrorSeverity = ERROR_SEVERITY() ,
                     @ErrorState = ERROR_STATE(),
                     @ErrorObject = ERROR_PROCEDURE() ,
                     @ErrorLine = ERROR_LINE() ,
                     @ErrorMessage = ERROR_MESSAGE();

				EXECUTE [LOG].[INS_INTERNAL_LOG] 
			   @ERROR_NUMBER =@ErrorNumber
			  ,@ERROR_SEVERITY =@ErrorSeverity
			  ,@ERROR_STATE = @ErrorState
			  ,@ERROR_OBJECT_NAME =@ErrorObject
			  ,@ERROR_LINE = @ErrorLine
			  ,@ERROR_MESSAGE = @ErrorMessage
			  
				RAISERROR (@ErrorMessage, 
						   @ErrorSeverity,
						   @ErrorState 
               );END CATCH  END;
GO
