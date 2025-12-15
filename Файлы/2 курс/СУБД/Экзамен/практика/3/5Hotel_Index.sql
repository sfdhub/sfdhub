CREATE INDEX IX_Numbers_Covering
ON dbo.Numbers (IDNumber, IsBusy)
INCLUDE (Cost, Floor, IsLux);
