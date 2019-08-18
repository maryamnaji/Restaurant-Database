/*Create Restaurant database
Sccript Date :September 14,2019
Developed by :Maryam Naji, Zohreh karimzadeh/ Mahtab Abbasigaravand/ Ehsan Bavandsavadkoohi
*/

use GrillSelectResturant2018
;
go



-- HumanResources.Employees
BULK INSERT GrillSelectResturant2018.HumanResources.Employees  
   FROM 'E:\GrillSelect database\TablesData\Employees.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- HumanResources.JobPositions
BULK INSERT GrillSelectResturant2018.HumanResources.JobPositions 
   FROM 'E:\GrillSelect database\TablesData\JobPosition.csv'
    with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;    
GO


-- HumanResources.JobTypes
BULK INSERT GrillSelectResturant2018.HumanResources.JobTypes 
   FROM 'E:\GrillSelect database\TablesData\JobType.csv'
    with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- HumanResources.Drivers
BULK INSERT GrillSelectResturant2018.HumanResources.Drivers 
   FROM 'E:\GrillSelect database\TablesData\Drivers.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- Production.Goods
BULK INSERT GrillSelectResturant2018.Production.Goods 
   FROM 'E:\GrillSelect database\TablesData\Goods.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO

-- Production.GoodsSupply
BULK INSERT GrillSelectResturant2018.Production.GoodsSupply 
   FROM 'E:\GrillSelect database\TablesData\GoodsSupply.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- Production.Suppliers
BULK INSERT GrillSelectResturant2018.Production.Suppliers 
   FROM 'E:\GrillSelect database\TablesData\Suppliers.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;    
GO


-- Sales.Menu
BULK INSERT GrillSelectResturant2018.Sales.Menu 
   FROM 'E:\GrillSelect database\TablesData\Menu.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- Sales.MenuItemTypes
BULK INSERT GrillSelectResturant2018.Sales.MenuItemTypes 
   FROM 'E:\GrillSelect database\TablesData\MenuItemTypes.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;   
GO


-- Sales.Customers
BULK INSERT GrillSelectResturant2018.Sales.Customers
   FROM 'E:\GrillSelect database\TablesData\Customers.csv'
    with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;   
GO

-- Sales.OrderTypes
BULK INSERT GrillSelectResturant2018.Sales.OrderTypes
   FROM 'E:\GrillSelect database\TablesData\OrderType.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;    
GO

-- Sales.Orders
BULK INSERT GrillSelectResturant2018.Sales.Orders
   FROM 'E:\GrillSelect database\TablesData\Orders.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;   
GO

-- Sales.OrderDetails
BULK INSERT GrillSelectResturant2018.Sales.OrderDetails
   FROM 'E:\GrillSelect database\TablesData\OrderDetails.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;  
GO


-- Sales.Delivery
BULK INSERT GrillSelectResturant2018.Sales.Delivery
   FROM 'E:\GrillSelect database\TablesData\Delivery.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;   
GO


-- Production.MenuItemRecepie
BULK INSERT GrillSelectResturant2018.Production.MenuItemRecepie
   FROM 'E:\GrillSelect database\TablesData\MenuItemRecepie.csv'
   with
   (
    FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
;   
GO
