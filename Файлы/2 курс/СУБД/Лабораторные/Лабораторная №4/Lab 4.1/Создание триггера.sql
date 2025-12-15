--CREATE TRIGGER [Индикатор Добавления]
ALTER TRIGGER [Индикатор Добавления]
	ON dbo.Студенты
	AFTER Insert
AS
BEGIN
	SET NOCOUNT ON;
	Print 'Запись добавлена'
END