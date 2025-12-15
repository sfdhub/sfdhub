INSERT INTO [Reservation_Archive] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], 
[EstimatedDepartureDate], [IsExist], [IsPaid], [Cost])
SELECT [IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost]
FROM [Reservation]
WHERE [IsPaid] = 1;