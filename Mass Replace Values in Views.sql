DECLARE @Find NVARCHAR(254)
DECLARE @ReplaceWith NVARCHAR(254)

SET @Find = ''
SET @ReplaceWith = ''

DECLARE @SQL NVARCHAR(MAX);
SET @SQL = N' DECLARE @SQL NVARCHAR(MAX); SET @SQL = N'''';';

SELECT @SQL = @SQL	+ 'SELECT @SQL = REPLACE(REPLACE(definition, N''' + @Find + ''', N''' + @ReplaceWith + '''), N''CREATE VIEW'', N''ALTER VIEW'') + N'''' FROM sys.sql_modules M WHERE M.object_id = '
					+ CAST(M.object_id AS NVARCHAR(50))
					+ '; EXEC (@SQL);'
					--+ '; SELECT (@SQL);'
FROM sys.sql_modules M
JOIN sys.objects O ON O.object_id = M.object_id
WHERE O.type = 'V';

EXEC (@SQL)
--SELECT (@SQL)