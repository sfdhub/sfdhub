CREATE TRIGGER [Индикатор Удаления]
	ON Студенты
	AFTER DELETE
AS
BEGIN
	SET NOCOUNT ON;
	Print 'Запись удалена'
END
GO