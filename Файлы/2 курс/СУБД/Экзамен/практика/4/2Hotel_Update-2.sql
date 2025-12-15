UPDATE Review
SET ReviewDate = RN.ArrivalDate + DateDiff(day,PC.DepartureDate,PC.ArrivalDate)
from dbo.Reservation_Number RN 
left join dbo.PaymentCard PC ON PC.IDPaymentCard = RN.IDNumber
WHERE NumberDay > 0

UPDATE Review
SET ReviewDate = Getdate(), IDNumber = 0
from dbo.Reservation_Number RN 
left join dbo.PaymentCard PC ON PC.IDPaymentCard = RN.IDNumber
WHERE NumberDay = 0
