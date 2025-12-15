
USE [sample]

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE FUNCTION [Func]()
ALTER FUNCTION [Func]()
RETURNS TABLE
AS

	RETURN
		(
		SELECT CONCAT (UPPER(Фамилия), UPPER(Имя),UPPER(Отчество)) AS Result
		FROM Студенты
		)
GO