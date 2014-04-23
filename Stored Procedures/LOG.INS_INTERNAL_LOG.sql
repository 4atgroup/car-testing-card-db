SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROCEDURE [LOG].[INS_INTERNAL_LOG]
    (
      @ERROR_NUMBER BIGINT ,
      @ERROR_SEVERITY BIGINT ,
      @ERROR_STATE BIGINT ,
      @ERROR_OBJECT_NAME VARCHAR(64) ,
      @ERROR_LINE BIGINT ,
      @ERROR_MESSAGE VARCHAR(MAX)
    )
AS 
    BEGIN
        BEGIN TRY 
            INSERT  INTO LOG.INTERNAL_LOG
                    ( [ERROR_NUMBER] ,
                      [ERROR_SEVERITY] ,
                      [ERROR_STATE] ,
                      [ERROR_OBJECT_NAME] ,
                      [ERROR_LINE] ,
                      [ERROR_MESSAGE]
                    )
            VALUES  ( @ERROR_NUMBER ,
                      @ERROR_SEVERITY ,
                      @ERROR_STATE ,
                      @ERROR_OBJECT_NAME ,
                      @ERROR_LINE ,
                      @ERROR_MESSAGE
                    )
        END TRY
        BEGIN CATCH
			
        END CATCH
    END
GO
