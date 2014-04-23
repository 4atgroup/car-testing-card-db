SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INS_File]
    (
      @FileName NVARCHAR(500) = NULL ,
      @FilePath NVARCHAR(2000) = NULL
    )
AS
    BEGIN
        BEGIN TRY 
            INSERT  INTO dbo.[File]
                    ( [FileName], [FilePath] )
            VALUES  ( @FileName, @FilePath )
            SELECT  SCOPE_IDENTITY() AS [result] 
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessage NVARCHAR(4000);
            DECLARE @ErrorSeverity INT;
            DECLARE @ErrorState INT;
            DECLARE @ErrorNumber INT
            DECLARE @ErrorObject VARCHAR(64) ,
                @ErrorLine INT;

            SELECT  @ErrorNumber = ERROR_NUMBER() ,
                    @ErrorSeverity = ERROR_SEVERITY() ,
                    @ErrorState = ERROR_STATE() ,
                    @ErrorObject = ERROR_PROCEDURE() ,
                    @ErrorLine = ERROR_LINE() ,
                    @ErrorMessage = ERROR_MESSAGE();

            EXECUTE [LOG].[INS_INTERNAL_LOG] @ERROR_NUMBER = @ErrorNumber,
                @ERROR_SEVERITY = @ErrorSeverity, @ERROR_STATE = @ErrorState,
                @ERROR_OBJECT_NAME = @ErrorObject, @ERROR_LINE = @ErrorLine,
                @ERROR_MESSAGE = @ErrorMessage
			  
            RAISERROR (@ErrorMessage, 
						   @ErrorSeverity,
						   @ErrorState 
               );
            END CATCH


    END;
GO
