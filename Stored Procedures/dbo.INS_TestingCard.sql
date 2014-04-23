SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE dbo.INS_TestingCard(
@Number nvarchar(50)=NULL,
@TestingCardNumber nvarchar(50)=NULL,
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
@EffectiveDate datetime=NULL)as BEGIN  BEGIN TRY 
 INSERT INTO dbo.TestingCard([Number],
[TestingCardNumber],
[VIN],
[CarModel],
[CarNumber],
[CarSerialNo],
[Odometer],
[OwnerName],
[OwnerIDNo],
[IsValid],
[FirnishNumber],
[FirnishDate],
[Comment],
[ResponsiblePersonID],
[EffectiveDate]) values (@Number,
@TestingCardNumber,
@VIN,
@CarModel,
@CarNumber,
@CarSerialNo,
@Odometer,
@OwnerName,
@OwnerIDNo,
@IsValid,
@FirnishNumber,
@FirnishDate,
@Comment,
@ResponsiblePersonID,
@EffectiveDate)
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
