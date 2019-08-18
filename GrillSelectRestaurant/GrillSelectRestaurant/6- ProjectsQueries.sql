/*Create Restaurant database
Sccript Date :September 13,2018
Developed by :Maryam Naji, Zohreh karimzadeh/ Mahtab Abbasigaravand/ Ehsan Bavandsavadkoohi
*/


use GrillSelectResturant2018
;
go


/* 1- create contact list of customers (full name , phone number , address) */
select CustomerID,CompanyName, concat(firstName,' ',LastName) as 'Full Name', phone, 
concat(address,' ',city,' ',region,' ',postalcode,' ',country) as 'Full Address'
from Sales.customers
;
go

/* 2- Create Menu including : MenuItemID, ItemName,ItemType Description and item price */
select M.MenuItemID, M.ItemName,MIT.ItemTypeDescription,  M.ItemDescription, M.ItemPrice
 from Sales.Menu as M
 inner join Sales.MenuItemTypes as MIT
 on M.ItemTypeID = MIT.ItemTypeID
 order by MIT.ItemTypeDescription
 ;
 go

 /* 3- Create a list of Orders placed today. */
select C.CustomerID,concat(C.firstName,' ',C.LastName) as 'Full Name', O.OrderID, O.OrderDate 
from Sales.customers as C
left join Sales.Orders as O
on C.CustomerID = O.CustomerID
where datediff(day,O.OrderDate,getdate()) is null
-- where O.OrderDate = getdate()
order by CustomerID
;
go -- 

/* 4- Create a list of employees including the job type and  job category */
create view HumanResources.EmployeeJobTitleView as
select  TOP 100 concat(E.FirstName,' ',E.LastName) as 'Full Name', JP.JobDescription , JT.JobTypeDescription
from HumanResources.Employees as E
inner join HumanResources.JobTypes as JT
on E.JobTypeID = JT.JobTypeID
inner join HumanResources.JobPositions as JP
on E.JobPositionID = JP.JobPositionID
order by JP.JobDescription
;
go 

/* 5- Create a list of top 100 deliverys done by each driver  . */
create view Sales.OrderDelivery as
select  TOP 100 concat(DR.FirstName,' ',DR.LastName) as 'Driver Name',O.OrderID,o.OrderDate,
concat(address,' ',D.DeliveryAddress,' ',D.DeliveryPostalCode,' ',D.DeliveryCity) as 'Delivery Address'
from Sales.Orders as O
inner join Sales.OrderDetails as OD
on O.OrderID = OD.OrderID
inner join Sales.Delivery as D
on OD.OrderID = D.OrderID
inner join HumanResources.Drivers as DR
on D.DriverID = DR.DriverID
order by 'Driver Name' DESC
;
go



/* 6- Create a list of goods, the supplier name and companyName who provided it,quantity and the date. */
create view Sales.GoodsInformation as
select G.GoodID, G.GoodName, concat(S.FirstName,' ',S.LastName) as 'Supplier Name', S.CompanyName, GS.Quantity, GS.PerchaseDate
from production.Goods as G
inner join production.GoodsSupply as GS
on G.GoodID = GS.GoodID
inner join production.Suppliers as S
on GS.SupplierID = S.SupplierID
;
go 



/* 7- Create a list that returns the goods by quantity less than ten. */
create view Sales.GoodsQuantityTwenty as
select *
from Sales.GoodsInformation as SGI
where SGI.quantity < 10
;
go


/* 8- Create a list that returns the goods by supplier name = costco. */
create view Sales.GoodsSuppliedByCoctco as
select *
from Sales.GoodsInformation as SGI
where SGI.CompanyName = 'Costco'
;
go


/* 9- How many salads ar ordered in 2018. */
create view Sales.TodayOrderDetails as
select  count (MT.ItemTypeDescription) as 'Number of Salads'
from Sales.Menu as M
inner join Sales.MenuItemTypes as MT
on M.ItemTypeID = MT.ItemTypeID
inner join Sales.OrderDetails as OD
on OD.MenuItemID = M.MenuItemID
inner join Sales.Orders as O
on O.OrderID = OD.OrderID
where MT.ItemTypeDescription='Salads' and (Year(O.OrderDate) = '2018')
;
go


/* 10- Create a list of customers that live in specific area 'H9H' to be included in Free delivery */
create view Sales.TodayOrderDetails as
select *
from Sales.Customers as C
where substring(C.PostalCode,1,3) = 'H9H'
;
go

/*********************************************************Questions******************************************************************/



/*1. How many orders did the resturant do this year?*/

select count(O.OrderID) as 'Number of ordres of 2108'
from Sales.Orders as O
where year(O.OrderDate) = '2018'
;
go



/*1. How many orders did each customers have this year?*/
 select C.CustomerID,C.CompanyName, concat(C.firstName,' ',C.LastName) as 'Full Name',count(O.OrderID) as 'Number of orders of customer'
 from Sales.Orders as O
 inner join Sales.customers as C
 on C.CustomerID = O.CustomerID
 group by C.CustomerID,C.CompanyName, concat(C.firstName,' ',C.LastName)
 ;
 go





/*2. What percentage of the customers, order at least one menu item ?*/

if OBJECT_ID('sales.customerOrdePercentageFn','Fn') is not null
	drop function sales.customerOrdePercentageFn
;
go
create  function sales.customerOrdePercentageFn()
returns varchar
as
	begin
		declare @result varchar(5)

		declare @TotalCustomers int;
		declare @CustomerHavingOrder int;
 
		select  @TotalCustomers=count(CustomerID) from Sales.Customers
		select  @CustomerHavingOrder=count(*) from
			(
			 select  CustomerID from Sales.Orders group by CustomerID
			 ) as x

		set @result=((@CustomerHavingOrder *100)/@TotalCustomers)

 return @result
end

select concat('%',sales.customerOrdePercentageFn()) as customerOrdePercentage 


-- View

/*3. What was the greatest number of orders placed by any customer?*/

create view sales.PlacedOrders
as 
select  CustomerID,count(O.OrderID) as NumberOfPlacedOrders
from Sales.Orders as O
group by CustomerID 
;
go


select PO.CustomerID, NumberOfPlacedOrders as 'MaxOfNumberOfPlacedOrders' from Sales.PlacedOrders as PO 
where PO.NumberOfPlacedOrders = ( select max(PO.NumberOfPlacedOrders) from Sales.PlacedOrders as PO )
;
go


/* Or
select max(PlacedOrders) from
(
select  CustomerID,count(O.OrderID) as PlacedOrders
from Sales.Orders as O
group by CustomerID 
) as q
*/

-- Fuctions
/*4. What percentage of the menu items was delivered at least once this year?*/

if OBJECT_ID('sales.MenuDeliveredPercentageFn','Fn') is not null
	drop function sales.MenuDeliveredPercentageFn
;
go
create function sales.MenuDeliveredPercentageFn()
returns varchar
as
	begin
		 declare @result varchar(5)

		 declare @MenuItemsCount int;
		 declare @MenuDeliveredCount int;
 
		 select  @MenuItemsCount=count(MenuItemID) from [Sales].[Menu]
		 select  @MenuDeliveredCount=count(*) from
			(
			select OD.MenuItemID,count(OD.MenuItemID) as 'NumberOfDelivered'
			from Sales.OrderDetails as OD
			join Sales.Delivery as D
			on OD.OrderID=D.OrderID
			group by OD.MenuItemID
			 ) as x

		set @result=((@MenuDeliveredCount *100)/@MenuItemsCount)

 return @result
end

select concat('%',sales.MenuDeliveredPercentageFn()) as MenuDeliveredPercentage


/*5. What percentage of all orders were ordered by vegeterian customers? */

if OBJECT_ID('sales.VeggiCustomersPercentageFn','Fn') is not null
	drop function sales.VeggiCustomersPercentageFn
;
go
create function sales.VeggiCustomersPercentageFn()
returns varchar
as
	begin
		 declare @result varchar(5)
 
		 declare @TotalCustomerCount int;
		 declare @VeggiCustomersOrderCount int;
 
		 select  @TotalCustomerCount=count(CustomerID) from Sales.Customers
		 select  @VeggiCustomersOrderCount =count(IsVeggi)
					from Sales.Customers as C
					inner join Sales.Orders as O on O.CustomerID=C.CustomerID
					where C.IsVeggi='1'
					group by IsVeggi
	
		set @result=((@VeggiCustomersOrderCount  *100)/@TotalCustomerCount)

 return @result
end

select concat('%',sales.VeggiCustomersPercentageFn()) as VeggiCustomersPercentage


/*6. What is the average ages of employees */


if OBJECT_ID('Sales.EmployeesAgeAverageFn','Fn') is not null
	drop function Sales.EmployeesAgeAverageFn
;
go
create function Sales.EmployeesAgeAverageFn()
returns int
as
	begin
		declare @result int

		select @result=AVG(Age)  from
		(
		select FirstName,LastName, DATEDIFF(YEAR,BirthDate,GETDATE())  as Age from [HumanResources].[Employees]
		) as x

		return @result
	end

select Sales.EmployeesAgeAverageFn() as EmployeesAgeAverage


-- Triggers
-- create a Trigger to notify Employee while adding a new item to Menu
create trigger Sales.NotifyEmployeOnChangingMenuTr
on Sales.Menu
after insert, Update
as
	raiserror('Notify Customer on changing data'
				,10 --severity
				,1 --state
				)
;
go

-- insert data to test Sales.NotifyEmployeOnChangingMenuTr
insert into Sales.Menu(ItemTypeID,ItemName,ItemDescription,ItemPrice)
values
(3,'Special Kebab','A delicious kebab made by Lamp meat',14.25)
;
go

-- create a Trigger to set the order date as today if it is null or not entered
create trigger checkOrderDateTr
on Sales.Orders
for insert
as
	begin
		-- declare variable
		declare @OrderDate as datetime,
				@OrderID as Int
		select @OrderDate = OrderDate,
			   @OrderID = OrderID
		from inserted
		-- making decision
		if (abs(datediff(day,@OrderDate,GETDATE()))> 0) or (@OrderDate is null)
			begin
				-- set th emodified date to the current date
				update Sales.Orders
					set OrderDate = GETDATE()
					where OrderID = @OrderID 
			End
	End
;
go

-- Clustered and Not clustered Indexes

-- GoodNames should be unique and clustered
create unique nonclustered index ncl_goodname on Production.Goods (GoodName)
;
go

-- CompanyName should be clustered
create clustered index cl_CompanyName on Production.Suppliers (CompanyName)
;
go

-- Sub Query
/* return the list of orders places by customer = Apple Lane */
select O.CustomerID, O.OrderID
from Sales.Orders as O
where O.CustomerID in (
					select C.CustomerID
					from Sales.Customers as C
					where C.CompanyName = 'Apple Lane'
					)
;
go


/* create infoDriverSP procedure that return the information of Drivers */
create procedure HumanResources.infoDriverSP
as
	begin
		select  D.FirstName ,
				D.LastName ,
				D.Address ,
				D.City ,
				D.Phone ,
				DE.milage
		from HumanResources.Drivers as D
			inner join Sales.Delivery as DE
				on D.DriverID = DE.DriverID
	end
;
go

exec HumanResources.infoDriverSP
;
go

/*create Production.getSuppliersByName procedure that return the Supplier firstname ,
 lastName , CompanyName , City , Region , PostalCode , Phone, Extension by selecting the SupplierID
*/

create procedure production.getSuppliersByName
(
	@SupplierID as int 
)
as
	begin
		select  S.FirstName ,
				S.LastName ,
				S.CompanyName ,
				S.City ,
				S.Region ,
				S.PostalCode ,
				S.Phone ,
				S.Extension
		from production.Suppliers as S
		where S.SupplierID = @SupplierID
	end
;
go

execute production.getSuppliersByName @SupplierID =1
;
go



/*create Sales.getCustomerSP procedure that return the full Customer name ,
   phone , Address , Region ,  by selecting the job title and the city
*/

create procedure Sales.getCustomerSP
(
	@FirstName as nvarchar(20),
	@LastName  as nvarchar(20)
)
as
	begin
		select concat(C.FirstName ,' ', C.LastName) as 'Cstomer Name' ,
			   C.Address as 'Customer Address',
			   C.Region as 'Customer Region',
			   C.Phone as 'Customer Phone'
		from Sales.Customers as C
		where (C.FirstName = @FirstName) and (C.LastName = @LastName)

	end
;
go

execute Sales.getCustomerSP @FirstName = 'Anderson', @LastName = 'Angel'
;
go

/* WHat is the number of customers with more than one order */
Select E.CustomerID, Count(E.CustomerID) as Sales
from Sales.Orders as E
group by E.CustomerID
having Count(E.CustomerID) > 1
;
go