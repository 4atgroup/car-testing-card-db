SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create
 PROCEDURE [dbo].[GET_EXT_OBJECT_MODEL]
    (
      @table_name VARCHAR(64)
    )
AS 
    BEGIN

	 
        DECLARE @v_result VARCHAR(MAX)= '[' ,
            @column_result VARCHAR(MAX)= '[' ,
            @tree_column_result VARCHAR(MAX) = '[' ,
            @NewLineChar CHAR(2) = CHAR(13) + CHAR(10);

        SELECT  @v_result += '{name:' + '''' + cls.name + ''''
                + CASE WHEN CHARINDEX('date', tt.NAME, 0) > 0
                       THEN ', type: ''date'', dateFormat: Config.dateFormat'
                       ELSE ''
                  END + '},' + @NewLineChar ,
                @column_result+= '{header: ''' + REPLACE(cls.NAME, '_', ' ')
                + ''',dataIndex:''' + cls.NAME + ''''
                + CASE WHEN CHARINDEX('date', tt.NAME, 0) > 0
                       THEN ',xtype: ''datecolumn'',format: ''d/m/Y'',width:60'
                       ELSE ''
                  END + '},' + @NewLineChar ,
                @tree_column_result+= '{text: ''' + REPLACE(cls.NAME, '_', ' ')
                + ''',dataIndex:''' + cls.NAME + ''''
                + CASE WHEN CHARINDEX('date', tt.NAME, 0) > 0
                       THEN ',xtype: ''datecolumn'',format: ''d/m/Y'' ,width:60'
                       ELSE ',xtype:''treecolumn'''
                  END + '},' + @NewLineChar
        FROM    sys.columns cls
                JOIN sys.types tt ON tt.user_type_id = cls.user_type_id
        WHERE   cls.object_id = OBJECT_ID(@table_name) 
 
        SET @v_result = SUBSTRING(@v_result, 0, LEN(@v_result) - 1) + ']'
        SET @column_result = SUBSTRING(@column_result, 0,
                                       LEN(@column_result) - 1) + ']'
        SET @tree_column_result = SUBSTRING(@tree_column_result, 0,
                                       LEN(@tree_column_result) - 1) + ']'
        PRINT @v_result
        PRINT '----------------------------------------'
        PRINT @column_result 
        PRINT '----------------------------------------'
        PRINT @tree_column_result 
    END ;
GO
