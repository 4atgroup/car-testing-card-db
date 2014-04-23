SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[UPD_Company](
@CompanyName nvarchar(200)=NULL,
@ContactPersonID int=NULL,
@Phone nvarchar(50)=NULL,
@AccreditationScope nvarchar(4000)=NULL,
@AccreditationNumber nvarchar(50)=NULL,
@AccreditationExpireDate datetime=NULL,
@ResponsiblePersonID int=NULL,
@EffectiveDate datetime,
@IDNo char(9)=NULL,
@FileID int =null,
@CompanyID int)as BEGIN  BEGIN TRY 
 UPDATE dbo.Company set [CompanyName] = @CompanyName,
[ContactPersonID] = @ContactPersonID,
[Phone] = @Phone,
[AccreditationScope] = @AccreditationScope,
[AccreditationNumber] = @AccreditationNumber,
[AccreditationExpireDate] = @AccreditationExpireDate,
[ResponsiblePersonID] = @ResponsiblePersonID,
[EffectiveDate] = @EffectiveDate,
[FileID] = @FileID,
[IDNo] = @IDNo WHERE CompanyID = @CompanyID

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
