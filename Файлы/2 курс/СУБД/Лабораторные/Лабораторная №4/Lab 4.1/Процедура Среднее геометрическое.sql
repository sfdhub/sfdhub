USE [sample]
GO
--CREATE FUNCTION [Среднее геометрическое]
ALTER FUNCTION [Среднее геометрическое]
(
@Value1 int, @Value2 int
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	SELECT @Result = SQRT(@Value1*@Value2)
	RETURN @Result
END
GO