CREATE DATABASE INVENTORY_MANAGEMENT_SYSTEM;

use INVENTORY_MANAGEMENT_SYSTEM;

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    SKU NVARCHAR(50) UNIQUE NOT NULL,
    Category NVARCHAR(50) NULL,
    Quantity INT DEFAULT 0,
    UnitPrice DECIMAL(10, 2) NULL,
    Barcode NVARCHAR(50) NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

-- Insert data into Products
INSERT INTO Products (Name, SKU, Category, Quantity, UnitPrice, Barcode) VALUES
('Product 1', 'SKU202', 'Category 1', 100, 55.00, '123456789'),
('Product 2', 'SKU550', 'Category 2', 200, 85.00, '987654321');

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100) NULL,
    Phone NVARCHAR(15) NULL,
    Email NVARCHAR(100) NULL,
    Address NVARCHAR(255) NULL
);

-- Insert data into Suppliers
INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email, Address) VALUES
('Supplier 1', 'Contact1', '123456789', 'contact1@exp.com', 'Address 1'),
('Supplier 2', 'Contact2', '987654321', 'contact2@exp.com', 'Address 2');


-- Create PurchaseOrders table
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY IDENTITY(1,1),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),
    TotalAmount DECIMAL(10, 2) NULL
);

-- Insert data into PurchaseOrders
INSERT INTO PurchaseOrders (SupplierID, OrderDate, Status, TotalAmount) VALUES
(1, GETDATE(), 'Pending', 800.00),
(2, GETDATE(), 'Completed', 125.00);


-- Create PurchaseOrderDetails table
CREATE TABLE PurchaseOrderDetails (
    PODetailID INT PRIMARY KEY IDENTITY(1,1),
    PurchaseOrderID INT FOREIGN KEY REFERENCES PurchaseOrders(PurchaseOrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);

-- Insert data into PurchaseOrderDetails
INSERT INTO PurchaseOrderDetails (PurchaseOrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 15, 50.00),
(2, 2, 25, 50.00);


-- Create SalesOrders table
CREATE TABLE SalesOrders (
    SalesOrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100) NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Cancelled')),
    TotalAmount DECIMAL(10, 2) NULL
);

-- Insert data into SalesOrders
INSERT INTO SalesOrders (CustomerName, OrderDate, Status, TotalAmount) VALUES
('Customer A', GETDATE(), 'Pending', 300.00),
('Customer B', GETDATE(), 'Shipped', 600.00);


-- Create SalesOrderDetails table
CREATE TABLE SalesOrderDetails (
    SODetailID INT PRIMARY KEY IDENTITY(1,1),
    SalesOrderID INT FOREIGN KEY REFERENCES SalesOrders(SalesOrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL
);

-- Insert data into SalesOrderDetails
INSERT INTO SalesOrderDetails (SalesOrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 6, 50.00),
(2, 2, 12, 50.00);


-- Create StockMovements table
CREATE TABLE StockMovements (
    MovementID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    MovementType NVARCHAR(20) CHECK (MovementType IN ('IN', 'OUT', 'ADJUSTMENT')),
    Quantity INT NOT NULL,
    MovementDate DATETIME DEFAULT GETDATE(),
    Description NVARCHAR(255) NULL
);

-- Insert data into StockMovements
INSERT INTO StockMovements (ProductID, MovementType, Quantity, MovementDate, Description) VALUES
(1, 'IN', 15, GETDATE(), 'Restocked'),
(2, 'OUT', 8, GETDATE(), 'Sold');


-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'Manager', 'Staff')),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Insert data into Users
INSERT INTO Users (Username, PasswordHash, Role) VALUES
('user1', 'hashedpassword3', 'Admin'),
('user2', 'hashedpassword4', 'Manager');


-- Create AuditLogs table
CREATE TABLE AuditLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    Action NVARCHAR(100) NOT NULL,
    TableAffected NVARCHAR(50) NULL,
    ActionTime DATETIME DEFAULT GETDATE(),
    Description NVARCHAR(255) NULL
);

-- Insert data into AuditLogs
INSERT INTO AuditLogs (UserID, Action, TableAffected, ActionTime, Description) VALUES
(1, 'INSERT', 'Products', GETDATE(), 'Added Product 1'),
(2, 'UPDATE', 'Products', GETDATE(), 'Updated Product 2');


-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) UNIQUE NOT NULL,
    Description NVARCHAR(255) NULL
);

-- Insert data into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Category 1', 'Description for Category 1'),
('Category 2', 'Description for Category 2');



SELECT * FROM Products;
SELECT * FROM Suppliers;
SELECT * FROM PurchaseOrders;
SELECT * FROM PurchaseOrderDetails;
SELECT * FROM SalesOrders;
SELECT * FROM SalesOrderDetails;
SELECT * FROM StockMovements;
SELECT * FROM Users;
SELECT * FROM AuditLogs;
SELECT * FROM Categories;
