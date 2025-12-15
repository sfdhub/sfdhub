
CREATE VIEW View_Reviews
AS
SELECT
C.IDClient,
CONCAT(C.Surname, ' ', C.Name, ' ', C.Patronymic) AS FIO,
COUNT(R.IDReview) AS NumberReviews,
SUM(PC.Payment) AS Payment
FROM Clients C
	LEFT JOIN Review R ON C.IDClient = R.IDClient
	LEFT JOIN Accomodation A ON A.IDClient = C.IDClient
	LEFT JOIN PaymentCard PC ON A.IDPaymentCard = PC.IDPaymentCard
GROUP BY C.IDClient, CONCAT(C.Surname, ' ', C.Name, ' ', C.Patronymic)
