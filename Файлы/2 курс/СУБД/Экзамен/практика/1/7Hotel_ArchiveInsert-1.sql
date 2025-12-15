SET IDENTITY_INSERT [dbo].[Reservation_Archive] ON
INSERT INTO Reservation_Archive
SELECT R.*
FROM Reservation R
JOIN PaymentCard P
ON R.IDReserved = P.IDPaymentCard
WHERE R.IsPaid = 1
AND R.NumberDays * R.Cost <= P.Payment
SET IDENTITY_INSERT [dbo].[Reservation_Archive] OFF
GO