/*Create Restaurant database
Sccript Date :September 10,2019
Developed by :Maryam Naji, Zohreh karimzadeh/ Mahtab Abbasigaravand/ Ehsan Bavandsavadkoohi
*/

use GrillSelectResturant2018
;
go

/****************************************Foreign key constraints************************************************/


/* 1) Between HumanResources.Employees and HumanResources.JobPosition */
	alter table HumanResources.Employees
	add constraint fk_HumanResources_Employees_HumanResources_JobPositions foreign key (JobPositionID) references HumanResources.JobPositions (JobPositionID)
	;
	go
	
/* 2) Between HumanResources.Employees and HumanResources.JobType */
	alter table HumanResources.Employees
	add constraint fk_HumanResources_Employees_HumanResources_JobTypes foreign key (JobTypeID) references HumanResources.JobTypes (JobTypeID)
	;
	go

/* 3) Between Sales.Orders and HumanResources.Employees*/
	alter table Sales.Orders
	add constraint fk_Sales_Orders_HumanResources_Employees foreign key (EmployeeID) references HumanResources.Employees (EmployeeID)
	;
	go

/* 4) Between Sales.Orders and Sales.Customers */
	alter table Sales.Orders
	add constraint fk_Sales_Orders_Sales_Customers foreign key (CustomerID) references Sales.Customers (CustomerID)
	;
	go

/* 5) Between Sales.Orders and Sales.OrderTypes */
	alter table Sales.Orders
	add constraint fk_Sales_Orders_Sales_OrderTypes foreign key (OrderTypeID) references Sales.OrderTypes (OrderTypeID)
	;
	go

/* 6) Between Sales.OrderDetails and Sales.Orders */
	alter table Sales.OrderDetails
	add constraint fk_Sales_OrderDetails_Sales_Orders foreign key (OrderID) references Sales.Orders(OrderID)
	;
	go
	
/* 7) Between Sales.OrderDetails and Sales.Menu */
	alter table Sales.OrderDetails
	add constraint fk_Sales_OrderDetails_Sales_Menu foreign key (MenuItemID) references Sales.Menu(MenuItemID)
	;
	go


/* 8) Between Sales.Delivery and Sales.Orders */
	alter table Sales.Delivery
	add constraint fk_Sales_Delivery_Sales_Orders foreign key (OrderID) references Sales.Orders(OrderID)
	;
	go

/* 9) Between Sales.Delivery and HumanResources.Drivers */
	alter table Sales.Delivery
	add constraint fk_Sales_Delivery_HumanResources_Drivers foreign key (DriverID) references HumanResources.Drivers(DriverID)
	;
	go


/* 10) Between Sales.Menu and Sales.MenuItemTypes */
	alter table Sales.Menu
	add constraint fk_Sales_Menu_Sales_MenuItemTypes foreign key (ItemTypeID) references Sales.MenuItemTypes(ItemTypeID)
	;
	go



/* 11) Between Production.GoodsSupply and Production.Suppliers */
	alter table Production.GoodsSupply
	add constraint fk_Production_GoodsSupply_Production_Suppliers foreign key (SupplierID) references Production.Suppliers(SupplierID)
	;
	go

/* 12) Between Production.GoodsSupply and Production.Goods */
	alter table Production.GoodsSupply
	add constraint fk_Production_GoodsSupply_Production_Goods foreign key (GoodID) references Production.Goods(GoodID)
	;
	go
	
/* 13) Between Production.MenuItemRecepie and Sales.Menu */
	alter table Production.MenuItemRecepie
	add constraint fk_Production_MenuItemRecepie_Sales_Menu foreign key (MenuItemID) references Sales.Menu(MenuItemID)
	;
	go
	


/* 14) Between Production.MenuItemRecepie and Production.Goods */
	alter table Production.MenuItemRecepie
	add constraint fk_Production_MenuItemRecepie_Production_Goods foreign key (GoodID) references Production.Goods(GoodID)
	;
	go

/**************************************** Default constraints ************************************************/ 


/*1) set the default constraint value to 1 for Quantity column*/
alter table Sales.OrderDetails
	add constraint df_Quantity_Sales_OrderDetails default (1) for Quantity
;
go

/*2) set the default constraint value to current date for Purchase Date column in GoodsSupply  table */
alter table Production.GoodsSupply 
	add constraint df_PurchaseDate_Production_GoodsSupply default getdate() for PerchaseDate
;
go

/*3) set the default constraint value to current date for Order Date column in Orders table */
alter table Sales.Orders
	add constraint df_OrderDate_Sales_Orders default getdate() for OrderDate
;
go

/*4) set the default constraint value to 'Montreal'  for Delivery City column in Delivery table */
alter table Sales.Delivery
	add constraint df_DeliveryCity_Sales_Delivery default getdate() for DeliveryCity
;
go




/**************************************** Check Constraints ************************************************/ 


/*1) check that UnitPrice >= 0 in Products table*/
alter table Production.GoodsSupply 
	add constraint ck_Production_GoodsSupply_UnitPrice check (UnitPrice>=0)
;
go


/*2) check that driver's age >= 18 Employees in table*/
alter table HumanResources.Employees 
	add constraint ck_HumanResources_Employees_BirthDate check (BirthDate<=DateAdd(yy, -18, GetDate()))
;
go


/*3) check that Quantity >= 0 in  OrderDetails table*/
alter table  Sales.Delivery
	add constraint ck_Sales_Delivery_DeliveryCity check (DeliveryCity='Montreal')
;
go

/*4) check that Quantity >= 0 in  OrderDetails table*/
alter table Sales.OrderDetails
	add constraint ck_Sales_OrderDetails_Quantity check (Quantity>=0)
;
go


























