/****** Object:  Database UNKNOWN    Script Date: 11/5/20 7:11:37 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE UNKNOWN
GO
CREATE DATABASE UNKNOWN
GO
ALTER DATABASE UNKNOWN
SET RECOVERY SIMPLE
GO
*/

--DROP SCHEMA FudgemartInc
--GO


USE ist722_hhkhan_cb5_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;


CREATE SCHEMA FudgemartInc
GO


/* Drop table FudgemartInc.FactOrderFulfillment */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FudgemartInc.FactOrderFulfillment') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FudgemartInc.FactOrderFulfillment 
;
/* Drop table FudgemartInc.DimCustomer */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FudgemartInc.DimCustomer') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FudgemartInc.DimCustomer 
;
/* Drop table FudgemartInc.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FudgemartInc.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FudgemartInc.DimDate 
;
/* Drop table FudgemartInc.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FudgemartInc.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FudgemartInc.DimProduct 
;
/* Drop table FudgemartInc.DimOrder */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'FudgemartInc.DimOrder') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE FudgemartInc.DimOrder 
;


/* Create table FudgemartInc.DimCustomer */
CREATE TABLE FudgemartInc.DimCustomer (
   [CustomerKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int   NOT NULL
,  [CustomerName]  nvarchar(110)   NOT NULL
,  [CustomerEmail]  varchar(100)   NULL
,  [CustomerAddress]  varchar(255)   NULL
,  [CustomerCity]  varchar(80)   NOT NULL
,  [CustomerState]  varchar(4)   NOT NULL
,  [CustomerZip]  varchar(50)   NOT NULL
,  [CustomerAccPlanID]  int   NULL
,  [CustomerAccOpenDate]  datetime DEFAULT '12/31/1899'  NULL
,  [DataSource] nvarchar(20) NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_FudgemartInc.DimCustomer] PRIMARY KEY CLUSTERED 
( [CustomerKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT FudgemartInc.DimCustomer ON
;
INSERT INTO FudgemartInc.DimCustomer (CustomerKey, CustomerID, CustomerName, CustomerEmail, CustomerAddress, CustomerCity, CustomerState, CustomerZip, CustomerAccPlanID, CustomerAccOpenDate, DataSource, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'NONE', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE', -1, '12/31/1899','NONE', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT FudgemartInc.DimCustomer OFF
;


/* Create table FudgemartInc.DimDate */
CREATE TABLE FudgemartInc.DimDate (
   [DateKey] [int] NOT NULL,
	[Date] [datetime] NULL,
	[FullDateUSA] [nchar](11) NOT NULL,
	[DayOfWeek] [tinyint] NOT NULL,
	[DayName] [nchar](10) NOT NULL,
	[DayOfMonth] [tinyint] NOT NULL,
	[DayOfYear] [int] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[MonthName] [nchar](10) NOT NULL,
	[MonthOfYear] [tinyint] NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [nchar](10) NOT NULL,
	[Year] [int] NOT NULL,
	[IsAWeekday] varchar(1) NOT NULL DEFAULT (('N')),
	constraint pkNorthwindDimDate PRIMARY KEY ([DateKey])
);




INSERT INTO FudgemartInc.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsAWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, 0)
;


/* Create table FudgemartInc.DimProduct */
CREATE TABLE FudgemartInc.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  varchar(20)  NOT NULL
,  [ProductName]  varchar(50)   NOT NULL
,  [ProductDepartment]  varchar(200)   NOT NULL
,  [ProductAddDate]  datetime DEFAULT '12/31/1899'  NOT NULL
,  [DataSource] nvarchar(20) NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_FudgemartInc.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT FudgemartInc.DimProduct ON
;
INSERT INTO FudgemartInc.DimProduct (ProductKey, ProductID, ProductName, ProductDepartment, ProductAddDate, DataSource, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'NONE', 'NONE', '12/31/1899', 'NONE', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT FudgemartInc.DimProduct OFF
;


/* Create table FudgemartInc.DimOrder 
CREATE TABLE FudgemartInc.DimOrder (
   [OrderKey]  int IDENTITY  NOT NULL
,  [OrderID]  int   NOT NULL
,  [OrderDate]  datetime DEFAULT '12/31/1899' NOT NULL
,  [ShippedDate]  datetime DEFAULT '12/31/1899' NULL
,  [ShipVia]  nvarchar(20)   NOT NULL
,  [DataSource] nvarchar(20) NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_FudgemartInc.DimOrder] PRIMARY KEY CLUSTERED 
( [OrderKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT FudgemartInc.DimOrder ON
;
INSERT INTO FudgemartInc.DimOrder (OrderKey, OrderID, OrderDate, ShippedDate, ShipVia, DataSource, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, '12/31/1899', '12/31/1899', 'NONE','NONE', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT FudgemartInc.DimOrder OFF
;
*/

/* Create table FudgemartInc.FactOrderFulfillment */
CREATE TABLE FudgemartInc.FactOrderFulfillment (
   [ProductKey]  int   NOT NULL
,  [CustomerKey]  int   NOT NULL
,  [OrderDateKey]  int   NOT NULL 
,  [ShippedDateKey]  int   NULL
,  [OrderID]  int   NOT NULL
,  [OrderQuantity]  int   NOT NULL
,  [DaysElapsed]  smallint   NULL
,  [DataSource] nvarchar(20) NULL
, CONSTRAINT [PK_FudgemartInc.FactOrderFulfillment] PRIMARY KEY NONCLUSTERED 
( [ProductKey], [OrderID] )
) ON [PRIMARY]
;



ALTER TABLE FudgemartInc.FactOrderFulfillment ADD CONSTRAINT
   FK_FudgemartInc_FactOrderFulfillment_ProductKey FOREIGN KEY
   (
   ProductKey
   ) REFERENCES FudgemartInc.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FudgemartInc.FactOrderFulfillment ADD CONSTRAINT
   FK_FudgemartInc_FactOrderFulfillment_CustomerKey FOREIGN KEY
   (
   CustomerKey
   ) REFERENCES FudgemartInc.DimCustomer
   ( CustomerKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

 
ALTER TABLE FudgemartInc.FactOrderFulfillment ADD CONSTRAINT
   FK_FudgemartInc_FactOrderFulfillment_OrderDateKey FOREIGN KEY
   (
   OrderDateKey
   ) REFERENCES FudgemartInc.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE FudgemartInc.FactOrderFulfillment ADD CONSTRAINT
   FK_FudgemartInc_FactOrderFulfillment_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES FudgemartInc.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 