DECLARE @Find NVARCHAR(254)
SET @Find = 'FindMe' --- SEPCIFY TEXT HERE

DECLARE @SQL NVARCHAR(MAX)
SET @SQL = '%' + @Find + '%'

SELECT DISTINCT B.name AS Object_Name,B.type_desc
FROM sys.sql_modules A 
INNER JOIN sys.objects B ON A.object_id = B.object_id
WHERE A.definition LIKE @SQL
ORDER BY B.type_desc