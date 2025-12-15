SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [Удаление студента]
	On dbo.Студенты
	INSTEAD OF DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DELETE dbo.Студенты
	FROM deleted
	WHERE deleted.Урок = Студенты.Урок
	--FROM deleted
	--WHERE deleted.Возраст = Студенты.Возраст
END
GO