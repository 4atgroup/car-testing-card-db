SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROCEDURE [dbo].[GET_PROCEDURE_PARAMS]
    (
      @table_name VARCHAR(128) ,
      @procedure_name VARCHAR(128)
    )
AS 
    BEGIN
       
        SET NOCOUNT ON ;
      
		
        IF ( SELECT type
             FROM   sys.objects
             WHERE  object_id = OBJECT_ID(@table_name)
           ) = 'U' 
            BEGIN
                SELECT  *
                FROM    ( SELECT    sc.name 'column_name' ,
                                    '@' + sc.name 'parameter_name' ,
                                    CASE WHEN sc.collation_name IS NOT NULL
                                         THEN sc.max_length / 2
                                         ELSE sc.max_length
                                    END AS 'max_length' ,
                                    sc.is_identity ,
                                    sc.is_nullable ,
                                    tb.schema_name ,
                                    st.name AS 'type_name' ,
                                    CASE WHEN tpk.COLUMN_NAME IS NOT NULL
                                         THEN 1
                                         ELSE 0
                                    END 'is_primary_key' ,
                                    st.scale ,
                                    tb.table_name ,
                                    sc.is_computed
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
                                    JOIN ( SELECT   REPLACE(PM.name, '@', '') AS PARAM_NAME ,
                                                    PM.object_id
                                           FROM     sys.parameters PM
                                         ) PRM ON PRM.PARAM_NAME = SC.name
                          WHERE     tb.object_id = OBJECT_ID(@table_name)
                                    AND PRM.object_id = OBJECT_ID(@procedure_name)
                        ) a ;
            END
        ELSE 
            BEGIN
                SELECT  *
                FROM    ( SELECT    sc.name 'column_name' ,
                                    '@' + sc.name 'parameter_name' ,
                                    CASE WHEN sc.collation_name IS NOT NULL
                                         THEN sc.max_length / 2
                                         ELSE sc.max_length
                                    END AS 'max_length' ,
                                    sc.is_identity ,
                                    sc.is_nullable ,
                                    tb.schema_name ,
                                    st.name AS 'type_name' ,
                                    CASE WHEN tpk.COLUMN_NAME IS NOT NULL
                                         THEN 1
                                         ELSE 0
                                    END 'is_primary_key' ,
                                    st.scale ,
                                    tb.table_name ,
                                    sc.is_computed
                          FROM      sys.columns sc
                                    JOIN ( SELECT   stb.object_id ,
                                                    stb.name AS 'table_name' ,
                                                    sch.name AS 'schema_name'
                                           FROM     sys.views stb
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
                                    JOIN ( SELECT   REPLACE(PM.name, '@', '') AS PARAM_NAME ,
                                                    PM.object_id
                                           FROM     sys.parameters PM
                                         ) PRM ON PRM.PARAM_NAME = SC.name
                          WHERE     tb.object_id = OBJECT_ID(@table_name)
                                    AND PRM.object_id = OBJECT_ID(@procedure_name)
                        ) a ;
            END ;
    END







GO
