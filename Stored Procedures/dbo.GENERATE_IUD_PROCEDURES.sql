SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Batch submitted through debugger: SQLQuery78.sql|7|0|C:\Users\kacelashvili.k\AppData\Local\Temp\~vs962F.sql
create PROCEDURE [dbo].[GENERATE_IUD_PROCEDURES]
@for_table_name varchar(64) = null
AS 
    BEGIN

        DECLARE @return_value INT ,
            @ins_procedure_ddl VARCHAR(4000) ,
            @upd_procedure_ddl VARCHAR(4000) ,
            @del_procedure_ddl VARCHAR(4000)

		BEGIN TRY
		
		BEGIN TRAN

        DECLARE table_crs CURSOR
        FOR
            SELECT  tb.name 'table_name' ,
                    sch.name 'schema_name'
            FROM    sys.tables tb
                    JOIN sys.schemas sch ON sch.schema_id = tb.schema_id
            WHERE   sch.name != 'LOG' and (@for_table_name is null or tb.name = @for_table_name)
            ORDER BY sch.name ,
                    tb.name
		
        DECLARE @tbl_name VARCHAR(64) ,
            @sch_name VARCHAR(64) ;
        OPEN table_crs ; 
        FETCH NEXT FROM table_crs INTO @tbl_name, @sch_name ;
		
        WHILE @@FETCH_STATUS = 0 
            BEGIN  
                SET @tbl_name = @sch_name + '.' + @tbl_name;
                EXEC @return_value = [dbo].[CREATE_PROCEDURE_TEMPLATE] @table_name = @tbl_name,
                    @procedure_name = '',
                    @ins_procedure_ddl = @ins_procedure_ddl OUTPUT,
                    @upd_procedure_ddl = @upd_procedure_ddl OUTPUT,
                    @del_procedure_ddl = @del_procedure_ddl OUTPUT
				
                PRINT @ins_procedure_ddl + CHAR(10) ;
                PRINT @upd_procedure_ddl  + CHAR(10) ;
                PRINT @del_procedure_ddl + CHAR(10) ;
				
                FETCH NEXT FROM table_crs INTO @tbl_name, @sch_name ;
            END ;
            
        CLOSE table_crs ;    
        DEALLOCATE table_crs ;

		COMMIT;	
		END TRY
		BEGIN CATCH
			ROLLBACK;
			SELECT  ERROR_NUMBER() AS ErrorNumber ,
                    ERROR_SEVERITY() AS ErrorSeverity ,
                    ERROR_STATE() AS ErrorState ,
                    ERROR_PROCEDURE() AS ErrorProcedure ,
                    ERROR_LINE() AS ErrorLine ,
                    ERROR_MESSAGE() AS ErrorMessage,
                    @tbl_name AS 'table name' ,
                    @sch_name AS 'schema name',
                    @ins_procedure_ddl 'INS_COMMAND',
                    @upd_procedure_ddl 'UPD_COMMAND',
                    @del_procedure_ddl 'DEL_COMMAND';
		END CATCH;
		

    END ;
GO
