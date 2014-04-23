SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[CREATE_PROCEDURE_TEMPLATE]
    (
      @table_name VARCHAR(64) ,
      @procedure_name VARCHAR(64) ,
      @ins_procedure_ddl VARCHAR(MAX) OUT ,
      @upd_procedure_ddl VARCHAR(MAX) OUT ,
      @del_procedure_ddl VARCHAR(MAX) OUT
    )
AS 
    BEGIN
        DECLARE @insSqlCommand VARCHAR(MAX) = '' ,
            @insParams VARCHAR(MAX) = '' ,
            @insDML VARCHAR(MAX)= '' ,
            @insValues VARCHAR(MAX) = '' ,
            @updSqlCommand VARCHAR(MAX)= '' ,
            @updDML VARCHAR(MAX)= '' ,
            @updParams VARCHAR(MAX) = '' ,
            @delDML VARCHAR(MAX)= '' ,
            @delSqlCommand VARCHAR(MAX)= '' ,
            @delParams VARCHAR(MAX) = '' ,
            @column_name VARCHAR(64) ,
            @parameter_name VARCHAR(64) ,
            @max_length INT ,
            @is_identity INT ,
            @is_nullable INT ,
            @schema_name NVARCHAR(64) ,
            @tbl_name VARCHAR(64) ,
            @type_name NVARCHAR(64) ,
            @is_primary_key INT ,
            @scale INT ,
            @is_computed BIT ,
            @precision INT ;
        
        SET NOCOUNT ON ;
		
        SET @insSqlCommand = 'CREATE PROCEDURE ' ;
		
        SET @updSqlCommand = 'CREATE PROCEDURE ' ;	
		
        SET @delSqlCommand = 'CREATE PROCEDURE ' ;	

        DECLARE db_cursor CURSOR
        FOR
            SELECT  *
            FROM    ( SELECT    sc.name 'column_name' ,
                                '@' + sc.name 'parameter_name' ,
                                CASE WHEN sc.collation_name IS NOT NULL
                                     THEN CASE WHEN CHARINDEX('n', st.NAME, 0) > 0
                                               THEN sc.max_length / 2
                                               ELSE sc.max_length
                                          END
                                     ELSE sc.max_length
                                END AS 'max_length' ,
                                sc.is_identity ,
                                sc.is_nullable ,
                                tb.schema_name ,
                                st.name AS 'type_name' ,
                                CASE WHEN tpk.COLUMN_NAME IS NOT NULL THEN 1
                                     ELSE 0
                                END 'is_primary_key' ,
                                SC.scale ,
                                tb.table_name ,
                                sc.is_computed ,
                                SC.precision
                      FROM      sys.columns sc
                                JOIN ( SELECT   stb.object_id ,
                                                stb.name AS 'table_name' ,
                                                sch.name AS 'schema_name'
                                       FROM     sys.tables stb
                                                JOIN sys.schemas sch ON sch.schema_id = stb.schema_id
                                     ) tb ON tb.object_id = sc.object_id
                                JOIN sys.types st ON st.user_type_id = sc.user_type_id
                                LEFT JOIN ( SELECT  ccu.TABLE_NAME ,
                                                    ccu.TABLE_SCHEMA ,
                                                    ccu.COLUMN_NAME
                                            FROM    INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
                                                    JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tct ON tct.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
                                                              AND tct.CONSTRAINT_TYPE = 'PRIMARY KEY'
                                          ) tpk ON tpk.TABLE_NAME = tb.table_name
                                                   AND tpk.TABLE_SCHEMA = tb.schema_name
                                                   AND tpk.column_name = sc.name
                      WHERE     tb.object_id = OBJECT_ID(@table_name)
                    ) a
            ORDER BY a.is_primary_key ASC ;

        SET @insParams = '(' + CHAR(10) ;
        SET @updParams = '(' + CHAR(10) ;
        SET @delParams = '(' + CHAR(10) ;
		
        SET @insDML = ' INSERT INTO ' + @table_name + '(' ;
        SET @updDML = ' UPDATE ' + @table_name + ' set ' ;
        SET @insValues = ' values (' ;
		
        OPEN db_cursor ; 
        FETCH NEXT FROM db_cursor INTO @column_name, @parameter_name,
            @max_length, @is_identity, @is_nullable, @schema_name, @type_name,
            @is_primary_key, @scale, @tbl_name, @is_computed, @precision ;     
                   
        WHILE @@FETCH_STATUS = 0 
            BEGIN  
				
                IF ( @is_primary_key = 0 ) 
                    BEGIN
                        IF ( @is_computed = 0 ) 
                            BEGIN
                                IF ( @column_name != 'MODIFY_DATE' ) 
                                    BEGIN
                                        IF ( @column_name != 'IS_ACTIVE'
                                             AND @column_name != 'CREATE_USER_ID'
                                           ) 
                                            BEGIN
                                                SET @insParams += @parameter_name
                                                    + ' ' + @type_name
                                                    + CASE WHEN CHARINDEX('char',
                                                              @type_name) > 0
                                                           THEN '('
                                                              + CASE
                                                              WHEN @max_length = 0
                                                              THEN 'max'
                                                              ELSE CAST(@max_length AS VARCHAR(32))
                                                              END + ')'
                                                           WHEN CHARINDEX('decimal',
                                                              @type_name) > 0
                                                           THEN '('
                                                              + CAST(@precision AS VARCHAR(32))
                                                              + ','
                                                              + CAST(@scale AS VARCHAR(32))
                                                              + ')'
                                                           ELSE ''
                                                      END
                                                    + CASE WHEN @is_nullable = 1
                                                           THEN '=NULL'
                                                           ELSE ''
                                                      END + ',' + CHAR(10) ;
                                            END ;
							
                                        IF ( @column_name != 'CREATE_USER_ID' ) 
                                            BEGIN
                                                SET @updParams += @parameter_name
                                                    + ' ' + @type_name
                                                    + CASE WHEN CHARINDEX('char',
                                                              @type_name) > 0
                                                           THEN '('
                                                              + CASE
                                                              WHEN @max_length = 0
                                                              THEN 'max'
                                                              ELSE CAST(@max_length AS VARCHAR(32))
                                                              END + ')'
                                                           WHEN CHARINDEX('decimal',
                                                              @type_name) > 0
                                                           THEN '('
                                                              + CAST(@precision AS VARCHAR(32))
                                                              + ','
                                                              + CAST(@scale AS VARCHAR(32))
                                                              + ')'
                                                           ELSE ''
                                                      END
                                                    + CASE WHEN @is_nullable = 1
                                                           THEN '=NULL'
                                                           ELSE ''
                                                      END + ',' + CHAR(10) ;
                                            END
                                        SET @insDML += '[' + @column_name
                                            + ']' + ',' + CHAR(10) ;
                                        SET @insValues += CASE
                                                              WHEN @column_name = 'CREATE_USER_ID'
                                                              THEN '@MODIFY_USER_ID'
                                                              ELSE CASE
                                                              WHEN @column_name = 'IS_ACTIVE'
                                                              THEN '1'
                                                              ELSE @parameter_name
                                                              END
                                                          END + +',' + CHAR(10) ;
                                    END ;
                        
                                IF ( @column_name != 'CREATE_USER_ID' ) 
                                    BEGIN
                                        SET @updDML += '[' + @column_name
                                            + '] = '
                                            + CASE WHEN @column_name = 'MODIFY_DATE'
                                                   THEN 'GETDATE()'
                                                   ELSE @parameter_name
                                              END + ',' + CHAR(10) ;
                                    END ;
                            END ;
                        
                    END
                ELSE 
                    BEGIN
                        SET @insParams = SUBSTRING(@insParams, 0,
                                                   LEN(@insParams) - 1) ;

                        SET @insParams += ')' ;
                        SET @insValues = SUBSTRING(@insValues, 0,
                                                   LEN(@insValues) - 1) ;
                                                   
                        SET @insValues += ')' ;
                                                
                        --SET @updParams = SUBSTRING(@updParams, 0,
                        --                           LEN(@updParams) - 1) ;
                                                   
                        --SET @updParams += ')' ;
                        SET @updParams += @parameter_name + ' ' + @type_name
                            + ')' ;
                                                
                        SET @insDML = SUBSTRING(@insDML, 0, LEN(@insDML) - 1) ;
						
                        SET @updDML = SUBSTRING(@updDML, 0, LEN(@updDML) - 1) ;
						
                        SET @insDML += ')' ;
                        SET @updDML += ' WHERE ' + @column_name + ' = '
                            + @parameter_name + CHAR(10) ;
						
                        SET @delParams += @parameter_name + ' ' + @type_name
                            + CASE WHEN CHARINDEX('char', @type_name) > 0
                                   THEN '(' + CAST(@max_length AS VARCHAR(32))
                                        + ')'
                                   ELSE ''
                              END + ', @IS_ACTIVE bit )' + CHAR(10) ;
                              
                        SET @delDML = ' UPDATE ' + @table_name + ' set '
                            + CHAR(10) + 'IS_ACTIVE = @IS_ACTIVE WHERE '
                            + @column_name + ' = ' + @parameter_name ;
                    END ;
			
                FETCH NEXT FROM db_cursor INTO @column_name, @parameter_name,
                    @max_length, @is_identity, @is_nullable, @schema_name,
                    @type_name, @is_primary_key, @scale, @tbl_name,
                    @is_computed ,@precision; 
                    
            END ;
            
        CLOSE db_cursor ;    
        DEALLOCATE db_cursor ;
		
        SET @insSqlCommand += @schema_name + '.INS_' + @tbl_name + @insParams
            + 'as BEGIN  BEGIN TRY ' + CHAR(10) + @insDML + @insValues
            + CHAR(10) + 'SELECT SCOPE_IDENTITY() AS [result] ' + CHAR(10)
            + ' END TRY BEGIN CATCH '
            + '	DECLARE @ErrorMessage NVARCHAR(4000);
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
               );' + 'END CATCH  END;' ;
           
        SET @updSqlCommand += @schema_name + '.UPD_' + @tbl_name + @updParams
            + 'as BEGIN  BEGIN TRY ' + CHAR(10) + @updDML + CHAR(10)
            + +'END TRY BEGIN CATCH '
            + '	DECLARE @ErrorMessage NVARCHAR(4000);
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
               );' + 'END CATCH  END;' ;
        SET @delSqlCommand += @schema_name + '.DEL_' + @tbl_name + @delParams
            + 'as BEGIN BEGIN TRY ' + CHAR(10) + @delDML + CHAR(10)
            + +'END TRY BEGIN CATCH '
            + '	DECLARE @ErrorMessage NVARCHAR(4000);
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
               );' + 'END CATCH  END;' ;
            
        PRINT @insSqlCommand
        PRINT CHAR(10)
        PRINT 'GO'
        PRINT @updSqlCommand
        PRINT CHAR(10)
        PRINT 'GO'
        PRINT @delSqlCommand
        PRINT CHAR(10)
        PRINT 'GO'
        
        SET @ins_procedure_ddl = @insSqlCommand ;
        SET @upd_procedure_ddl = @updSqlCommand ;
        SET @del_procedure_ddl = @delSqlCommand ;

    END







GO
