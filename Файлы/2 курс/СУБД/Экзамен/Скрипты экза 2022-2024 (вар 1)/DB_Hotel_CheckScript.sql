/************************ УДАЛЕНИЕ ЭТАЛОНА БД  *************************/

USE [master]
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name =  N'Hotel_Model')
DROP DATABASE [Hotel_Model]


/************************ НАЧАЛО ИНИЦИАЛИЗАЦИИ ЭТАЛОНА БД  *************************/
USE [master]
GO

CREATE DATABASE [Hotel_Model]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel_Model', FILENAME = N'C:\SQLDATA\Hotel_Model.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Hotel_Model_log', FILENAME = N'C:\SQLDATA\Hotel_Model_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Hotel_Model] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel_Model].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO


USE [Hotel_Model]
GO
/****** Object:  Schema [archive]    Script Date: 26.06.2023 6:48:01 ******/
CREATE SCHEMA [archive]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_FileExists]    Script Date: 26.06.2023 6:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_FileExists](@filename VARCHAR(300))
  RETURNS INT
AS
BEGIN

  DECLARE @file_exists AS INT
  EXEC master..xp_fileexist @filename, @file_exists OUTPUT
  RETURN @file_exists

END
GO
/****** Object:  Table [dbo].[Accomodation]    Script Date: 26.06.2023 6:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accomodation](
	[IDAccomodation] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[IDReserved] [int] NOT NULL,
	[IDPaymentCard] [int] NOT NULL,
	[PayDate] [date] NULL,
 CONSTRAINT [PK_Accomodation] PRIMARY KEY CLUSTERED 
(
	[IDAccomodation] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 26.06.2023 6:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[IDClient] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [varchar](30) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Patronymic] [varchar](30) NOT NULL,
	[Document] [varchar](25) NOT NULL,
	[DocumentSeriesAndNumber] [varchar](40) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Gender] [varchar](3) NOT NULL,
	[HomeAddress] [varchar](50) NULL,
	[PhoneNumber] [varchar](11) NOT NULL,
 CONSTRAINT [PK_Clients_IDClient] PRIMARY KEY CLUSTERED 
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Numbers]    Script Date: 26.06.2023 6:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Numbers](
	[IDNumber] [smallint] IDENTITY(1,1) NOT NULL,
	[Cost] [money] NOT NULL,
	[Floor] [smallint] NOT NULL,
	[PhoneNumber] [varchar](11) NOT NULL,
	[NumberName] [varchar](10) NOT NULL,
	[IsLux] [bit] NULL,
	[NumberOfRooms] [tinyint] NULL,
	[NumberOfPlaces] [tinyint] NULL,
	[NumberOfFreePlaces] [tinyint] NULL,
	[IsBusy] [bit] NULL,
	[Description] [varchar](1000) NULL,
 CONSTRAINT [PK_Numbers_IDNumber] PRIMARY KEY CLUSTERED 
(
	[IDNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentCard]    Script Date: 26.06.2023 6:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentCard](
	[IDPaymentCard] [int] IDENTITY(1,1) NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[DepartureDate] [datetime] NOT NULL,
	[Payment] [money] NOT NULL,
 CONSTRAINT [PK_PaymentCard] PRIMARY KEY CLUSTERED 
(
	[IDPaymentCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation_Number]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation_Number](
	[IDNumber] [smallint] NOT NULL,
	[IDClient] [int] NOT NULL,
	[ArrivalDate] [datetime] NOT NULL,
	[IDReserved] [int] NULL,
	[NumberDay] [tinyint] NOT NULL,
	[NumberPeople] [tinyint] NOT NULL,
 CONSTRAINT [PK_Reservation_Number] PRIMARY KEY CLUSTERED 
(
	[IDNumber] ASC,
	[IDClient] ASC,
	[ArrivalDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_TotalDeptors]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_TotalDeptors]
AS
SELECT c.[IDClient]
, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] as ФИО
, n.[Cost]*rn.[NumberDay] as Cost
, p.[Payment]
FROM [dbo].[Clients] c JOIN [dbo].[Accomodation] a ON c.IDClient = a.IDClient
JOIN [PaymentCard] p ON p.[IDPaymentCard] = a.[IDPaymentCard]
JOIN [dbo].[Reservation_Number] rn ON rn.[IDClient] = c.[IDClient] 
JOIN [dbo].[Numbers] n ON n.[IDNumber] = rn.[IDNumber]
WHERE a.[PayDate] IS NULL
GO
/****** Object:  View [dbo].[View_TotalDeptors_Sum]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[View_TotalDeptors_Sum]
AS
		SELECT c.[IDClient]
		, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] as ФИО
		, n.[Cost]*rn.[NumberDay] as Cost
		, SUM(p.[Payment]) as [Payment]
		FROM [dbo].[Clients] c JOIN [dbo].[Accomodation] a ON c.IDClient = a.IDClient
		JOIN [PaymentCard] p ON p.[IDPaymentCard] = a.[IDPaymentCard]
		JOIN [dbo].[Reservation_Number] rn ON rn.[IDClient] = c.[IDClient] 
		JOIN [dbo].[Numbers] n ON n.[IDNumber] = rn.[IDNumber]
		WHERE a.[PayDate] IS NULL
		GROUP BY
		c.[IDClient]
		, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] 
		, n.[Cost]*rn.[NumberDay] 

GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[IDReserved] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[EstimatedArrivalDate] [date] NOT NULL,
	[NumberDays] [tinyint] NOT NULL,
	[EstimatedDepartureDate] [date] NULL,
	[IsExist] [bit] NULL,
	[IsPaid] [bit] NULL,
	[Cost] [money] NULL,
	[TypeNumber] [varchar](11) NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[IDReserved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation_Archive]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation_Archive](
	[IDReserved] [int] NOT NULL,
	[IDClient] [int] NOT NULL,
	[EstimatedArrivalDate] [date] NOT NULL,
	[NumberDays] [tinyint] NOT NULL,
	[EstimatedDepartureDate] [date] NULL,
	[IsExist] [bit] NULL,
	[IsPaid] [bit] NULL,
	[Cost] [money] NULL,
	[TypeNumber] [varchar](11) NULL,
 CONSTRAINT [PK_Reservation_Archive] PRIMARY KEY CLUSTERED 
(
	[IDReserved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[IDReview] [int] IDENTITY(1,1) NOT NULL,
	[IDClient] [int] NOT NULL,
	[Score] [varchar](1) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[IDReview] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accomodation] ON 

INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (5, 18, 2, 2, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (6, 5, 4, 4, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (9, 18, 5, 2, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (12, 1, 13, 14, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (16, 18, 8, 12, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (18, 3, 15, 11, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (19, 5, 2, 3, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (20, 18, 2, 12, CAST(N'2021-05-05' AS Date))
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (21, 32, 4, 4, NULL)
INSERT [dbo].[Accomodation] ([IDAccomodation], [IDClient], [IDReserved], [IDPaymentCard], [PayDate]) VALUES (22, 34, 8, 3, NULL)
SET IDENTITY_INSERT [dbo].[Accomodation] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (1, N'Гордеева', N'Инна', N'Алексеевна', N'Passport', N'ffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (3, N'Гордеева', N'Валерия', N'Алексеевна', N'Passport', N'аffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (5, N'Гордеева', N'Инна', N'Алексеевна', N'Passport', N'fggbfffff', CAST(N'2000-12-04' AS Date), N'Ж', N'авпв', N'89323323612')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (18, N'Попова', N'Валерия', N'Дмитриевна', N'Passport', N'rfee', CAST(N'2000-12-04' AS Date), N'М', NULL, N'8999999999')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (30, N'Шевченко', N'Алексей', N'Витальевич', N'Passport', N'dgfdf', CAST(N'2000-12-04' AS Date), N'М', N'а', N'9888888888')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (31, N'Матвеев', N'Александр', N'Александрович', N'Passport', N'dfd', CAST(N'2000-12-04' AS Date), N'М', NULL, N'9876543234')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (32, N'Согуренко', N'Софья', N'Александровна', N'Passport', N'1', CAST(N'2000-12-04' AS Date), N'Ж', NULL, N'8765432')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (34, N'Низаметдинов', N'Шерзодбек', N'Шавкаджонович', N'Passport', N'2', CAST(N'2000-12-04' AS Date), N'М', NULL, N'23456765')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (35, N'Попович', N'Валерия', N'Дмитриевна', N'Passport', N'3', CAST(N'2020-04-04' AS Date), N'Ж', NULL, N'0987654432')
INSERT [dbo].[Clients] ([IDClient], [Surname], [Name], [Patronymic], [Document], [DocumentSeriesAndNumber], [Birthday], [Gender], [HomeAddress], [PhoneNumber]) VALUES (37, N'Олегов', N'Олегов', N'Олегович', N'Passport', N'4', CAST(N'2020-02-05' AS Date), N'М', NULL, N'0987654333')
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Numbers] ON 

INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (1, 1000.0000, 1, N'8999999', N'Ф1', NULL, 1, 2, 0, 1, NULL)
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (2, 2000.0000, 2, N'89999999', N'Л1', 1, 2, 1, 0, 0, N'Люкс с видом во двор')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (3, 3000.0000, 3, N'98765432', N'Л3', 1, 2, 2, 2, 1, N'Люкс с видом на море')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (4, 5000.0000, 3, N'876543456', N'Л2', 1, 3, 2, 2, 1, N'Супер люкс')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (5, 1500.0000, 1, N'987654334', N'Ф2', NULL, 1, 1, 0, 1, N'Стандарт')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (6, 1300.0000, 2, N'987654325', N'Ф2', NULL, 1, 1, 0, 1, N'Стандарт')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (7, 2000.0000, 2, N'9876543345', N'Л4', 1, 2, 1, 0, 0, N'Люкс одноместный')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (8, 4500.0000, 3, N'9876543455', N'Л5', 1, 3, 3, 1, 0, N'Супер люкс')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (9, 4000.0000, 4, N'9876544543', N'Ф3', NULL, 1, 2, 0, 0, N'Стандарт двухместный')
INSERT [dbo].[Numbers] ([IDNumber], [Cost], [Floor], [PhoneNumber], [NumberName], [IsLux], [NumberOfRooms], [NumberOfPlaces], [NumberOfFreePlaces], [IsBusy], [Description]) VALUES (10, 3500.0000, 6, N'8546368383', N'С1', NULL, 2, 2, 1, 0, NULL)
SET IDENTITY_INSERT [dbo].[Numbers] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentCard] ON 

INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (2, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-10T00:00:00.000' AS DateTime), 10000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (3, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (4, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 3000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (6, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2500.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (7, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (9, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (10, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 3000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (11, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (12, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 4000.0000)
INSERT [dbo].[PaymentCard] ([IDPaymentCard], [ArrivalDate], [DepartureDate], [Payment]) VALUES (14, CAST(N'2021-05-05T00:00:00.000' AS DateTime), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 5000.0000)
SET IDENTITY_INSERT [dbo].[PaymentCard] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (2, 18, CAST(N'2021-05-05' AS Date), 5, CAST(N'2021-10-05' AS Date), 1, 1, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (4, 1, CAST(N'2021-05-05' AS Date), 5, CAST(N'2021-05-10' AS Date), 0, NULL, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (5, 3, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05' AS Date), 1, 1, 3000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (8, 18, CAST(N'2021-05-05' AS Date), 18, CAST(N'2021-05-05' AS Date), 1, 1, 1111.0000, N'Стандартный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (9, 1, CAST(N'2021-05-05' AS Date), 1, CAST(N'2021-05-05' AS Date), 1, NULL, 6000.0000, N'Люкс')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (12, 32, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05' AS Date), 1, 1, 3000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (13, 32, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05' AS Date), 1, NULL, 2900.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (15, 3, CAST(N'2021-05-05' AS Date), 2, CAST(N'2021-05-05' AS Date), 1, 1, 2000.0000, N'Улучшенный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (16, 1, CAST(N'2021-05-05' AS Date), 1, CAST(N'2021-05-05' AS Date), 1, 1, 1500.0000, N'Стандартный')
INSERT [dbo].[Reservation] ([IDReserved], [IDClient], [EstimatedArrivalDate], [NumberDays], [EstimatedDepartureDate], [IsExist], [IsPaid], [Cost], [TypeNumber]) VALUES (17, 3, CAST(N'2021-05-05' AS Date), 3, CAST(N'2021-05-05' AS Date), 1, 1, 1500.0000, N'Стандартный')
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (1, 1, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 4, 5, 2)
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (4, 18, CAST(N'2021-05-05T00:00:00.000' AS DateTime), 2, 5, 2)
INSERT [dbo].[Reservation_Number] ([IDNumber], [IDClient], [ArrivalDate], [IDReserved], [NumberDay], [NumberPeople]) VALUES (1, 32, CAST(N'2022-01-10T12:00:00.000' AS DateTime), 13, 10, 1)
GO
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (1, 18, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (3, 1, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (4, 1, N'3', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (5, 3, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (7, 5, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (8, 18, N'4', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (9, 18, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (10, 32, N'5', N'Без балкона с окнами во двор')
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (11, 34, N'2', NULL)
INSERT [dbo].[Review] ([IDReview], [IDClient], [Score], [Description]) VALUES (12, 3, N'3', NULL)
SET IDENTITY_INSERT [dbo].[Review] OFF
GO
/****** Object:  Index [IX_Accomodation_IDClient]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Accomodation_IDClient] ON [dbo].[Accomodation]
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [IX_Accomodation_IDReserved_IDPaymentCard_IDClient]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Accomodation_IDReserved_IDPaymentCard_IDClient] ON [dbo].[Accomodation]
(
	[IDReserved] ASC,
	[IDPaymentCard] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_Clients_DocumentSeriesAndNumber]    Script Date: 26.06.2023 6:48:02 ******/
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [UIX_Clients_DocumentSeriesAndNumber] UNIQUE NONCLUSTERED 
(
	[DocumentSeriesAndNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Clients_Surname]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Clients_Surname] ON [dbo].[Clients]
(
	[Surname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_IDClient]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_IDClient] ON [dbo].[Reservation]
(
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_Number]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_Number] ON [dbo].[Reservation_Number]
(
	[IDReserved] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reservation_Number_Covering]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [IX_Reservation_Number_Covering] ON [dbo].[Reservation_Number]
(
	[ArrivalDate] ASC,
	[IDClient] ASC
)
INCLUDE([IDNumber],[IDReserved],[NumberDay],[NumberPeople]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20211026-122820]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20211026-122820] ON [dbo].[Reservation_Number]
(
	[IDReserved] ASC,
	[IDNumber] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20211026-122836]    Script Date: 26.06.2023 6:48:02 ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20211026-122836] ON [dbo].[Review]
(
	[IDReview] ASC,
	[IDClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_EstimatedArrivalDate]  DEFAULT (getdate()) FOR [EstimatedArrivalDate]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_TypeNumber]  DEFAULT ('Стандартный') FOR [TypeNumber]
GO
ALTER TABLE [dbo].[Accomodation]  WITH CHECK ADD  CONSTRAINT [FK_Accomodation_PaymentCard] FOREIGN KEY([IDPaymentCard])
REFERENCES [dbo].[PaymentCard] ([IDPaymentCard])
GO
ALTER TABLE [dbo].[Accomodation] CHECK CONSTRAINT [FK_Accomodation_PaymentCard]
GO
ALTER TABLE [dbo].[Accomodation]  WITH CHECK ADD  CONSTRAINT [FK_Accomodation_Reservation] FOREIGN KEY([IDReserved])
REFERENCES [dbo].[Reservation] ([IDReserved])
GO
ALTER TABLE [dbo].[Accomodation] CHECK CONSTRAINT [FK_Accomodation_Reservation]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Archive_Client] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Archive_Client]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Client] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Client]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [Client_reservation_number] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [Client_reservation_number]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Number_Reservation] FOREIGN KEY([IDReserved])
REFERENCES [dbo].[Reservation] ([IDReserved])
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [FK_Reservation_Number_Reservation]
GO
ALTER TABLE [dbo].[Reservation_Number]  WITH CHECK ADD  CONSTRAINT [Number_reservation_number] FOREIGN KEY([IDNumber])
REFERENCES [dbo].[Numbers] ([IDNumber])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation_Number] CHECK CONSTRAINT [Number_reservation_number]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [Client_review] FOREIGN KEY([IDClient])
REFERENCES [dbo].[Clients] ([IDClient])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [Client_review]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Client_Documents] CHECK  (([Document]='Passport' OR [Document]='Birth certificate' OR [Document]='Drivers licence'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Client_Documents]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [CK_Reservation_Archive_TypeNumber] CHECK  (([TypeNumber]='Стандартный' OR [TypeNumber]='Улучшенный' OR [TypeNumber]='Люкс'))
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [CK_Reservation_Archive_TypeNumber]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [CK_Reservation_TypeNumber] CHECK  (([TypeNumber]='Стандартный' OR [TypeNumber]='Улучшенный' OR [TypeNumber]='Люкс'))
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [CK_Reservation_TypeNumber]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [Scores_1096710659] CHECK  (([Score]=(1) OR [Score]=(2) OR [Score]=(3) OR [Score]=(4) OR [Score]=(5)))
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [Scores_1096710659]
GO
/****** Object:  StoredProcedure [dbo].[Proc_NumbersStatistic]    Script Date: 26.06.2023 6:48:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_NumbersStatistic] 
	@StartDay [date] 
	, @EndDay [date]
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT n.IDNumber
	, COUNT(ISNULL([IDReserved],0)) AS CountNumber
	, SUM(ISNULL([Cost]*[NumberDay],0)) AS TotalCost
	, SUM(ISNULL([NumberDay],0)) AS TotalDays
	FROM [dbo].[Numbers] n LEFT JOIN [Reservation_Number]  rn ON n.IDNumber = rn.IDNumber
		AND rn.ArrivalDate BETWEEN @StartDay AND @EndDay
	GROUP BY n.IDNumber
	ORDER BY n.IDNumber
	 
END
GO
USE [master]
GO
ALTER DATABASE [Hotel_Model] SET  READ_WRITE 
GO

/************************ КОНЕЦ ИНИЦИАЛИЗАЦИИ БАЗЫ  *************************/



/************************ НАЧАЛО ПРОВЕРКИ  *************************/

SET NOCOUNT ON

USE [Hotel]

IF NOT EXISTS (SELECT * FROM [Hotel].sys.columns WHERE name = 'TypeNumber')
ALTER TABLE [dbo].[Reservation] ADD [TypeNumber] VARCHAR(1);
GO

DECLARE @Total decimal(5,1) = 0;
DECLARE @sql varchar(2000);
--IF NOT EXISTS (SELECT * FROM [Hotel].sys.views WHERE name = 'View_TotalDeptors')
--	CREATE VIEW [dbo].[View_TotalDeptors] 
--	AS
--	SELECT 0 AS [IDClient] , '' as [ФИО], 0.0 as COST, 0.0 as Payment;

--	SET @Total = @Total -1;
--PRINT @Total

--*/


/******  Вариант №1  ******/
/***  Задание №1 ***/
PRINT '/*** ЗАДАНИЕ #1 ***/'
IF EXISTS (SELECT * FROM Hotel.sys.columns WHERE name = 'TypeNumber' AND OBJECT_NAME(object_id) = 'Reservation' AND max_length >10)
BEGIN 
SET @Total = @Total + 1
PRINT 'Задание 1.1 выполнено верно'
END
ELSE
PRINT 'Задание 1.1 НЕ выполнено'
PRINT '@Total 1.1 = ' + CONVERT(VARCHAR(5),@Total)

PRINT ''
IF EXISTS (SELECT * FROM Hotel.sys.check_constraints WHERE name = 'CK_Reservation_TypeNumber' AND OBJECT_NAME(parent_object_id) = 'Reservation'
AND ((definition LIKE '%Стандартный%' AND definition LIKE '%Улучшенный%' AND definition LIKE '%Люкс%') AND definition NOT LIKE '%LIKE%'))
	BEGIN 
		SET @Total = @Total + 1
		PRINT 'Задание 1.2 выполнено верно'
	END
	ELSE
	IF EXISTS (SELECT * FROM Hotel.sys.check_constraints WHERE name = 'CK_Reservation_TypeNumber' AND OBJECT_NAME(parent_object_id) = 'Reservation'
AND ((definition LIKE '%Стандартный%' AND definition LIKE '%Улучшенный%' AND definition LIKE '%Люкс%') AND definition LIKE '%LIKE%'))

		PRINT 'Задание 1.2 выполнено НЕ ВЕРНО'
	ELSE
		PRINT 'Задание 1.2 НЕ выполнено'
PRINT '@Total 1 = ' + CONVERT(VARCHAR(5), @Total)

/***  Задание №2 ***/
PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #2 ***/'

BEGIN TRY
IF NOT EXISTS (SELECT * FROM [Hotel].sys.columns WHERE name = 'TypeNumber' AND OBJECT_NAME(object_id) = 'Reservation')
BEGIN
RAISERROR('Поле [TypeNumber] в таблице [Reservation] НЕ создано', 10, 1)
GOTO Label1
END
	--DECLARE @TableHotel_Model TABLE (TypeNumber VARCHAR(12), Number INT);
	--DECLARE @TableHotel TABLE ([TypeNumber] VARCHAR(12), [Number] INT);

	--INSERT INTO @TableHotel_Model
	--SELECT [TypeNumber], COUNT(1) FROM  [Hotel_Model].[dbo].[Reservation] GROUP BY TypeNumber;

	--INSERT INTO @TableHotel
	--SELECT [TypeNumber], COUNT(1) FROM  [Hotel].[dbo].[Reservation] GROUP BY TypeNumber;
ELSE
	IF NOT EXISTS(
		SELECT * FROM [Hotel_Model].[dbo].[Reservation]
		EXCEPT
		SELECT * FROM [Hotel].[dbo].[Reservation])
	BEGIN 
	SET @Total = @Total + 1
	PRINT 'Задание 2 выполнено верно'
	END
	ELSE

	PRINT 'Задание 2 НЕ выполнено'
END TRY
BEGIN CATCH
	THROW
	PRINT 'Задание 2 НЕ выполнено'
END CATCH
label1:  
PRINT '@Total 2 = ' + CONVERT(VARCHAR(5),@Total)

/***  Задание №3  ***/

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #3 ***/'

IF NOT EXISTS (SELECT * FROM Hotel.sys.views WHERE name = 'View_TotalDeptors') 
BEGIN
	PRINT 'Задание 3 представление НЕ создано'

GOTO label2
END
ELSE 
BEGIN 
	SET @Total = @Total + 1
	PRINT 'Задание 3.1 представление создано'
/*
		SELECT c.[IDClient]
		, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] as ФИО
		, n.[Cost]*rn.[NumberDay] as Cost
		, SUM(p.[Payment])
		FROM [dbo].[Clients] c JOIN [dbo].[Accomodation] a ON c.IDClient = a.IDClient
		JOIN [PaymentCard] p ON p.[IDPaymentCard] = a.[IDPaymentCard]
		JOIN [dbo].[Reservation_Number] rn ON rn.[IDClient] = c.[IDClient] 
		JOIN [dbo].[Numbers] n ON n.[IDNumber] = rn.[IDNumber]
		WHERE a.[PayDate] IS NULL
		GROUP BY
		c.[IDClient]
		, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] 
		, n.[Cost]*rn.[NumberDay] 
*/
	IF NOT EXISTS(
		SELECT * FROM [Hotel_Model].[dbo].[View_TotalDeptors_Sum]
		EXCEPT
		SELECT * FROM [Hotel].[dbo].[View_TotalDeptors]
		)
	BEGIN 
	SET @Total = @Total + 2
	PRINT 'Задание 3.2 - представление создано ВЕРНО'
	END
	ELSE
	IF NOT EXISTS(
		SELECT * FROM [Hotel_Model].[dbo].[View_TotalDeptors]
		EXCEPT
		SELECT * FROM [Hotel].[dbo].[View_TotalDeptors]
		)
	BEGIN 
	SET @Total = @Total + 1
	PRINT 'Задание 3.2 - представление создано НЕ СОВСЕМ верно'
	END
	ELSE
		PRINT 'Задание 3.2 - представление создано НЕ верно'
END
label2:
PRINT '@Total 3 = ' + CONVERT(VARCHAR(5),@Total)


/***  Задание №4  ***/

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #4 ***/'
/*
SELECT n.[IDNumber]
		, [IDReserved]
		, [Cost]*[NumberDay]
		, [NumberDay]
  FROM [Hotel].[dbo].[Reservation_Number] rn RIGHT JOIN [Hotel].[dbo].[Numbers] n ON n.IDNumber = rn.IDNumber

SELECT n.[IDNumber]
		, COUNT([IDReserved]) as CountNumber
		, ISNULL(SUM([Cost]*[NumberDay]),0) as TotalCost
		, ISNULL(SUM([NumberDay]),0) as TotalDays
  FROM [Hotel].[dbo].[Reservation_Number] rn RIGHT JOIN [Hotel].[dbo].[Numbers] n ON n.IDNumber = rn.IDNumber
  Group BY n.[IDNumber]
  ORDER BY SUM([NumberDay]) DESC;
*/


IF NOT EXISTS (SELECT * FROM Hotel.sys.procedures WHERE name = 'Proc_NumbersStatistic') 
BEGIN
	PRINT 'Задание 4 процедура НЕ создана'

GOTO label3
END
ELSE 
BEGIN 
	SET @Total = @Total + 1
	PRINT 'Задание 4.1 процедура создана'
/*
		SELECT c.[IDClient]
		, c.[Surname] + ' ' + c.[Name] + ' ' + c.[Patronymic] as ФИО
		, n.[Cost]*rn.[NumberDay] as Cost
		, p.[Payment]
		FROM [dbo].[Clients] c JOIN [dbo].[Accomodation] a ON c.IDClient = a.IDClient
		JOIN [PaymentCard] p ON p.[IDPaymentCard] = a.[IDPaymentCard]
		JOIN [dbo].[Reservation_Number] rn ON rn.[IDClient] = c.[IDClient] 
		JOIN [dbo].[Numbers] n ON n.[IDNumber] = rn.[IDNumber]
		WHERE a.[PayDate] IS NULL
*/

DECLARE @Temp1 TABLE (IDNumber INT, CountNumber INT, TotalCost money, TotalDays INT)
INSERT INTO @Temp1
EXEC Hotel_Model.[dbo].[Proc_NumbersStatistic] '2020-01-01', '2022-01-01'

DECLARE @Temp2 TABLE (IDNumber INT, CountNumber INT, TotalCost money, TotalDays INT)
INSERT INTO @Temp2
EXEC Hotel.[dbo].[Proc_NumbersStatistic] '2020-01-01', '2022-01-01'

	IF NOT EXISTS(
		SELECT * FROM @Temp1
		EXCEPT
		SELECT * FROM @Temp2)
	BEGIN 
	SET @Total = @Total + 2
	PRINT 'Задание 4.2 процедура создана верно'
	END
	ELSE
	PRINT 'Задание 4.2 процедура создана НЕ верно'
END
label3:
PRINT '@Total 4 = ' + CONVERT(VARCHAR(5),@Total)

/***  Задание №5  ***/

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #5 ***/'

/****** Script for Analytics command ******/
/*
DECLARE @date date = '2020-01-01'
SELECT [IDClient]
	  , COUNT([IDNumber]) as Numbers
      , COUNT([IDReserved]) as NumReserved
      , SUM([NumberDay]) as Days
      , SUM([NumberPeople]) as TotalPersons
  FROM [Hotel].[dbo].[Reservation_Number]
  WHERE [ArrivalDate] >= @date
  GROUP BY [IDClient]
  ORDER BY [IDClient]
*/

IF EXISTS (SELECT i.id 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name = N'ArrivalDate')
BEGIN 
	SELECT object_name(i.id) as TableName, i.name as IndexName, c.column_id, c.name as ColumnName, ic.is_included_column 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name IN ('IDClient', 'ArrivalDate')
		AND is_included_column = 0
	IF @@ROWCOUNT = 2 
	BEGIN
	--IF (SELECT COUNT(1)
	--	FROM Hotel.sys.sysindexes i
	--	JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
	--	JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
	--	WHERE ic.object_id = i.id
	--	AND ic.index_id = i.indid
	--	AND object_name(i.id) = N'Reservation_Number' 
	--	AND i.name = N'IX_Reservation_Number_Covering'
	--	AND c.name IN ('ArrivalDate')
	--	AND is_included_column = 0 AND index_column_id = 1) = 1
	--	BEGIN
		PRINT '5.1 ВЫПОЛНЕНО - Индекс создан и имеет обе базовые колонки'
				SET @Total = @Total + 1
		END
	ELSE
		BEGIN
		PRINT '5.1 ВЫПОЛНЕНО ЧАСТИЧНО - Индекс создан НЕ ВЕРНО'
				SET @Total = @Total + 0.5
		END
	END
ELSE
BEGIN
	PRINT '5.1 НЕ ВЫПОЛНЕНО - Индекс НЕ создан'
	PRINT '5.2 НЕ ВЫПОЛНЕНО - Индекс НЕ создан'
	GOTO label5
END
--PRINT '@Total 5.1 = ' + CONVERT(VARCHAR(5),@Total)


	SELECT object_name(i.id) as TableName, i.name as IndexName, c.column_id, c.name as ColumnName, ic.is_included_column 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name IN ('IDClient', 'ArrivalDate','IDNumber', 'IDReserved', 'NumberDay', 'NumberPeople')

	IF  (	SELECT COUNT(1) 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name IN ('IDNumber', 'IDReserved', 'NumberDay', 'NumberPeople')
		AND is_included_column = 1
) = 4
AND (	SELECT COUNT(1) 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name IN ('IDClient', 'ArrivalDate')
		AND is_included_column = 0
) = 2
	BEGIN
		PRINT '5.2 ВЫПОЛНЕНО - индекс ЯВЛЯЕТСЯ ПОКРЫВАЮЩИМ'
			SET @Total = @Total + 1
	END
	ELSE
		IF  (	SELECT COUNT(1) 
		FROM Hotel.sys.sysindexes i
		JOIN Hotel.sys.index_columns ic ON i.id = ic.object_id
		JOIN Hotel.sys.all_columns c on c.object_id = ic.object_id AND c.column_id = ic.column_id
		WHERE ic.object_id = i.id
		AND ic.index_id = i.indid
		AND object_name(i.id) = N'Reservation_Number' 
		AND i.name = N'IX_Reservation_Number_Covering'
		AND c.name IN ('IDClient', 'ArrivalDate','IDNumber', 'IDReserved', 'NumberDay', 'NumberPeople')
) = 6
	BEGIN
		PRINT '5.2 ВЫПОЛНЕНО - индекс имеет ВСЕ колонки'
			SET @Total = @Total + 1
	END
	ELSE
		PRINT '5.2 НЕ ВЫПОЛНЕНО - индекс имеет НЕ ВСЕ колонки'
label5:
PRINT '@Total 5 = ' + CONVERT(VARCHAR(5),@Total)


/***  Задание №6  ***/

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #6 ***/'

IF EXISTS (SELECT * FROM Hotel.sys.tables t JOIN Hotel.sys.columns c ON t.object_id = c.object_id
	WHERE t.name = N'Reservation_Archive' AND c.NAME IN (SELECT c1.name FROM Hotel.sys.tables t1 
				JOIN Hotel.sys.columns c1 ON t1.object_id = c1.object_id WHERE t1.name = N'Reservation'))
	BEGIN
		PRINT '6.1 ВЫПОЛНЕНО - таблица создана'
			SET @Total = @Total + 0.5
	END 
		ELSE PRINT '6.1 НЕ ВЫПОЛНЕНО'

IF EXISTS (SELECT * FROM Hotel.sys.tables t JOIN Hotel.sys.columns c ON t.object_id = c.object_id
	WHERE t.name = N'Reservation_Archive' AND c.NAME LIKE N'IDReserved%' AND is_identity = 0)
	AND (SELECT COUNT(1) FROM Hotel.sys.columns WHERE OBJECT_NAME(object_id) = N'Reservation_Archive') = (SELECT COUNT(1) FROM Hotel.sys.columns WHERE OBJECT_NAME(object_id) = N'Reservation')
	BEGIN
		PRINT '6.2 ВЫПОЛНЕНО - таблица создана cо всеми полями'
			SET @Total = @Total + 0.5
	END
		ELSE PRINT '6.2 НЕ ВЫПОЛНЕНО'

PRINT '@Total 6 = ' + CONVERT(VARCHAR(5),@Total)


/***  Задание №7  ***/
PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #7 ***/'

IF NOT EXISTS (SELECT * FROM Hotel.sys.tables t JOIN Hotel.sys.columns c ON t.object_id = c.object_id
	WHERE t.name = N'Reservation_Archive' )
	BEGIN
		PRINT '7 НЕ ВЫПОЛНЕНО - таблица НЕ создана'
	END 
	ELSE 
	IF (SELECT rows FROM Hotel.sys.sysindexes WHERE OBJECT_NAME(id) = N'Reservation_Archive') > 1
	BEGIN
		PRINT '7 ВЫПОЛНЕНО - ВСЕ записи скопированы в архив'
			SET @Total = @Total + 1
	END
	ELSE
		PRINT '7 НЕ ВЫПОЛНЕНО - таблица НЕ создана'

PRINT '@Total 7 = ' + CONVERT(VARCHAR(5),@Total)


/***  Задание №8  ***/
--USE [master]
--GO
-- CREATE LOGIN hoteluser WITH PASSWORD = 'Hoste1U5er-2022', DEFAULT_DATABASE = Hotel
-- ALTER LOGIN [hoteluser] WITH DEFAULT_DATABASE=[Hotel], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
--GO


PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #8 ***/'

IF EXISTS (SELECT * FROM sys.syslogins WHERE loginname = N'hoteluser' AND name = N'hoteluser'  AND dbname=N'Hotel')
	BEGIN
		PRINT '8 ВЫПОЛНЕНО - логин создан ВЕРНО'
			SET @Total = @Total + 1
	END 
	ELSE 
	IF EXISTS (SELECT * FROM sys.syslogins WHERE loginname = N'hoteluser' AND name = N'hoteluser' AND dbname<>N'Hotel')
	BEGIN
		SET @Total = @Total + 0.5
		PRINT '8 ВЫПОЛНЕНО ЧАСТИЧНО - логин создан БЕЗ БАЗЫ'
	END
	ELSE
		PRINT '8 НЕ ВЫПОЛНЕНО - логин НЕ создан'

PRINT '@Total 8 = ' + CONVERT(VARCHAR(5),@Total)

/***  Задание №9  ***/
--CREATE SCHEMA archive

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #9 ***/'

IF EXISTS (SELECT * FROM Hotel.sys.schemas WHERE name = N'archive')
	BEGIN
		PRINT '9 ВЫПОЛНЕНО - схема создана ВЕРНО'
			SET @Total = @Total + 1
	END 
	ELSE
		PRINT '9 НЕ ВЫПОЛНЕНО - схема НЕ создана'

PRINT '@Total 9 = ' + CONVERT(VARCHAR(5),@Total)

/***  Задание №10  ***/
--CREATE USER hoteluser FROM LOGIN hoteluser WITH DEFAULT_SCHEMA = archive
--EXEC sp_addrolemember 'db_datareader', hoteluser;
--GRANT SELECT ON SCHEMA::archive TO hoteluser;


PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #10 ***/'

IF EXISTS (SELECT * FROM Hotel.sys.sysusers WHERE name = N'hoteluser' and hasdbaccess = 1 AND islogin = 1)
	BEGIN
		PRINT '10.1 ВЫПОЛНЕНО - пользователь создан'
			SET @Total = @Total + 0.5
	IF EXISTS (select * FROM sys.database_principals WHERE name = N'hoteluser' and default_schema_name = N'archive')
		BEGIN
			PRINT '10.2 ВЫПОЛНЕНО - схема назначена пользователю правильно' 
				SET @Total = @Total + 0.5
		END 
	ELSE PRINT '10.2 НЕ ВЫПОЛНЕНО - новая схема НЕ назначена пользователю'
	IF EXISTS ( SELECT DP1.name AS DatabaseRoleName, 
					isnull (DP2.name, 'No members') AS DatabaseUserName 
					FROM sys.database_role_members AS DRM
					RIGHT OUTER JOIN sys.database_principals AS DP1
						ON DRM.role_principal_id = DP1.principal_id
					LEFT OUTER JOIN sys.database_principals AS DP2
						ON DRM.member_principal_id = DP2.principal_id
					WHERE DP1.is_fixed_role = 1 AND DP2.name=N'hoteluser' AND DP1.name = 'db_datareader')
		BEGIN
		IF NOT EXISTS ( SELECT DP1.name AS DatabaseRoleName, 
				isnull (DP2.name, 'No members') AS DatabaseUserName 
				FROM sys.database_role_members AS DRM
				RIGHT OUTER JOIN sys.database_principals AS DP1
					ON DRM.role_principal_id = DP1.principal_id
				LEFT OUTER JOIN sys.database_principals AS DP2
					ON DRM.member_principal_id = DP2.principal_id
				WHERE DP1.is_fixed_role = 1 AND DP2.name=N'hoteluser' 
					AND DP1.name IN ('db_owner', 'db_accessadmin', 'db_securityadmin', 'db_ddladmin', 'db_backupoperator', 'db_datawriter'))
			BEGIN
			PRINT '10.3 ВЫПОЛНЕНО ПРАВИЛЬНО - пользователь имеет ТОЛЬКО право db_datareader'
					SET @Total = @Total + 1
			END		
		ELSE
			BEGIN
			PRINT '10.3 ВЫПОЛНЕНО ЧАСТИЧНО - пользователь имеет другие права'
					SET @Total = @Total + 0.5
			END
		END
	ELSE
		PRINT '10.3 НЕ ВЫПОЛНЕНО - пользователь НЕ имеет право db_datareader'

--DENY DELETE ON SCHEMA::archive TO hoteluser;
	IF EXISTS (SELECT pr.principal_id, pr.name, pr.type_desc,   
		pr.authentication_type_desc, pe.state_desc, pe.permission_name  
	FROM sys.database_principals AS pr  
		JOIN sys.database_permissions AS pe  
		ON pe.grantee_principal_id = pr.principal_id
		WHERE pr.name = 'hoteluser' AND state_desc = 'DENY' AND permission_name = 'DELETE')
		BEGIN
			PRINT '10.4 ВЫПОЛНЕНО - пользователь ИМЕЕТ ЗАПРЕТ на права DELETE'
						SET @Total = @Total + 1
		END
	IF EXISTS (SELECT pr.principal_id, pr.name, pr.type_desc,   
		pr.authentication_type_desc, pe.state_desc, pe.permission_name  
	FROM sys.database_principals AS pr  
		JOIN sys.database_permissions AS pe  
		ON pe.grantee_principal_id = pr.principal_id
		WHERE pr.name = 'hoteluser' AND state_desc = 'REVOKE' AND permission_name = 'DELETE')
		BEGIN
			PRINT '10.4 ВЫПОЛНЕНО ЧАСТИЧНО - пользователь НЕ ИМЕЕТ ЗАПРЕТА на права DELETE'
						SET @Total = @Total + 0.5
		END
	END
	ELSE
		PRINT '10 НЕ ВЫПОЛНЕНО - пользователь НЕ создан'
PRINT '@Total 10 = ' + CONVERT(VARCHAR(5),@Total)


/***  Задание №11  ***/
--Проверка наличия файлов;
-- DECLARE @Total decimal(5,1) = 0;

PRINT ''
PRINT ''
PRINT '/*** ЗАДАНИЕ #11 ***/'

DECLARE @CheckFile INT = 0
SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\1Hotel_Alter.sql'))
IF @CheckFile=1 
BEGIN
	PRINT 'FILE 1Hotel_Alter.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 1Hotel_Alter.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\2Hotel_Update.sql'))
IF @CheckFile=1 
BEGIN
	PRINT 'FILE 2Hotel_Update.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 2Hotel_Update.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\3Hotel_View.sql'))
IF @CheckFile=1 
BEGIN
	PRINT 'FILE 3Hotel_View.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 3Hotel_View.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\4Hotel_Proc.sql'))
IF @CheckFile=1 
BEGIN
	PRINT 'FILE 4Hotel_Proc.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 4Hotel_Proc.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\5Hotel_Index.sql'))
IF @CheckFile = 1
BEGIN
	PRINT 'FILE 5Hotel_Index.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 5Hotel_Index.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\6Hotel_Archive.sql'))
IF @CheckFile = 1
BEGIN
	PRINT 'FILE 6Hotel_Archive.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 6Hotel_Archive.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\7Hotel_ArchiveInsert.sql'))
IF @CheckFile = 1
BEGIN
	PRINT 'FILE 7Hotel_ArchiveInsert.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 7Hotel_ArchiveInsert.sql NOT exists'

SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\8Hotel_Admin.sql'))
IF @CheckFile = 1
BEGIN
	PRINT 'FILE 8Hotel_Admin.sql exists'
	SET @Total = @Total + 0.5
END
ELSE
	PRINT 'FILE 8Hotel_Admin.sql NOT exists'


SET @CheckFile = (SELECT Hotel_Model.dbo.fn_FileExists('c:\Temp\11Hotel_InitialDB.sql'))
IF @CheckFile = 1
BEGIN
	PRINT 'FILE 11Hotel_InitialDB.sql exists'
	SET @Total = @Total + 1
END
ELSE
	PRINT 'FILE 11Hotel_InitialDB.sql NOT exists'
	
PRINT 'ИТОГОВЫЙ БАЛЛ = ' + CONVERT(VARCHAR(5),@Total)

  EXEC xp_cmdshell 'findstr CASE C:\temp\2Hotel_Update.sql'
  IF @@ROWCOUNT > 1 SET @Total = @Total + 1 

  EXEC xp_cmdshell 'findstr INSERT C:\temp\11Hotel_InitialDB.sql'
  IF @@ROWCOUNT > 1 SET @Total = @Total + 1 



PRINT 'ИТОГОВЫЙ БАЛЛ = ' + CONVERT(VARCHAR(5),@Total)
GO

xp_cmdshell 'dir C:\Temp\*.*'
GO
xp_cmdshell 'dir D:\Temp\*.*'
GO
/************************ КОНЕЦ ПРОВЕРКИ  *************************/

