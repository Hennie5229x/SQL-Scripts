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
	-- INPUT PARAMETERS
	@P0 INT
)
RETURNS NVARCHAR
AS
BEGIN
	-- DECLARE OUTPUT VALUE
	DECLARE @P1 NVARCHAR(50)
	
	-- SET OUTPUT VALUE HERE
	SET @P1 = @P0

	-- OUTPUT VALUE
	RETURN @P1

END
GO

