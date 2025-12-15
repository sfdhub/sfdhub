USE [sample]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ALTER PROC [dbo].[DateCheck]
CREATE PROC [dbo].[DateCheck]
 @MyDate datetime
AS
SET DATEFORMAT dmy;
IF MONTH(@MyDate)<3 SELECT ('Зима')
ELSE IF MONTH(@MyDate)<6 SELECT ('Весна')
ELSE IF MONTH(@MyDate)<9 SELECT ('Лето')
ELSE IF MONTH(@MyDate)<12 SELECT ('Осень')
ELSE SELECT ('Зима')
