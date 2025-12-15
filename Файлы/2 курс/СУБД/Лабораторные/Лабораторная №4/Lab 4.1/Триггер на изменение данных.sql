--CREATE TRIGGER [Идикатор изменения]
ALTER TRIGGER [Идикатор изменения]
	ON Студенты
	AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	Print 'Запись изменена'
END
GO