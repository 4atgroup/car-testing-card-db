SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INS_PersonSchedule](
@StartTime time=NULL,
@EndTime time=NULL,
@BreakStartTime time=NULL,
@BreakEndTime time=NULL,
@ResponsiblePersonID int,
@EffectiveDate datetime,
@PersonID int,@WeekDayNumber int)as BEGIN  BEGIN TRY 

	if(exists(select * From dbo.PersonSchedule ps where ps.PersonID = @PersonID and ps.WeekDayNumber = @WeekDayNumber))
	begin
		UPDATE dbo.PersonSchedule set [StartTime] = @StartTime,
		[EndTime] = @EndTime,
		[BreakStartTime] = @BreakStartTime,
		[BreakEndTime] = @BreakEndTime,
		[ResponsiblePersonID] = @ResponsiblePersonID,
		[EffectiveDate] = @EffectiveDate WHERE PersonID = @PersonID and WeekDayNumber = @WeekDayNumber
		SELECT @PersonID AS [result] ;
	end
	else
	begin
		INSERT INTO dbo.PersonSchedule([StartTime],
			[EndTime],
			[BreakStartTime],
			[BreakEndTime],
			[ResponsiblePersonID],
			[EffectiveDate],
			PersonID,
			WeekDayNumber) values (@StartTime,
			@EndTime,
			@BreakStartTime,
			@BreakEndTime,
			@ResponsiblePersonID,
			@EffectiveDate,
			@PersonID,
			@WeekDayNumber)
			SELECT @PersonID AS [result] ;
	end;

	 

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
