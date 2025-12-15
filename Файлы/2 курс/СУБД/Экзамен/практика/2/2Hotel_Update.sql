use Hotel;

update Review

set ReviewDate = case 

	when IDClient < 5 then '2021-05-10'
	when IDClient >= 5 and IDClient < 30 then '2022-12-12'
	when IDClient >= 30 then '2023-05-05'

end