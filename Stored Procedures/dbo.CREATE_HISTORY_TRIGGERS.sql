SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[CREATE_HISTORY_TRIGGERS]
AS 
    BEGIN
        DECLARE @TRIGGER_DDL VARCHAR(4000) ,
            @table_name VARCHAR(32) ,
            @schema_name VARCHAR(32) ;
        
        
        SET NOCOUNT ON ;
        
        DECLARE table_crs CURSOR
        FOR
            SELECT  tb.name 'table_name' ,
                    sch.name 'schema_name'
            FROM    sys.tables tb
                    JOIN sys.schemas sch ON sch.schema_id = tb.schema_id
            ORDER BY sch.name ,
                    tb.name
		
        OPEN table_crs ; 
        FETCH NEXT FROM table_crs INTO @table_name, @schema_name ;
        
		
        WHILE @@FETCH_STATUS = 0 
            BEGIN  
                SET @TRIGGER_DDL = 'CREATE TRIGGER ['+ @schema_name +'].[' + @table_name + '_HISTORY_TRG] ON ['+ @schema_name +'].['+@table_name+']
					AFTER INSERT,UPDATE,DELETE
					AS
					begin
						IF EXISTS(SELECT * FROM  DELETED) 
						begin
							IF(EXISTS (SELECT  * FROM INSERTED))
							BEGIN
								INSERT INTO LOG.' + @table_name + '_HISTORY 
								SELECT d.*,2/*update*/ FROM  DELETED d; 
							END
							ELSE
							BEGIN
								INSERT INTO LOG.' + @table_name + '_HISTORY  
								SELECT d.*,3/*delete*/ FROM  DELETED d; 
							END;
						END
						ELSE
						begin
							INSERT INTO LOG.' + @table_name + '_HISTORY  
							SELECT d.*,1/*insert*/ FROM  INSERTED d; 
						END;
				END;' ;
				
                FETCH NEXT FROM table_crs INTO @table_name, @schema_name ;
                --EXEC(@TRIGGER_DDL);
                --PRINT OBJECT_NAME(@@PROCID);
            END ;
            
        
 
    END







GO
