DECLARE @Find NVARCHAR(254)
SET @Find = 'FindMe' --- SEPCIFY COLUMN HERE

DECLARE @SQL NVARCHAR(MAX)
SET @SQL = '%' + @Find + '%'


SELECT		A.name AS ColName, 
			B.name AS TableName,
			C.name AS ViewName
FROM		sys.columns A
LEFT JOIN	sys.tables B ON A.object_id = B.object_id
LEFT JOIN	sys.views C ON A.object_id = C.object_id
WHERE		A.name LIKE @SQL