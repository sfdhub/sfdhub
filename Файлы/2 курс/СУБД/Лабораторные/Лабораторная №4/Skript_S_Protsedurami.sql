--Процедура Test выводит имя компьютера
--exec Test 

--Процедура DigitCount, которая делит на 10
--declare @num int = 1249
--declare @cnt int
--exec DigitCount @num, @cnt OUTPUT
--select @cnt

--Процедура подсчета количества системных хранимых процедур
--exec [Количество процедур]

--Процедура просчета времени года по дате 
--declare 
--	@period int ,
--	@date datetime,
--	@Year_time varchar(10)

--exec [Время года] 
--	@date = '18-05-2021',
--	@period = null,
--	@Year_time = @Year_time output

--select @Year_time

--Процедура проверки лет
--declare 
--	@DateYear datetime,
--	@CurrYear int,
--	@DiffYear int,
--	@Answ varchar(4)

--exec [Проверка лет]
--	@DateYear = '18-05-2015',
--	@CurrYear = null,
--	@DiffYear = null,
--	@Answ = @Answ output

--select @Answ

--Процедура проверки email
--exec [Проверка email] 'da@mail.ru'