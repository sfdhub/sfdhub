CREATE INDEX IX_Reservation_Number_Covering
ON dbo.Reservation_Number (IDClient, ArrivalDate)
INCLUDE (IDNumber, IDReserved, NumberDay, NumberPeople);