CREATE DATABASE HotelDatabase

USE HotelDatabase

CREATE TABLE Ms_Customer(
	CustomerID CHAR(5) CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]') PRIMARY KEY,
	CustomerName VARCHAR(30) NOT NULL,
	CustomerPhoneNumber CHAR(12) CHECK(CustomerPhoneNumber LIKE '08%') NOT NULL,
	CustomerEmail VARCHAR(50) CHECK(CustomerEmail LIKE '%@gmail.com' OR CustomerEmail LIKE '%@yahoo.com' OR CustomerEmail LIKE '%@yahoo.co.id' ) NOT NULL,
)

CREATE TABLE Ms_Room(
	RoomID CHAR(5) CHECK(RoomID LIKE 'RM[0-9][0-9][0-9]') PRIMARY KEY,
	RoomType VARCHAR(50) NOT NULL,
	RoomPrice INTEGER NOT NULL
)

CREATE TABLE Ms_StaffPosition(
	StaffPositionID CHAR(5) CHECK(StaffPositionID LIKE 'PS[0-9][0-9][0-9]') PRIMARY KEY,
	PositionName VARCHAR(30) NOT NULL
)

CREATE TABLE Ms_Staff(
	StaffID CHAR(5) CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]') PRIMARY KEY,
	StaffName VARCHAR(30) NOT NULL,
	StaffPositionID CHAR(5) FOREIGN KEY REFERENCES Ms_StaffPosition(StaffPositionID),
	StaffSalary INTEGER NOT NULL,
)

CREATE TABLE Ms_PaymentType(
	PaymentTypeID CHAR(5) CHECK(PaymentTypeID LIKE 'PT[0-9][0-9][0-9]') PRIMARY KEY,
	[Description] VARCHAR(50) NOT NULL
)

CREATE TABLE HeaderBooking(
	BookingID CHAR(5) CHECK(BookingID LIKE 'BK[0-9][0-9][0-9]') PRIMARY KEY,
	[Date] DATE NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES Ms_Staff(StaffID)
)

CREATE TABLE DetailBooking(
	CustomerID CHAR(5),
	RoomID CHAR(5),
	BookingID CHAR(5) FOREIGN KEY REFERENCES HeaderBooking(BookingID),
	DurationOfStay INTEGER NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Ms_Customer(CustomerID),
	FOREIGN KEY (RoomID) REFERENCES Ms_Room(RoomID),
	PRIMARY KEY(CustomerID, RoomID)
)

CREATE TABLE HeaderCheckIn(
	CheckInID CHAR(5) CHECK(CheckInID LIKE 'CI[0-9][0-9][0-9]') PRIMARY KEY,
	StaffID CHAR(5) FOREIGN KEY REFERENCES Ms_Staff(StaffID),
	[Date] DATE NOT NULL
)

CREATE TABLE DetailCheckIn(
	CustomerID CHAR(5),
	RoomID CHAR(5),
	CheckInID CHAR(5) FOREIGN KEY REFERENCES HeaderCheckIn(CheckInID),
	DurationOfStay INTEGER NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Ms_Customer(CustomerID),
	FOREIGN KEY (RoomID) REFERENCES Ms_Room(RoomID),
	PRIMARY KEY(CustomerID, RoomID)
)

CREATE TABLE HeaderCheckOut(
	CheckOutID CHAR(5) CHECK(CheckOutID LIKE 'CO[0-9][0-9][0-9]') PRIMARY KEY,
	StaffID CHAR(5) FOREIGN KEY REFERENCES Ms_Staff(StaffID),
	[Date] DATE NOT NULL
)

CREATE TABLE DetailCheckOut(
	CustomerID CHAR(5),
	RoomID CHAR(5),
	CheckOutID CHAR(5) FOREIGN KEY REFERENCES HeaderCheckOut(CheckOutID),
	DurationOfStay INTEGER NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Ms_Customer(CustomerID),
	FOREIGN KEY (RoomID) REFERENCES Ms_Room(RoomID),
	PRIMARY KEY(CustomerID, RoomID)
)

CREATE TABLE HeaderPayment(
	PaymentID CHAR(5) CHECK(PaymentID LIKE 'PY[0-9][0-9][0-9]') PRIMARY KEY,
	StaffID CHAR(5) FOREIGN KEY REFERENCES Ms_Staff(StaffID),
	[Date] DATE NOT NULL
)

CREATE TABLE DetailPayment(
	CustomerID CHAR(5),
	RoomID CHAR(5),
	PaymentID CHAR(5) FOREIGN KEY REFERENCES HeaderPayment(PaymentID),
	PaymentTypeID CHAR(5) FOREIGN KEY REFERENCES Ms_PaymentType(PaymentTypeID),
	DurationOfStay INTEGER NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Ms_Customer(CustomerID),
	FOREIGN KEY (RoomID) REFERENCES Ms_Room(RoomID),
	PRIMARY KEY(CustomerID, RoomID)
)
