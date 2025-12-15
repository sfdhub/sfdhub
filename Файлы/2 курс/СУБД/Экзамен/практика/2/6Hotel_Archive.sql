CREATE TABLE [Reservation_Archive]
(
  [IDReserved] INT PRIMARY KEY not null,
  [IDClient] INT not null,
  [EstimatedArrivalDate] DATE not null,
  [NumberDays] INT not null,
  [EstimatedDepartureDate] DATE null,
  [IsExist] BIT null,
  [IsPaid] BIT null,
  [Cost] MONEY null,
);