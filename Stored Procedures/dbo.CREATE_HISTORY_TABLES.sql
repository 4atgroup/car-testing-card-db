SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[CREATE_HISTORY_TABLES]
AS 
    BEGIN
        DECLARE @tbl_ddl VARCHAR(4000) ,
            @table_name VARCHAR(32) ,
            @schema_name VARCHAR(32) ;
        
        
        SET NOCOUNT ON ;
        
        IF EXISTS ( SELECT  tb.name 'table_name' ,
                            sch.name 'schema_name'
                    FROM    sys.tables tb
                            JOIN sys.schemas sch ON sch.schema_id = tb.schema_id
                    WHERE   tb.name = 'temp_table_names'
                            AND sch.name = 'dbo' ) 
            BEGIN
                EXEC('DELETE FROM dbo.temp_table_names') ;
            END
        ELSE 
            BEGIN
                EXEC ('create table dbo.temp_table_names(id int primary key identity(1,1),table_name varchar(64),schema_name varchar(64))') ;
            END ;
        
        DECLARE table_crs CURSOR
        FOR
            SELECT  tb.name 'table_name' ,
                    sch.name 'schema_name'
            FROM    sys.tables tb
                    JOIN sys.schemas sch ON sch.schema_id = tb.schema_id
			--WHERE sch.name = 'CUSTOMS' AND tb.name= 'CODE_DESCRIPTION'
            ORDER BY sch.name ,
                    tb.name
		
        OPEN table_crs ; 
        FETCH NEXT FROM table_crs INTO @table_name, @schema_name ;
		
        WHILE @@FETCH_STATUS = 0 
            BEGIN  
                EXEC('insert into dbo.temp_table_names(table_name,schema_name) values ('''+@table_name + ''',''' + @schema_name+ ''')') ;
				
                FETCH NEXT FROM table_crs INTO @table_name, @schema_name ;
            END ;
            
        CLOSE table_crs ;    
        DEALLOCATE table_crs ;
        
        DECLARE @count INT ,
            @id INT ;
        EXEC sp_executesql N'SELECT @count = count(*) from dbo.temp_table_names',
            N'@count INT OUTPUT', @count OUTPUT
		
        DECLARE @column_name VARCHAR(64) ,
            @max_length INT ,
            @type_name VARCHAR(64) ,
            @is_nullable INT ;
		
		
        BEGIN TRY
			
        
            BEGIN TRAN ;
            
            WHILE @count > 0 
                BEGIN
		
                    EXEC sp_executesql N'SELECT top 1 @id = id,@table_name = table_name,@schema_name = schema_name from dbo.temp_table_names ',
                        N'@id INT OUTPUT,@table_name varchar(64) output,@schema_name varchar(64) output',
                        @id OUTPUT, @table_name OUTPUT, @schema_name OUTPUT
		
                    DECLARE column_crs CURSOR
                    FOR
                        SELECT  *
                        FROM    ( SELECT    sc.name 'column_name' ,
                                --'@' + sc.name 'parameter_name' ,
                                            CASE WHEN sc.collation_name IS NOT NULL
                                                 THEN sc.max_length / 2
                                                 ELSE sc.max_length
                                            END AS 'max_length' ,
                                --sc.is_identity ,
                                            sc.is_nullable ,
                                            st.name AS 'type_name' 
                                --st.scale ,
                                --tb.table_name,
                                --tb.schema_name
                                  FROM      sys.columns sc
                                            JOIN ( SELECT   stb.object_id ,
                                                            stb.name AS 'table_name' ,
                                                            sch.name AS 'schema_name'
                                                   FROM     sys.tables stb
                                                            JOIN sys.schemas sch ON sch.schema_id = stb.schema_id
                                                 ) tb ON tb.object_id = sc.object_id
                                            JOIN sys.types st ON st.user_type_id = sc.user_type_id
                                  WHERE     tb.object_id = OBJECT_ID(@schema_name
                                                              + '.'
                                                              + @table_name)
                                ) a ;
                    
                    OPEN column_crs ;
                    FETCH NEXT FROM column_crs INTO @column_name, @max_length,
                        @is_nullable, @type_name ;
                    SET @tbl_ddl = 'create table LOG.' + @table_name
                        + '_HISTORY(HISTORY_ID bigint primary key identity(1,1),' ;
                    WHILE @@FETCH_STATUS = 0 
                        BEGIN 
                            SET @tbl_ddl += @column_name + ' ' + @type_name
                                + CASE WHEN CHARINDEX('char', @type_name) > 0
                                       THEN '('
                                            + CASE WHEN @max_length = 0 THEN 'MAX' ELSE CAST(@max_length AS VARCHAR(32)) END
                                            + ')'
                                       ELSE ''
                                  END + ',' ;
                            FETCH NEXT FROM column_crs INTO @column_name,
                                @max_length, @is_nullable, @type_name ;
                        END ;
                --IF(SUBSTRING(@tbl_ddl, LEN(@tbl_ddl) - 1,1 ) = ',')
                --BEGIN
                
                    SET @tbl_ddl += 'DML_ACTION_ID TINYINT NOT NULL REFERENCES LOG.ACTIONS(ACTION_ID))' ;
				
                --END;
                --PRINT SUBSTRING(@tbl_ddl, 0,LEN(@tbl_ddl) - 1 );
                   EXEC(@tbl_ddl) ;
                --PRINT '--------------------------------------' ;
               -- PRINT @tbl_ddl ;
                    SET @tbl_ddl = '' ;
                    CLOSE column_crs ;    
                    DEALLOCATE column_crs ;
                    EXEC('delete from dbo.temp_table_names where id = ' + @id) ;
                    EXEC sp_executesql N'SELECT @count = count(*) from dbo.temp_table_names',
                        N'@count INT OUTPUT', @count OUTPUT
                END ;
        
        
            EXEC('drop table dbo.temp_table_names') ;
			COMMIT;
        END TRY
        BEGIN CATCH
            ROLLBACK ;
            SELECT  ERROR_NUMBER() AS ErrorNumber ,
                    ERROR_SEVERITY() AS ErrorSeverity ,
                    ERROR_STATE() AS ErrorState ,
                    ERROR_PROCEDURE() AS ErrorProcedure ,
                    ERROR_LINE() AS ErrorLine ,
                    ERROR_MESSAGE() AS ErrorMessage,
                    @table_name AS 'table name' ,
                    @schema_name AS 'schema name';
        END CATCH ;
 
		
        

    END







GO
