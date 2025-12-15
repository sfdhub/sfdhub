USE Hotel

ALTER TABLE dbo.Review
ADD ReviewDate DATE CONSTRAINT [DF_ReviewDate] DEFAULT GETDATE()
GO

ALTER TABLE dbo.Review
ALTER COLUMN [Description] nvarchar(500)
GO