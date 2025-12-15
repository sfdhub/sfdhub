CREATE PROCEDURE Proc_NumbersStat
@StartDay date, @EndDay date
AS
BEGIN
SELECT
RN.IDNumber,
COUNT(*) AS CountNumber,
SUM(N.Cost * DATEDIFF(day, RN.ArrivalDate, COALESCE(RN.IDReserved, GETDATE()))) AS TotalCost,
SUM(DATEDIFF(day, RN.ArrivalDate, COALESCE(RN.IDReserved, GETDATE()))) AS TotalDays
FROM Reservation_Number RN JOIN Numbers N ON RN.IDNumber = N.IDNumber
WHERE RN.ArrivalDate BETWEEN @StartDay AND @EndDay
GROUP BY RN.IDNumber
END;