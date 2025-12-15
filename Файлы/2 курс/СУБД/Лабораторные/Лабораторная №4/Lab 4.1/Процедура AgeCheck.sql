USE [sample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[AgeCheck]
 @age datetime
AS
SET DATEFORMAT ydm;
IF (YEAR(@age) <= YEAR(GETDATE()) - 16 AND MONTH(@age) <= MONTH(GETDATE()) AND DAY(@age) <=DAY(GETDATE()))
SELECT 'Возраст > 16 полных лет'
ELSE
SELECT 'Возраст < 16 полных лет'
