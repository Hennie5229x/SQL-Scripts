

DECLARE @Search NVARCHAR(100) = 'USA';

-- Store results
IF OBJECT_ID('tempdb..#SearchResults') IS NOT NULL
    DROP TABLE #SearchResults;

CREATE TABLE #SearchResults (
    TableName SYSNAME,
    ColumnName SYSNAME,
    ValueFound NVARCHAR(MAX)
);

DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @table NVARCHAR(512);
DECLARE @column NVARCHAR(512);

-- Cursor to go through each table and column
DECLARE cur CURSOR FAST_FORWARD FOR
SELECT 
    QUOTENAME(s.name) + '.' + QUOTENAME(t.name) AS TableName,
    QUOTENAME(c.name) AS ColumnName
FROM sys.columns AS c
JOIN sys.tables AS t ON c.object_id = t.object_id
JOIN sys.schemas AS s ON t.schema_id = s.schema_id
WHERE t.type = 'U'
  AND c.collation_name IS NOT NULL -- only textual columns
ORDER BY s.name, t.name;

OPEN cur;
FETCH NEXT FROM cur INTO @table, @column;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = N'
        INSERT INTO #SearchResults (TableName, ColumnName, ValueFound)
        SELECT TOP (10) 
            N''' + @table + N''' AS TableName,
            N''' + @column + N''' AS ColumnName,
            CAST(' + @column + N' AS NVARCHAR(MAX)) AS ValueFound
        FROM ' + @table + N'
        WHERE CAST(' + @column + N' AS NVARCHAR(MAX)) LIKE N''%' + @Search + N'%'';';

    BEGIN TRY
        EXEC sp_executesql @sql;
    END TRY
    BEGIN CATCH
        -- Ignore conversion or permission errors
        PRINT 'Skipped: ' + @table + '.' + @column;
    END CATCH;

    FETCH NEXT FROM cur INTO @table, @column;
END;

CLOSE cur;
DEALLOCATE cur;

-- View results
SELECT	REPLACE(REPLACE(TableName,']',''),'[','') AS TableName,
		REPLACE(REPLACE(ColumnName,']',''),'[','') AS ColumnName,
		ValueFound

FROM	#SearchResults;
