CREATE VIEW View_ReviewClients AS
SELECT
C.IDClient,
CONCAT(C.Surname, ' ', C.Name, ' ', C.Patronymic) AS FIO,
COUNT(R.IDReview) AS NumberReviews,
SUM(PC.Payment) AS Payment
FROM Clients C
LEFT JOIN Review R ON C.IDClient = R.IDClient
LEFT JOIN PaymentCard PC ON C.IDClient = PC.IDClient
GROUP BY C.IDClient, CONCAT(C.Surname, ' ', C.Name, ' ', C.Patronymic)
















CREATE VIEW [View_TotalDeptors] AS
SELECT
C.[IDClient],
CONCAT(C.[Surname], ' ', C.[Name], ' ', C.[Patronymic]) AS ÔÈÎ,
SUM(N.[Cost] * RN.[NumberDay]) AS Cost,
SUM(PC.[Payment]) AS Payment
FROM
[Clients] C
JOIN [Accomodation] A ON C.[IDClient] = A.[IDClient] AND A.[PayDate] IS NULL
JOIN [PaymentCard] PC ON A.[IDPaymentCard] = PC.[IDPaymentCard]
JOIN [Reservation] R ON A.[IDReserved] = R.[IDReserved]
JOIN [Reservation_Number] RN ON C.[IDClient] = RN.[IDClient] AND R.[IDReserved] = RN.[IDReserved]
JOIN [Numbers] N ON RN.[IDNumber] = N.[IDNumber]
GROUP BY
C.[IDClient],
C.[Surname],
C.[Name],
C.[Patronymic]
HAVING
SUM(PC.[Payment]) > 0