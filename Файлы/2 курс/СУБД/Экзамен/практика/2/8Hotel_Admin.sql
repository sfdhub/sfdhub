USE [master];
GO
CREATE LOGIN hoteluser WITH PASSWORD = 'Hoste1U5er-2023';
ALTER LOGIN [hoteluser] WITH DEFAULT_DATABASE=[Hotel], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

USE [Hotel];
GO
CREATE SCHEMA [hotelmy];
GO

USE [Hotel];
GO
ALTER SCHEMA [hotelmy] TRANSFER [dbo].[Reservation_Archive];
GO

USE [Hotel];
GO
CREATE USER hoteluser FOR LOGIN hoteluser WITH DEFAULT_SCHEMA = [hotelmy];
GO
GRANT SELECT ON DATABASE::Hotel TO hoteluser;
GO
DENY DELETE ON SCHEMA::archive TO hoteluser;
GO