SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INS_Company](
@CompanyName nvarchar(200)=NULL,
@ContactPersonID int=NULL,
@Phone nvarchar(50)=NULL,
@AccreditationScope nvarchar(4000)=NULL,
@AccreditationNumber nvarchar(50)=NULL,
@AccreditationExpireDate datetime=NULL,
@ResponsiblePersonID int=NULL,
@EffectiveDate datetime,
@FileID int=null,
@IDNo char(9)=NULL)as BEGIN  BEGIN TRY 
 INSERT INTO dbo.Company([CompanyName],
[ContactPersonID],
[Phone],
[AccreditationScope],
[AccreditationNumber],
[AccreditationExpireDate],
[ResponsiblePersonID],
[EffectiveDate],
[IDNo],[FileID]) values (@CompanyName,
@ContactPersonID,
@Phone,
@AccreditationScope,
@AccreditationNumber,
@AccreditationExpireDate,
@ResponsiblePersonID,
@EffectiveDate,
@IDNo,@FileID)
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
