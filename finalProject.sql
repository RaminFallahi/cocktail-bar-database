-- =================================CREATING TABLES===========================

Create table Customer_Info(
CustomerId int PRIMARY KEY AUTO_INCREMENT,
Email varchar(255),
Fname varchar(255),
Lname varchar(255),
Password varchar(255),
Phone varchar(255),
Address VARCHAR(255),
PostalCode varchar(255),
City varchar(255),
Status varchar(255),
Birth date,
Gender varchar(255),
CONSTRAINT check_Status CHECK ((Status = "active") OR (Status = "notactive")),
CONSTRAINT check_Gender CHECK ((Gender = "male") OR (Gender = "female"))
);


Create table Item_Info(
ItemId int PRIMARY KEY AUTO_INCREMENT,
VodkaPrice DECIMAL,
RumPrice DECIMAL,
GinPrice DECIMAL,
VodkaTotalQuantity int,
RumTotalQuantity int,
GinTotalQuantity int
);


Create table Order_Info(
OrderId int PRIMARY KEY AUTO_INCREMENT,
CustomerId INT,
Date Date,
Gin INT,
Vodka INT,
Rum INT,
TotalPrice DECIMAL
);

CREATE TABLE bridge(
BridgeId INT PRIMARY KEY AUTO_INCREMENT,
CustomerId INT,
OrderId INT,
ItemId INT
);
-- =================================== INPUTING DATA ==================================


INSERT INTO Customer_Info
VALUES (NULL, "","July","sam","jsam1223","","", "","","notactive", "2001-09-09", "female")

-- -------------------------------------------------------------------
ALTER TABLE bridge ADD FOREIGN KEY (CustomerId)
REFERENCES Customer_Info( CustomerId);

ALTER TABLE bridge ADD FOREIGN KEY (OrderId)
REFERENCES Order_Info(OrderId), ADD FOREIGN KEY (ItemId)
REFERENCES Item_Info( ItemId);

-- ---------------------------------------------------------------------------
ALTER TABLE Order_Info ADD FOREIGN KEY (CustomerId)
REFERENCES Customer_Info(CustomerId);
-- ------------------------------------------------------------------------------
INSERT INTO Order_Info VALUES (NULL, '1','2022-01-11', 1, 0, 0, 21);
INSERT INTO Order_Info VALUES (NULL, '3','2022-04-04', 1, 1, 2, 55);
INSERT INTO Order_Info VALUES (NULL, '5','2022-01-10', 0, 0, 4, 60);

-- ----------------------------------------------------------------------------------

INSERT INTO Item_Info
VALUES (NULL, 21.6, 18.4, 15, 123, 345, 678);

INSERT INTO bridge VALUES (NULL, 1,1,1);

INSERT INTO bridge VALUES (NULL, 1,2,1);
INSERT INTO bridge VALUES (NULL, 5,3,1);
INSERT INTO bridge VALUES (NULL, 1,4,1);
INSERT INTO bridge VALUES (NULL, 4,5,1);
INSERT INTO bridge VALUES (NULL, 5,6,1);

-- =================================== VIEW ==================================


CREATE VIEW eachDrinkPrice
AS SELECT RumPrice, a.ItemId  FROM Item_Info a
JOIN bridge b 
ON a.ItemId = b.ItemId

DROP VIEW  eachDrinkPrice;

CREATE VIEW eachDrinkPrice
AS SELECT RumPrice, GinPrice, VodkaPrice  FROM Item_Info a
JOIN bridge b 
ON a.ItemId = b.ItemId
JOIN Order_Info c
ON b.CustomerId = c.CustomerId

-- ==================================== RECREATING TABLES AND INSERTING DATA ============================
DROP TABLE bridge
DROP TABLE Order_Info 
DROP TABLE Item_Info 
DROP VIEW eachDrinkPrice

-- ----------------------------------------
CREATE TABLE Menu (
MenuId INT PRIMARY KEY AUTO_INCREMENT, ProductId INT, Product VARCHAR(255), PRICE DECIMAL);

INSERT INTO Menu  (MenuId, ProductId, Product, PRICE)
VALUES (NULL, 1, "Vodka", 10), (NULL, 2, "Gin", 15), (NULL, 3, "Rum", 20)

-- -------------------------------------
CREATE TABLE OrderTable (
OrderId INT PRIMARY KEY AUTO_INCREMENT,
CustomerId INT,
ProductId INT,
Product VARCHAR(255),
Date date
);

INSERT INTO OrderTable (OrderId, CustomerId, ProductId, Product, Date)
VALUES (NULL, 1, 1, "Vodka", "2021-09-09"), (NULL, 2, 2, "Gin", "2021-11-09"), (NULL, 3, 3, "Rum", "2022-02-09"), 
(NULL, 4, 3, "Rum", "2022-11-11"), (NULL,5, 3, "Rum", "2021-05-09")

INSERT INTO OrderTable (OrderId, CustomerId, ProductId, Product, Date)
VALUES (NULL, 1, 1, "Vodka", "2021-09-09"), (NULL, 1, 2, "Gin", "2021-11-09"), (NULL, 1, 3, "Rum", "2022-02-09"), 
(NULL, 2, 2, "Gin", "2022-11-11"), (NULL,2, 3, "Rum", "2021-05-09")

INSERT INTO OrderTable (OrderId, CustomerId, ProductId, Product, Date)
VALUES (NULL, 6, 3, "Rum", "2022-12-01"), (NULL, 6, 3, "Rum", "2022-12-01"), (NULL, 6, 2, "Gin", "2022-12-01"), 
(NULL, 6, 1, "Vodka", "2022-12-01"), (NULL, 6, 1, "Vodka", "2022-12-01")

-- ==================================== LINKING THE FOREGIN KEYS ============================

ALTER TABLE OrderTable ADD FOREIGN KEY (CustomerId)
REFERENCES Customer_Info(CustomerId);

ALTER TABLE OrderTable ADD FOREIGN KEY (ProductId)
REFERENCES Menu(MenuId);


-- ==================================== VIEW ============================
CREATE VIEW PriceOfEachDrink2
AS SELECT b.PRICE, CustomerId, a.Product, `Date` FROM OrderTable a
JOIN Menu b
ON a.ProductId = b.MenuId

CREATE VIEW PriceOfEachDrink
AS SELECT b.CustomerId, c.Fname, c.Lname, b.Product, a.PRICE, `Date` FROM Menu a
JOIN OrderTable b
ON a.MenuId = b.ProductId 
JOIN Customer_Info c
ON b.CustomerId = c.CustomerId 

-- ==================================== FUNCTION ============================
SELECT CustomerId, Fname AS "First Name", Lname AS "Last Name", `Date` AS "Date of Purchase", 
SUM(PRICE) AS "Total Price" FROM PriceOfEachDrink 
GROUP BY CustomerId, `Date` 

-- - ==================================== EDIT ============================

REPLACE INTO Customer_Info (Fname, Lname)
VALUES ("Anthony", "Ho");

update Customer_Info
set Lname = Chang
WHERE Email = NULL AND Fname = Asma;

UPDATE Customer_Info
SET Email = 'Ho@gmail.com', Password = 'AnthonyHo', Phone = 1234565437, Address = "Some Wehre in RichmondHill", PostalCode = "1r5w8g"
WHERE CustomerID = 1;

UPDATE Customer_Info
SET Lname = "Chang", Fname = "Ellis", Email = 'Hogo@gmail.com', Password = 'AnyHo', Phone = 12367895437, Address = "Some Wehre nearby", PostalCode = "1r5f6g"
WHERE CustomerID = 5;







