DROP database onlinestore;

CREATE DATABASE onlinestore;

USE onlinestore;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    RegistrationDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE Customers
MODIFY CustomerID INT NOT NULL AUTO_INCREMENT;

INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
('Brian',   'Otieno',    'brian.otieno@email.com',     '0712345678'),
('Akinyi',  'Wanjiku',   'akinyi.wanjiku@email.com',   '0723456789'),
('Kevin',   'Mwangi',    'kevin.mwangi@email.com',    '0734567890'),
('Faith',   'Akinyi',    'faith.akinyi@email.com',    '0745678901'),
('Dennis',  'Omondi',    'dennis.omondi@email.com',   '0756789012'),
('Sharon',  'Chebet',    'sharon.chebet@email.com',   '0767890123'),
('Peter',   'Kiptoo',    'peter.kiptoo@email.com',    '0778901234'),
('Mercy',   'Njeri',     'mercy.njeri@email.com',     '0789012345'),
('Samuel',  'Wekesa',    'samuel.wekesa@email.com',   '0790123456'),
('Cynthia', 'Mutheu',    'cynthia.mutheu@email.com',  '0701234567'),
('Melody',  'Bonareri',  'melodybonareri@gmail.com',  '0727125056');

SELECT * FROM Customers;

DESCRIBE Customers;

## Making changes to the structure
## Change a column definition - allow longer phone numbers
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

## Add a new column - add customer status
ALTER TABLE Customers
ADD Status VARCHAR(20) DEFAULT 'Active';

## Remove a column
ALTER TABLE Customers
DROP COLUMN Status;

## Rename a column  - rename Phone - PhoneNumber
ALTER TABLE Customers
RENAME COLUMN Phone TO PhoneNumber;

## Drop UNIQUE constraint
ALTER TABLE Customers
DROP INDEX Email;

## Add UNIQUE constraint
ALTER TABLE Customers
ADD CONSTRAINT uq_customers_email UNIQUE (Email);

## Update existing data after schema change
UPDATE Customers
SET LastName = 'Kamau'
WHERE CustomerID = 1;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0)
);

# Insert sample data

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop',        'Electronics', 1189.99, 8),
(2, 'Smartphone',    'Electronics', 799.50, 30),
(3, 'Headphones',    'Accessories', 145.75, 45),
(4, 'Desk Chair',    'Furniture',   215.20, 12),
(5, 'Notebook',      'Stationery',  3.25,   120),
(6, 'Pen',           'Stationery',  1.15,   600),
(7, 'Backpack',      'Accessories', 62.40,  35),
(8, 'Monitor',       'Electronics', 310.99, 18),
(9, 'Coffee Mug',    'Kitchen',     11.80,  80),
(10,'Table Lamp',    'Furniture',   47.25,  25),
(11,'Dish Washer',   'Kitchen',     220.00, 15);

# Update structure
ALTER TABLE Products
MODIFY ProductID INT AUTO_INCREMENT;

# Add a “CreatedAt” column to track when products are added:
ALTER TABLE Products
ADD CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

# Add UNIQUE constraint on ProductName per category:
ALTER TABLE Products
ADD CONSTRAINT uq_product UNIQUE (ProductName, Category);

DESCRIBE Products;
SELECT * FROM Products;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
);

INSERT INTO Orders (CustomerID, Status)
VALUES
(1, 'Completed'),
(2, 'Shipped'),
(3, 'Completed'),
(1, 'Completed'),
(5, 'Pending'),
(6, 'Cancelled'),
(7, 'Shipped'),
(8, 'Completed'),
(9, 'Pending'),
(10, 'Completed');

SELECT * FROM Orders;
