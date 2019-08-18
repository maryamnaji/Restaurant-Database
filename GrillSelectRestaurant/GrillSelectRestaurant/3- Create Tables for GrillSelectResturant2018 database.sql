/*Create Restaurant database
Sccript Date :September 10,2019
Developed by :Maryam Naji, Zohreh karimzadeh/ Mahtab Abbasigaravand/ Ehsan Bavandsavadkoohi
*/

use GrillSelectResturant2018
;
go


--create table HumanResources.Employees
if OBJECT_ID('HumanResources.Employees','U') is not null
drop table HumanResources.Employees
;
go
create table HumanResources.Employees
(
	EmployeeID int identity(1,1)not null ,
	LastName nvarchar(20) not null ,
	FirstName nvarchar(20) not null ,
	Title nvarchar(30) null ,
	BirthDate datetime null,
	HireDate datetime null,
	JobPositionID int not null, --fk
	JobTypeID int not null, --fk
	Salary money null,
	HourlyRate money null,
	Address nvarchar(60) null,
	City nvarchar(15) null ,
	Region nvarchar(15) null,
	PostalCode nvarchar(10) null ,
	Country nvarchar(15) null ,
	CellPhone nvarchar(24) null ,
	OfficePhone nvarchar(24) null ,
	Extension nvarchar(4) null,
	HomePhone nvarchar(24) null ,
	Note nvarchar(250) null,
	constraint pk_Employees primary key (EmployeeID asc)
)
;
go

--create table HumanResources.JobType
if OBJECT_ID('HumanResources.JobType','U') is not null
drop table HumanResources.JobTypes
;
go
create table HumanResources.JobTypes
(
	JobTypeID int identity(1,1) not null ,
	JobTypeDescription nvarchar(50) not null ,
	constraint pk_JobType primary key (JobTypeID asc)
)
;
go


--create table HumanResources.JobPosition
if OBJECT_ID('HumanResources.JobPosition','U') is not null
drop table HumanResources.JobPositions
;
go
create table HumanResources.JobPositions
(
	JobPositionID int identity(1,1) not null ,
	JobDescription nvarchar(50) not null ,
	constraint pk_JobPosition primary key (JobPositionID asc)
)
;
go




--create table HumanResources.Drivers
if OBJECT_ID('HumanResources.Drivers','U') is not null
drop table HumanResources.Drivers
;
go

create table HumanResources.Drivers

(
	DriverID int identity(1,1) not null ,
	LastName nvarchar(20) not null ,
	FirstName nvarchar(10) not null ,
	BirthDate datetime null,
	HireDate datetime null,
	Salary money null,
	Address nvarchar(60) null,
	City nvarchar(15) null ,
	Region nvarchar(15) null,
	PostalCode nvarchar(10) null ,
	Country nvarchar(15) null ,
	Phone nvarchar(24) null ,
	Note nvarchar(250) null,
	rate money null,
	ReportTo int null, -- One employee may report to another employee (self-join)
	constraint pk_Drivers primary key (DriverID asc)
)
;
go



--create table Production.Goods
if OBJECT_ID('Production.Goods','U') is not null
drop table Production.Goods
;
go

create table Production.Goods
(
	GoodID int identity(1,1) not null ,
	GoodName nvarchar(50) not null ,
	GoodDescription nvarchar(150) not null ,
	constraint pk_Goods primary key (GoodID asc)
)
;
go



--create table Production.GoodsSupply
if OBJECT_ID('Production.GoodsSupply','U') is not null
drop table Production.GoodsSupply
;
go

create table Production.GoodsSupply
(
	GoodID int not null ,--fk,pk
	SupplierID int  not null ,--fk,pk
	PerchaseDate  datetime not null,
	Quantity int not null,--decimal
	Unit  nvarchar(10) not null,
	UnitPrice  money not null
	constraint pk_Goods_Suppliers primary key clustered (GoodID asc,SupplierID asc) 
)
;
go


--create table Production.Suppliers
if OBJECT_ID('Production.Suppliers','U') is not null
drop table Production.Suppliers
;
go

create table Production.Suppliers
(
	SupplierID int identity(1,1) not null ,
	CompanyName nvarchar(40) null,
	LastName nvarchar(20) not null ,
	FirstName nvarchar(10) not null ,
	Address nvarchar(60) null,
	City nvarchar(15) null ,
	Region nvarchar(15) null,
	PostalCode nvarchar(10) null ,
	Country nvarchar(15) null ,
	Phone nvarchar(24) null ,
	Extension nvarchar(4) null,
	Note nvarchar(250) null,
	constraint pk_Suppliers primary key (SupplierID asc)
)
;
go


--create table Sales.MenuItemTypes
if OBJECT_ID('Sales.MenuItemTypes','U') is not null
drop table Sales.MenuItemTypes
;
go
create table Sales.MenuItemTypes
(
	ItemTypeID int identity(1,1) not null,
    ItemTypeDescription  nvarchar(50) not null ,
	constraint pk_MenuItemTypes primary key clustered (ItemTypeID asc)
)
;
go


--create table Sales.Menu
if OBJECT_ID('Sales.Menu','U') is not null
drop table Sales.Menu
;
go

create table Sales.Menu
(
	MenuItemID int identity(1,1) not null,
	ItemTypeID int not null ,--fk
	ItemName nvarchar(50) not null ,
    ItemDescription  nvarchar(150)  null ,
	ItemPrice money  not null
	constraint pk_Menu primary key clustered (MenuItemID asc)
)
;
go

--create table Sales.Customers
if OBJECT_ID('Sales.Customers','U') is not null
drop table Sales.Customers
;
go

create table Sales.Customers
(
    CustomerID int identity(1,1) not null ,
    CompanyName nvarchar(40) null,
	LastName nvarchar(20) not null ,
	FirstName nvarchar(20) not null ,
	IsVeggi bit null,
	Address nvarchar(60) null,
	City nvarchar(15) null ,
	Region nvarchar(15) null,
	PostalCode nvarchar(10) null ,
	Country nvarchar(15) null ,
	Phone nvarchar(24) null ,
	Photo nvarchar(200) null,
	Note nvarchar(250) null,
	constraint pk_Customer primary key (CustomerID asc)
)
;
go

--create table Sales.OrderTypes
if OBJECT_ID('Sales.OrderTypes','U') is not null
drop table Sales.OrderTypes
;
go

create table Sales.OrderTypes
(
	OrderTypeID int identity(1,1) not null,
	OrderDesription nvarchar(10) not null,
	constraint pk_OrderTypes primary key clustered (OrderTypeID asc)
)
;
go


--create table Sales.Orders
if OBJECT_ID('Sales.Orders','U') is not null
	drop table Sales.Orders
;
go

create table Sales.Orders
(
	OrderID int identity(1,1) not null,
	OrderTypeID int not null,--fk
	CustomerID int not null,--fk
	EmployeeID int not null,--fk
	OrderDate datetime not null,
	ExpectedDelivery datetime null,
	constraint pk_Orders primary key clustered (OrderID asc)
)
;
go



--create table Sales.OrderDetails
if OBJECT_ID('Sales.OrderDetails','U') is not null
	drop table Sales.OrderDetails
;
go

create table Sales.OrderDetails
(
	OrderID int not null,--fk,pk
	MenuItemID  int not null,--fk,pk
	Quantity int not null,
	note nvarchar(250)
	constraint pk_OrderID_MenuItemID primary key clustered (OrderID asc,MenuItemID asc   )
)
;
go


--create table Sales.Delivery
if OBJECT_ID('Sales.Delivery','U') is not null
drop table Sales.Delivery
;
go

create table Sales.Delivery
(
	OrderID int not null,--fk,pk
	DriverID  int not null,--fk,pk
	DeliveryAddress nvarchar(60) not null, 
	DeliveryPostalCode nvarchar(10) null,
	DeliveryPhone nvarchar(24) null,
	DeliveryCity nvarchar(15) null,
	milage real null,
	constraint pk_OrderID_DriverID primary key clustered (OrderID asc,DriverID asc )
)
;
go 


--create table Production.MenuItemRecepie
if OBJECT_ID('Production.MenuItemRecepie','U') is not null
drop table Production.MenuItemRecepie
;
go

create table Production.MenuItemRecepie
(
	MenuItemID int not null,--fk,pk
	GoodID  int not null,--fk,pk
	Quantity int not null,
	constraint pk_OrderID_DriverID primary key clustered (MenuItemID asc,GoodID asc )
)
;
go
