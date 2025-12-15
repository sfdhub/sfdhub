
ALTER function [dbo].[day_of_week] (@date date)

returns varchar (60)
as
begin
	return DATENAME(weekday, @date)
end