create table #НазванияРолей
(Роли nvarchar (50), Разрешения nvarchar (50))
insert into #НазванияРолей
exec sp_srvrolepermission
select * from #НазванияРолей
where Разрешения like 'GRANT%'