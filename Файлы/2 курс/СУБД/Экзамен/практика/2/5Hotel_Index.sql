CREATE NONCLUSTERED INDEX IX_Reservation_Number_Covering
ON [dbo].[Reservation_Number] ([ArrivalDate], [IDClient])
INCLUDE ([IDNumber], [IDReserved], [NumberDay], [NumberPeople])