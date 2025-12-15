--1. Роли сервера
--sp_helpsrvrole

--2. Разрешенные действия сервера
--sp_srvrolepermission 'dbcreator'

--3. Данные учетной записи (sa)
--sp_helplogins 'sa'

--4. Роли с возможностью создания и удаления учетных записей 
--create table #НазванияРолей
--(Роли nvarchar (50), Разрешения nvarchar (50))
--insert into #НазванияРолей
--exec sp_srvrolepermission
--select * from #НазванияРолей
--where Разрешения like 'GRANT%'

--5. Создание собственной учетной записи с добавлением роли и проверкой
--create login Danya
--with password = '123',
--DEFAULT_DATABASE = master 
--go
--create user Daniil for login Danya with default_schema = [dbo]
--go
--sp_helplogins
--go
--sp_addsrvrolemember 'Danya', 'sysadmin'
--Удаление учетной записи
--drop login Danya
--go
--drop user Daniil
--go
--sp_helplogins
--sp_dropsrvrolemember 'Danya', 'sysadmin'

--6. Изменение пароля учетной записи
--sp_password '123', '1234', 'Danya'
--ALTER LOGIN Danya WITH PASSWORD = '1234';

--7. Создание пользователя manager 
--create login manager
--with password = '123',
--DEFAULT_DATABASE = [Товарный маркетинг] 
--go
--create user manager for login manager with default_schema = [dbo]
--go
--sp_helplogins

--8. manager обладающий возможностью просмотра содержимого БД
--sp_addrolemember 'db_datareader', 'manager'
--SELECT * FROM [Товарный маркетинг].[Клиент]

--9. manager без возможности просмотра содержимого БД
--sp_addrolemember 'db_denydatareader', 'manager'
--drop login manager
--go
--drop user manager
--go
--sp_helplogins

--10. список учетных записей, входящих в роль diskadmin
--sp_helpsrvrolemember 'diskadmin'

--11. Создание новой роли с правом выборки
--sp_addrole 'managers', 'db_datareader'
--use [Товарный маркетинг]
--grant select on [Клиент] to managers

--12. Добавление manager (user) на роль managers
--exec sp_addrolemember @rolename = 'managers',
--@membername = 'manager'

--13. Удаление роли
--sp_droprole 'managers'