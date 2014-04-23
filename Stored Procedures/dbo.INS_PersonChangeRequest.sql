SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INS_PersonChangeRequest](
@PersonID int=NULL,
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Email nvarchar(50)=NULL,
@Mobile nvarchar(50)=NULL,
@IDNo nvarchar(50),
@SystemIDNo nvarchar(50),
@CompanyID int,
@AccountTypeID int,
@FileID int=NULL,
@ResponsiblePersonChangeRequestID int=NULL,
@EffectiveDate datetime,
@CreateDate datetime,
@Password nvarchar(50))as BEGIN  BEGIN TRY 
 INSERT INTO dbo.PersonChangeRequest([PersonID],
[FirstName],
[LastName],
[Email],
[Mobile],
[IDNo],
[SystemIDNo],
[CompanyID],
[AccountTypeID],
[FileID],
[ResponsiblePersonChangeRequestID],
[EffectiveDate],
[CreateDate],
[Password]) values (@PersonID,
@FirstName,
@LastName,
@Email,
@Mobile,
@IDNo,
@SystemIDNo,
@CompanyID,
@AccountTypeID,
@FileID,
@ResponsiblePersonChangeRequestID,
@EffectiveDate,
@CreateDate,
@Password)
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
