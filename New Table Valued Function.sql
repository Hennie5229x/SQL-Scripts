SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:
-- =============================================
CREATE FUNCTION fnNameHere
(	
	-- Input Param Here
)

RETURNS
@Table TABLE 
(
	--Define Return Table Columns
	Name NVARCHAR(50)
)
AS
BEGIN 
	
	INSERT INTO @Table
	SELECT 1

	RETURN
END

