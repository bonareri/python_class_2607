DROP database retailstore;

CREATE DATABASE retailstore;

USE  retailstore;

CREATE TABLE  Customers(
	CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
	Email VARCHAR(70) UNIQUE NOT NULL,
	Phone VARCHAR(15)
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
('Cynthia', 'Mutheu',    'cynthia.mutheu@email.com',  '0701234567');

SELECT * FROM Customers;

# Making changes to the structure
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);

DESCRIBE Customers;

ALTER TABLE Customers
ADD Status VARCHAR(20) DEFAULT 'Active';

ALTER TABLE Customers
DROP COLUMN Status;

CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
	Category VARCHAR(50) NOT NULL,
	Price DECIMAL (10, 2) CHECK (Price >= 0),
	Stock INT NOT NULL CHECK (Stock >= 0)
);

INSERT INTO Products(ProductID, ProductName, Category, Price, Stock)
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

SELECT * FROM Products;

ALTER TABLE Products
MODIFY ProductID INT auto_increment;

ALTER TABLE Products
ADD CreatedAT DATETIME NOT NULL DEFAULT current_timestamp;

DESCRIBE Products;

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY auto_increment,
    CustomerID INT NOT NULL,
	OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	Status VARCHAR(20) DEFAULT 'Pending',
	
    FOREIGN KEY (CustomerID)
		REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
);

INSERT INTO Orders(CustomerID, Status)
VALUES
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

CREATE TABLE OrderDetails (
	OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,	
	Quantity INT NOT NULL CHECK (Quantity > 0),
	UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0 ),
	
    FOREIGN KEY (OrderID)
		REFERENCES Orders(OrderID)
        ON DELETE CASCADE,
        
	FOREIGN KEY (ProductID)
		REFERENCES Products(ProductID)
        ON DELETE CASCADE
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
-- Order 1 HIgh value orders
-- (1, 1, 1, 1189.99),
-- (1, 7, 1, 62.40),
-- (1, 3, 2, 145.75),

-- Order 2 (electronics bundle - slight discount)
(2, 2, 1, 780.00),
(2, 8, 1, 295.00),

-- Order 3 (bulk stationery - realistic office/student purchase)
(3, 5, 20, 3.00),
(3, 6, 50, 1.00),

-- Order 4 (furniture combo)
(4, 4, 1, 210.00),
(4, 10, 1, 45.00),

-- Order 5 (small household purchase)
(5, 9, 4, 10.50),
(5, 5, 6, 3.25),

-- Order 6 (bulk pens - typical Kenyan office/school buying)
(6, 6, 100, 1.00),

-- Order 7 (accessories focused)
(7, 7, 2, 60.00),
(7, 3, 1, 145.75),

-- Order 8 (premium electronics order)
(8, 1, 1, 1150.00),
(8, 8, 1, 300.00),

-- Order 9 (very small budget order)
(9, 9, 2, 11.80);


SELECT * FROM OrderDetails;

-- Selecting specific columns
-- only the names and the emails

SELECT FirstName, LastName, Email FROM Customers;

SELECT * FROM Customers
WHERE Email = 'faith.akinyi@email.com';

-- Find the products that cost more than 
SELECT * FROM Products
WHERE Price > 150;

-- Show the products that cost more than 500 and the stock being less than 20
SELECT * FROM Products
WHERE Price > 500 AND Stock < 20;

-- Show the products that are in the electronics and cost more than 500 or the stock is less than 20
SELECT * FROM Products
WHERE (Category = 'Electronics' AND Price > 500) OR Stock < 20;

-- Order BY CLAUSE
-- Sorting the products by the price
SELECT * FROM Products
ORDER BY Price ASC;

-- Limiting the rows
-- Show the 2 most expensive products
SELECT * FROM Products
ORDER BY Price DESC
LIMIT 2;

SELECT * FROM Products
ORDER BY Price ASC
LIMIT 2;

-- Using DISCTINCT
-- List all the unique products categories
SELECT DISTINCT Category FROM Products;

-- Show products that are in Electronics and cost more than 500 OR the stock is less than 20 and sort this in descing order
SELECT * FROM Products
WHERE (Category = 'Electronics' AND Price > 500 ) OR Stock < 20
ORDER BY Price DESC;

-- UPDATE 
SELECT * FROM Customers;

-- Updating a customer's phone number
UPDATE Customers
SET Phone = '0722222233'
WHERE CustomerID = 2;

-- Updating multiple columns
UPDATE Customers
SET FirstName = 'Melody', Email = 'melodybonareri@gmail.com'
WHERE CustomerID = 2;

-- We want to increase the price of all the Electronics by 10%
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Electronics';

SELECT * FROM Products
WHERE Category = 'Electronics';

-- Temporarirly disable safe mode
SET SQL_SAFE_UPDATES = 0;

-- Re-enable the SAFE MODE
SET SQL_SAFE_UPDATES = 1;

-- Deleting a single record
SELECT * FROM Products
WHERE Category = 'Accessories';

DELETE FROM Products
WHERE ProductID = 1;

-- Delete multiple rows
DELETE FROM Products
WHERE Category = 'Accessories';

-- 	SQL Aggregate functions
-- Total number of customers
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- Total value of all the orders
SELECT * FROM OrderDetails;

SELECT SUM(Quantity * UnitPrice) AS TotalSales FROM OrderDetails;

-- Average price of the products
SELECT AVG(Price) AS AveragePrice FROM Products;

-- Let's find the cheapest product and most expensive products
SELECT MIN(Price) AS CheapestPrice , MAX(Price) AS MostExpensiveProducts
FROM Products;

-- Using Joins
-- INNER JOIN
-- Let's find all the orders along with the customers
SELECT 
	c.CustomerID,
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.Status
FROM Customers c
RIGHT JOIN Orders o
	ON c.CustomerID = o.CustomerID;
    
SELECT * FROM Orders;
SELECT * FROM OrderDetails;

-- OrderID, OrderDate -- Orders
-- ProductID, Quantity, UnitPrice - OrderDetails

-- Orders + OrderDetails
SELECT 
	o.OrderID,
    o.OrderDate,
    d.ProductID,
    d.Quantity,
    d.UnitPrice
FROM Orders o
INNER JOIN OrderDetails d
	ON o.OrderID = d.OrderID;
    
-- Full Sales view (Orders + Products)
SELECT
	o.OrderID,
    p.ProductName,
    p.Category,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS SubTotal
FROM OrderDetails od
INNER JOIN products p
	ON od.ProductID = p.ProductID
INNER JOIN Orders o
	ON od.OrderID = o.OrderID;
    
-- ProductID, ProductName - products
-- Quantity - OrderDetails
SELECT
	p.ProductID,
    p.ProductName,
    od.Quantity
FROM Products p
LEFT JOIN OrderDetails od
	ON p.ProductID = od.ProductID; 
    
-- Using Group BY
-- Total spending per customer
SELECT 
	o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM Orders o
JOIN OrderDetails od 
	ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
ORDER BY TotalSpent DESC;

-- Customers who spent more than 200
-- CustomerID, - Orders
-- FirstName - Customers
-- Total spent - Quantity, UnitPrice - OrderDetails
SELECT 
	o.CustomerID,
    c.FirstName,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent
FROM Orders o
JOIN OrderDetails od 
	ON o.OrderID = od.OrderID
JOIN Customers c
	ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.FirstName
HAVING SUM(od.Quantity * od.UnitPrice) > 200;


-- best selling products
-- Product Name - Products
-- ProductID - OrderDetails
-- Total Quantity - OrderDetails
-- Total Quantity >= 5

-- Case When 
-- Classify the orders into (LOW, MEDIUM and HIGH)
SELECT 
	o.OrderID,
    SUM(od.Quantity * od.UnitPrice) AS TotalAmount,
	CASE
		WHEN SUM(od.Quantity * od.UnitPrice) >= 1000 THEN 'High Value'
		WHEN SUM(od.Quantity * od.UnitPrice) >= 300 THEN 'Medium Value'
		ELSE 'Low Value'
	END AS OrderCategory
FROM Orders o
JOIN OrderDetails od 
	ON o.OrderID = od.OrderID
GROUP BY o.OrderID
ORDER BY OrderCategory;

-- Classify the customers by spending
SELECT
	o.CustomerID,
    SUM(od.Quantity * od.UnitPrice) AS TotalSpent,
	CASE
		WHEN SUM(od.Quantity * od.UnitPrice) >= 1000 THEN 'VIP Customer'
		WHEN SUM(od.Quantity * od.UnitPrice) >= 200 THEN 'Regular Customer'
		ELSE 'Low Spender'
	END AS CustomerSegment
FROM Orders o
JOIN OrderDetails od 
	ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
ORDER BY CustomerSegment DESC;

-- Stock status
SELECT
	ProductName,
    Stock,
    CASE
		WHEN Stock = 0 THEN 'Out of Stock'
        WHEN Stock <= 15 THEN 'Low Stock'
        WHEN Stock < 50 THEN 'Medium stock'
        ELSE 'Well Stocked'
	END AS StockStatus
FROM Products
ORDER BY StockStatus;

-- Add more customers
INSERT INTO Customers (FirstName, LastName, Email, Phone)
VALUES
('Esther',   'Otieno',    'esther.otieno@email.com',     '0712345678'),
('Nancy',  'Mutheu',   'nancy.wanjiku@email.com',   '0723456789'),
('Grace',   'Okoth',    'grace.mwangi@email.com',    '0734567890'),
('Karen',   'Mwende',    'karen.akinyi@email.com',    '0745678901');

SELECT * FROM Customers;

-- Add more products
INSERT INTO Products (ProductName, Category, Price, Stock)
VALUES
('Gaming Chair', 'Furniture', 250.00, 15),
('External Hard Drive', 'Electronics', 95.00, 40),
('Desk Organizer', 'Stationery', 8.50, 200);

SELECT * FROM Products;

-- Add more orders
INSERT INTO Orders (CustomerID, Status)
VALUES
(1, 'Shipped'),
(1, 'Completed'),
(2, 'Completed'),
(2, 'Shipped'),
(3, 'Pending'),
(3, 'Completed'),
(5, 'Completed'),
(5, 'Shipped'),
(6, 'Completed'),
(7, 'Completed');

SELECT * FROM Orders;
SELECT * FROM Products;

-- Update orderdetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
-- Order 11 (high-value customer)
-- (11, 5, 1, 1200.00),
-- (11, 2, 2, 60.00);

-- Order 12 (mid-range electronics)
(12, 2, 1, 790.00),
(12, 5, 1, 150.00),

-- Order 13 (stationery restock)
(13, 5, 15, 3.00),
(13, 6, 40, 1.00),

-- Order 14 (home + furniture mix)
(14, 4, 1, 215.00),
(14, 10, 2, 46.00),

-- Order 15 (low-budget order)
(15, 9, 3, 11.00),

-- Order 16 (bulk office supplies)
(16, 6, 120, 1.00),

-- Order 17 (accessories bundle)
(17, 2, 3, 62.00),
(17, 9, 1, 145.00),

-- Order 18 (premium combo)
(18, 5, 1, 1180.00),
(18, 8, 1, 310.00),

-- Order 19 (small mixed order)
(19, 5, 5, 3.20),
(19, 9, 2, 12.00);

SELECT * FROM OrderDetails;

-- Combined Queries
-- UNION & UNION ALL
-- Customers who have placed orders and those with no orders

SELECT 
	c.CustomerID,
    c.FirstName,
    'Has Orders' AS Status
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID

UNION 

SELECT 
	c.CustomerID,
    c.FirstName,
    'No orders' AS Status
FROM Customers c
WHERE c.CustomerID NOT IN (
	SELECT CustomerID FROM Orders
);


-- Completed vs Pending Orders
-- UNION 
SELECT 
	OrderID,
    Status
FROM Orders
WHERE Status = 'Completed'

UNION 

SELECT 
	OrderID,
    Status
FROM Orders
WHERE Status = 'Pending';

-- Using Intersect - Only common rows
-- Customers who have both placed orders and spent more than 1000
SELECT CustomerID
FROM Orders

INTERSECT

SELECT o.CustomerID
FROM Orders o
JOIN OrderDetails od
	ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
HAVING SUM(od.Quantity * od.UnitPrice) > 1000;

-- Products in the Electronics category and have been sold
SELECT ProductName
FROM Products
WHERE Category = 'Electronics'

INTERSECT 

SELECT p.ProductName
FROM Products p
JOIN OrderDetails od
	ON p.ProductID = od.ProductID;
    
-- Except - Return the rows from the first query that are not in the second query
-- Products that have never been sold
SELECT ProductName
FROM Products;

EXCEPT 

SELECT p.ProductName
FROM Products p
JOIN OrderDetails od
	ON p.ProductID = od.ProductID;

-- Customers who have not placed any order
SELECT FirstName, LastName
FROM Customers

EXCEPT

SELECT c.FirstName, c.LastName
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID;
    
-- Using Subqueries
-- Frequent buyers
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
	SELECT CustomerID
    FROM Orders
	GROUP BY CustomerID
	HAVING COUNT(OrderID) > 2
);


-- Total spent per customer
SELECT 
	ct.CustomerID,
    c.FirstName,
    c.LastName,
    ct.TotalSpent
FROM (
	SELECT 
		o.CustomerID,
        SUM(od.Quantity * od.UnitPrice) AS TotalSpent
	FROM Orders o
    JOIN OrderDetails od
		ON o.OrderID = od.OrderID
	GROUP BY o.CustomerID
) AS ct
JOIN Customers c
	ON ct.CustomerID = c.CustomerID;
    
-- Products that haven't been sold
SELECT ProductName
FROM Products
WHERE ProductID NOT IN (
	SELECT ProductID
	FROM OrderDetails
);


-- Products that sold in High-Value Orders
SELECT 
	ProductName,
    TotalSales
FROM Products p
JOIN (
	SELECT 
		ProductID,
		SUM(Quantity * UnitPrice) AS TotalSales
	FROM OrderDetails
	GROUP BY ProductID
)AS pt
	ON p.ProductID = pt.ProductID
WHERE pt.TotalSales > 1000;

-- Using CTEs
-- Customers who placed more than one order
WITH CustomerOrderCounts AS (
	SELECT CustomerID, COUNT(OrderID) AS OrderCount
	FROM Orders
	GROUP BY CustomerID
)

-- Use the CTE
SELECT c.FirstName, coc.OrderCount
FROM Customers c
JOIN CustomerOrderCounts coc
ON c.CustomerID = coc.CustomerID
WHERE coc.OrderCount > 2; 

-- High Values
WITH OrderTotals AS (
	SELECT 
		o.OrderID,
        SUM(od.Quantity * od.UnitPrice) AS OrderTotals
	FROM Orders o
    JOIN OrderDetails od
		ON o.OrderID = od.OrderID
	GROUP BY o.OrderID
),
AvgOrder AS (
	SELECT AVG(OrderTotals) AS AvgTotal
    FROM OrderTotals
)

SELECT 
	ot.OrderID,
    ot.OrderTotals
FROM OrderTotals ot
CROSS JOIN AvgOrder ao
WHERE ot.OrderTotals > ao.AvgTotal;