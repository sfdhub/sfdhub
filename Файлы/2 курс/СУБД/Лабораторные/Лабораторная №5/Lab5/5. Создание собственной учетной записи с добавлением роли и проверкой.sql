create login Denis
with password = '0000',
DEFAULT_DATABASE = master 
go
create user Deniss for login Denis with default_schema = [dbo]
go
sp_helplogins
go
sp_addsrvrolemember 'Denis', 'sysadmin'

--Удаление учетной записи
--drop login Denis
--go
--drop user Deniss
--go
--sp_helplogins
--sp_dropsrvrolemember 'Deniss', 'sysadmin'