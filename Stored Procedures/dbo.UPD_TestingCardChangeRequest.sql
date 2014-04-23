SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.UPD_TestingCardChangeRequest(
@TestingCardID int,
@Number nvarchar(50)=NULL,
@TestingCardChangeRequestNumber nvarchar(50)=NULL,
@VIN nvarchar(50)=NULL,
@CarModel nvarchar(200)=NULL,
@CarNumber nvarchar(50)=NULL,
@CarSerialNo nvarchar(50)=NULL,
@Odometer decimal(8,2)=NULL,
@OwnerName nvarchar(200)=NULL,
@OwnerIDNo nvarchar(50)=NULL,
@IsValid bit=NULL,
@FirnishNumber nvarchar(50)=NULL,
@FirnishDate date=NULL,
@Comment nvarchar(2000)=NULL,
@ResponsiblePersonID int=NULL,
@EffectiveDate datetime=NULL,
@QualityManagerConfirmStatusID int=NULL,
@QualityManagerPersonID int=NULL,
@AdministratorConfirmStatusID int=NULL,
@AdministratorPersonID int=NULL,
@TestingCardChangeRequestID int)as BEGIN  BEGIN TRY 
 UPDATE dbo.TestingCardChangeRequest set [TestingCardID] = @TestingCardID,
[Number] = @Number,
[TestingCardChangeRequestNumber] = @TestingCardChangeRequestNumber,
[VIN] = @VIN,
[CarModel] = @CarModel,
[CarNumber] = @CarNumber,
[CarSerialNo] = @CarSerialNo,
[Odometer] = @Odometer,
[OwnerName] = @OwnerName,
[OwnerIDNo] = @OwnerIDNo,
[IsValid] = @IsValid,
[FirnishNumber] = @FirnishNumber,
[FirnishDate] = @FirnishDate,
[Comment] = @Comment,
[ResponsiblePersonID] = @ResponsiblePersonID,
[EffectiveDate] = @EffectiveDate,
[QualityManagerConfirmStatusID] = @QualityManagerConfirmStatusID,
[QualityManagerPersonID] = @QualityManagerPersonID,
[AdministratorConfirmStatusID] = @AdministratorConfirmStatusID,
[AdministratorPersonID] = @AdministratorPersonID WHERE TestingCardChangeRequestID = @TestingCardChangeRequestID

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
