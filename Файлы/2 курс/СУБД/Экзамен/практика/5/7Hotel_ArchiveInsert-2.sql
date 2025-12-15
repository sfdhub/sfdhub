SELECT *
INTO [Reservation_Archive]
FROM [Reservation]
WHERE 1 = 0

GO
SET IDENTITY_INSERT Reservation_Archive ON

INSERT INTO dbo.Reservation_Archive(IDReserved,IDClient,EstimatedArrivalDate,NumberDays,EstimatedDepartureDate,IsExist,IsPaid,Cost)
SELECT R.*
FROM Reservation R
JOIN PaymentCard P ON R.IDReserved = P.IDPaymentCard
WHERE R.IsPaid = 1 AND DateDiff(day, EstimatedDepartureDate, Getdate()) > 365
SET IDENTITY_INSERT Reservation_Archive OFF