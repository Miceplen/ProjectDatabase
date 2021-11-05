create database CateringDelVia

use CateringDelvia

--b
create table Position(
	PositionID char(5) check(PositionID like 'SP[0-9][0-9][0-9]') primary key,
	PositionName varchar(255) not null
)

create table Vendor(
	VendorID char(5) check(VendorID like 'VE[0-9][0-9][0-9]') primary key,
	VendorName varchar(255) check(VendorName like 'PT. %') not null,
	PhoneNumber varchar(12) not null,
	[Address] varchar(255) not null
)

create table Staff(
	StaffID char(5) check(StaffID like 'ST[0-9][0-9][0-9]') primary key,
	StaffName varchar(255) not null,
	Gender varchar(10) not null,
	Email varchar(255) not null,
	PhoneNumber varchar(12) not null,
	[Address] varchar(255) not null,
	Salary int not null,
	PositionID char(5),
	Foreign key (PositionID) references Position(PositionID)
)

alter table Staff
add constraint checkStaffNumber check(PhoneNumber like '08%')

alter table Staff
add constraint checkStaffEmail check(Email not like '@%')

alter table Staff
add constraint checkStaffEmailLast check(Email like '%@gmail.com' or Email like '%@yahoo.com' or Email like '%@yahoo.co.id') 

alter table Staff
add constraint checkSalary check(Salary between 500000 and 5000000)

create table Customer(
	CustomerID char(5) check(CustomerID like 'CU[0-9][0-9][0-9]') primary key,
	CustomerName varchar(255) not null,
	PhoneNumber varchar(12) not null,
	[Address] varchar(255) not null,
	Gender varchar(10) not null, 
	Email varchar(255) not null
)

alter table Customer
add constraint checkCustPhone check(PhoneNumber like '08%')

alter table Customer
add constraint checkCustEmail check(Email not like '@%')

alter table Customer
add constraint checkCustEmailLast check(Email like '%@gmail.com' or Email like '%@yahoo.com' or Email like '%@yahoo.co.id')

create table Menu(
	MenuID char(5) check(MenuID like 'ME[0-9][0-9][0-9]') primary key,
	MenuName varchar(255) check(len(MenuName) > 5) not null,
	[Description] varchar(255) not null,
	Price int not null
)

create table Ingredient(
	IngredientID char(5) check(IngredientID like 'ID[0-9][0-9][0-9]') primary key,
	IngredientName varchar(255) not null,
	Stock int not null,
	Price int not null
)

create table Purchase(
	PurchaseID char(5) check(PurchaseID like 'PU[0-9][0-9][0-9]') primary key,
	PurchaseDate date not null,
	StaffID char(5),
	VendorID char(5),
	Foreign key (StaffID) references Staff(StaffID),
	Foreign key (VendorID) references Vendor(VendorID)
)

create table ServiceTransaction(
	ServiceTransactionID char(5) check(ServiceTransactionID like 'TR[0-9][0-9][0-9]') primary key,
	[Date] date not null,
	ReservationType varchar(255) not null,
	[Address] varchar(255) not null,
	CustomerID char(5),
	StaffID char(5),
	Foreign key (CustomerID) references Customer(CustomerID),
	Foreign key (StaffID) references Staff(StaffID)
)

create table ServiceTransactionDetail(
	ServiceTransactionID char(5),
	MenuID char(5),
	MenuPax int not null,
	Foreign key (ServiceTransactionID) references ServiceTransaction(ServiceTransactionID),
	Foreign key (MenuID) references Menu(MenuID),
	Primary key(ServiceTransactionID, MenuID)
)

create table PurchaseDetail(
	PurchaseID char(5),
	IngredientID char(5),
	Quantity int not null,
	Foreign key (PurchaseID) references Purchase(PurchaseID),
	Foreign key (IngredientID) references Ingredient(IngredientID),
	Primary key(PurchaseID, IngredientID)
)