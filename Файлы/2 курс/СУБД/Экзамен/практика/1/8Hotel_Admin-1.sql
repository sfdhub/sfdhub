CREATE LOGIN hoteluser WITH PASSWORD = 'Hoste1U5er-2023'
CREATE USER hoteluser FOR LOGIN hoteluser
ALTER LOGIN hoteluser WITH DEFAULT_DATABASE = Hotel
CREATE SCHEMA hotelmy
ALTER SCHEMA hotelmy TRANSFER dbo.Reservation_Archive
EXEC sp_addrolemember 'db_datareader', 'hoteluser'
GRANT SELECT, INSERT, UPDATE ON SCHEMA::hotelmy TO hoteluser
DENY DELETE ON SCHEMA::hotelmy TO hoteluser