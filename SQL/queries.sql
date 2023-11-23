-- Brands Table

CREATE TABLE Brands (
    BrandID INT AUTO_INCREMENT PRIMARY KEY,
    BrandName VARCHAR(255) NOT NULL
);

INSERT INTO Brands (BrandName) VALUES
    ('Volkswagen'),
    ('Audi'),
    ('SEAT'),
    ('Škoda'),
    ('Bentley'),
    ('Bugatti'),
    ('Porsche'),
    ('Lamborghini');

--Models Table

CREATE TABLE Models (
    ModelID INT AUTO_INCREMENT PRIMARY KEY,
    BrandID INT,
    ModelName VARCHAR(255) NOT NULL,
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);

INSERT INTO Models (BrandID, ModelName) VALUES 
(1, 'Golf'), 
(1, 'Passat'), 
(1, 'Tiguan'), 
(1, 'Jetta'), 
(1, 'Atlas'), 
(1, 'Arteon'), 
(2, 'A3'), 
(2, 'A4'), 
(2, 'Q5'), 
(2, 'Q7'), 
(3, 'Ibiza'), 
(3, 'Leon'), 
(3, 'Ateca'), 
(4, 'Octavia'), 
(4, 'Superb'), 
(4, 'Kodiaq'), 
(5, 'Continental GT'), 
(5, 'Bentayga'), 
(6, 'Chiron'), 
(7, '911'), 
(7, 'Cayenne'), 
(7, 'Panamera'), 
(8, 'Huracán'), 
(8, 'Aventador');


--Suppliers Table   
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL
);

INSERT INTO Suppliers (SupplierName)
VALUES
    ('Friedrich Boysen GmbH & Co. KG'),
    ('HARTING Automotive GmbH'),
    ('Jiangsu Pacific Precision Forging Co., Ltd.'),
    ('Mueba Carbo Tech GmbH'),
    ('Nemak S.A.'),
    ('Getrag'),
    ('SIEM Car Carriers AS'),
    ('STIWA Advanced Products GmbH');

-- Plants Table

CREATE TABLE Plants (
    PlantID INT AUTO_INCREMENT PRIMARY KEY,
    PlantName VARCHAR(255) NOT NULL,
    Function VARCHAR(255) NOT NULL,
    ModelIDs VARCHAR(255) NOT NULL
);
INSERT INTO:


INSERT INTO Plants (PlantID, PlantName, Function, ModelIDs)
VALUES
    (1, 'VW Plant', 'Final Assembly', '1,2,3,4,5,6'),
    (2, 'Audi Plant', 'Final Assembly', '7,8,9,10'),
    (3, 'SEAT Plant', 'Parts Supplier', '11,12,13'),
    (4, 'Škoda Plant', 'Final Assembly', '14,15,16'),
    (5, 'Bentley Plant', 'Final Assembly', '17,18'),
    (6, 'Bugatti Plant', 'Parts Supplier', '19'),
    (7, 'Porsche Plant', 'Final Assembly', '20,21,22'),
    (8, 'Lamborghini Plant', 'Parts Supplier', '23,24');

--Options Table

CREATE TABLE Options (
    OptionID INT AUTO_INCREMENT PRIMARY KEY,
    OptionType VARCHAR(255) NOT NULL,
    OptionValue VARCHAR(255) NOT NULL
);

INSERT INTO Options (OptionType, OptionValue) VALUES
  ('Color', 'Black'),
  ('Color', 'Silver'),
  ('Color', 'Blue'),
  ('Engine', 'V6'),
  ('Engine', 'Inline-4'),
  ('Engine', 'V8'),
  ('Transmission', 'Automatic'),
  ('Transmission', 'Manual');

--Dealers

CREATE TABLE Dealers (
    DealerID INT AUTO_INCREMENT PRIMARY KEY,
    DealerName VARCHAR(255) NOT NULL,
    AllowedBrands VARCHAR(255) NOT NULL
);

INSERT INTO Dealers (DealerID, DealerName, AllowedBrands)
VALUES
    (1, 'VW Dealer', '1'),
    (2, 'Audi Dealer', '2'),
    (3, 'SEAT Dealer', '3'),
    (4, 'Škoda Dealer', '4'),
    (5, 'Bentley Dealer', '5'),
    (6, 'Bugatti Dealer', '6'),
    (7, 'Porsche Dealer', '7'),
    (8, 'Lamborghini Dealer', '8');

--Inventory

CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    DealerID INT,
    VIN VARCHAR(255) NOT NULL,
    IsSold BOOLEAN NOT NULL,
    FOREIGN KEY (DealerID) REFERENCES Dealers(DealerID)
);

INSERT INTO Inventory (InventoryID, DealerID, VIN, IsSold)
VALUES
    (1, 1, 'WVWZZZ1JZXW000001', 0),
    (2, 2, 'WAUZZZ8VZW100001', 0),
    (3, 3, 'VSSZZZ6JZW200001', 0),
    (4, 4, 'TMBZZZ5EZW300001', 0),
    (5, 5, 'SCBZZZ0TZW400001', 0),
    (6, 6, 'VF9SP3VZW500001', 0),
    (7, 7, 'WP0ZZZ9YZW600001', 0),
    (8, 8, 'ZHWZZZ12ZW700001', 0);

--Customers Table

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(15),
    Gender VARCHAR(10),
    AnnualIncome INT
);

INSERT INTO Customers (CustomerName, Address, Phone, Gender, AnnualIncome)
VALUES
('John Doe', '123 Main St', '123-456-7890', 'Male', 80000),
('Jane Doe', '456 Oak St', '987-654-3210', 'Female', 100000),
('Bob Smith', '789 Pine St', '456-789-0123', 'Male', 120000),
('Alice Johnson', '321 Elm St', '654-321-0987', 'Female', 90000),
('Michael Brown', '567 Maple St', '789-012-3456', 'Male', 90000),
('Emily White', '890 Oak St', '234-567-8901', 'Female', 110000),
('David Miller', '123 Pine St', '567-890-1234', 'Male', 80000),
('Olivia Davis', '456 Elm St', '123-456-7890', 'Female', 95000),
('Alice Johnson', '789 Pine St, Villagetown', '555-123-4567', 'F', 75000),
('Bob Williams', '101 Elm St, Hamletville', '777-888-9999', 'M', 90000),
('Eva Martinez', '202 Maple St, Riverside', '333-456-7890', 'F', 85000),
('Michael Davis', '505 Cedar St, Hillside', '444-555-6666', 'M', 100000),
('Sophia Lee', '606 Birch St, Mountainview', '666-777-8888', 'F', 80000)
('Robert Johnson', '111 Oak St', '111-222-3333', 'M', 75000),
('Linda Brown', '222 Pine St', '222-333-4444', 'F', 95000),
('William Taylor', '333 Cedar St', '333-444-5555', 'M', 110000),
('Emma Anderson', '444 Elm St', '444-555-6666', 'F', 120000),
('Daniel Harris', '555 Maple St', '555-666-7777', 'M', 80000),
('Sophie Wilson', '666 Oak St', '666-777-8888', 'F', 100000),
('Christopher Davis', '777 Pine St', '777-888-9999', 'M', 85000),
('Ava Miller', '888 Elm St', '888-999-0000', 'F', 90000),
('Matthew Jackson', '999 Cedar St', '999-000-1111', 'M', 95000),
('Olivia Moore', '123 Birch St', '000-111-2222', 'F', 80000);

--Vehicles Table

CREATE TABLE Vehicles (
VehicleID INT AUTO_INCREMENT PRIMARY KEY,
VIN VARCHAR(255) NOT NULL,
BrandID INT,
ModelID INT,
BodyStyle VARCHAR(255),
Color VARCHAR(255),
Engine VARCHAR(255),
Transmission VARCHAR(255),
FOREIGN KEY (BrandID) REFERENCES Brands(BrandID),
FOREIGN KEY (ModelID) REFERENCES Models(ModelID)
);

INSERT INTO Vehicles (VIN, BrandID, ModelID, BodyStyle, Color, Engine, Transmission)
VALUES
      ('WVWZZZ1JZXW000001', 1, 1, 'Sedan', 'Blue', '2.0L Turbo', 'Automatic'),
      ('WVWZZZ1JZXW000002', 1, 2, 'Hatchback', 'Red', '1.8L Turbo', 'Manual'),
      ('WVWZZZ1JZXW000003', 1, 3, 'SUV', 'Silver', '2.0L Turbo', 'Automatic'),
      ('WAUZZZ8VZW100001', 2, 5, 'Sedan', 'Black', '3.0L Supercharged', 'Automatic'),
      ('WAUZZZ8VZW100002', 2, 6, 'SUV', 'White', '2.0L Turbo', 'Automatic'),
      ('WAUZZZ8VZW100003', 2, 7, 'Convertible', 'Silver', '4.0L Twin-Turbo', 'Automatic'),
      ('VSSZZZ6JZW200001', 3, 11, 'SUV', 'Blue', '1.5L Turbo', 'Automatic'),
      ('VSSZZZ6JZW200002', 3, 12, 'Sedan', 'White', '1.0L Turbo', 'Manual'),
      ('VSSZZZ6JZW200003', 3, 13, 'SUV', 'Red', '2.0L Turbo', 'Automatic'),
      ('TMBZZZ5EZW300001', 4, 14, 'SUV', 'Gray', '2.0L Turbo', 'Automatic'),
      ('TMBZZZ5EZW300002', 4, 15, 'Sedan', 'Black', '1.5L Turbo', 'Manual'),
      ('TMBZZZ5EZW300003', 4, 16, 'Hatchback', 'Silver', '1.6L Diesel', 'Automatic'),
      ('SCBZZZ0TZW400001', 5, 17, 'Convertible', 'Blue', '6.0L W12', 'Automatic'),
      ('SCBZZZ0TZW400002', 5, 4, 'SUV', 'Green', '4.0L V8', 'Automatic'),
      ('VF9SP3VZW500001', 6, 18, 'Convertible', 'Black', '8.0L Quad-Turbo W16', 'Automatic'),
      ('VF9SP3VZW500002', 6, 16, 'Coupe', 'Yellow', '8.0L Quad-Turbo W16', 'Automatic'),
      ('WP0ZZZ9YZW600001', 7, 21, 'Coupe', 'Silver', '3.0L Twin-Turbo Flat-6', 'Automatic'),
      ('WP0ZZZ9YZW600002', 7, 22, 'SUV', 'Black', '2.9L Twin-Turbo V6', 'Automatic'),
      ('WP0ZZZ9YZW600003', 7, 23, 'Convertible', 'Red', '4.0L Twin-Turbo Flat-6', 'Automatic'),
      ('ZHWZZZ12ZW700001', 8, 24, 'Coupe', 'Yellow', '6.5L V12', 'Automatic'),
      ('ZHWZZZ12ZW700002', 8, 23, 'Convertible', 'Blue', '5.2L V10', 'Automatic'),
      ('ZHWZZZ12ZW700003', 8, 22, 'SUV', 'Green', '4.0L Twin-Turbo V8', 'Automatic');

--Sales Table

CREATE TABLE Sales (
SaleID INT AUTO_INCREMENT PRIMARY KEY,
VIN VARCHAR(255) NOT NULL,
DealerID INT,
CustomerID INT,
SaleDate DATE,
SaleAmount DECIMAL(10,2),
FOREIGN KEY (VIN) REFERENCES Vehicles(VIN),
FOREIGN KEY (DealerID) REFERENCES Dealers(DealerID),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Sales (SaleID, VIN, DealerID, CustomerID, SaleDate, SaleAmount)
VALUES
    (1, 'WVWZZZ1JZXW000001', 1, 5, '2020-03-25', 25000.00),
    (2, 'WVWZZZ1JZXW000002', 1, 10, '2020-06-10', 30000.00),
    (3, 'WAUZZZ8VZW100001', 2, 15, '2020-08-20', 35000.00),
    (4, 'VSSZZZ6JZW200001', 3, 20, '2020-09-05', 40000.00),
    (5, 'TMBZZZ5EZW300001', 4, 2, '2020-11-10', 50000.00),
    (6, 'SCBZZZ0TZW400001', 5, 7, '2021-01-15', 60000.00),
    (7, 'VF9SP3VZW500001', 6, 12, '2021-01-30', 80000.00),
    (8, 'WP0ZZZ9YZW600001', 7, 17, '2021-05-12', 85000.00),
    (9, 'ZHWZZZ12ZW700001', 8, 22, '2021-07-25', 30000.00),
    (10, 'WVWZZZ1JZXW000003', 1, 3, '2021-10-05', 32000.00),
    (11, 'WAUZZZ8VZW100002', 2, 8, '2022-01-01', 40000.00),
    (12, 'VSSZZZ6JZW200002', 3, 13, '2022-03-15', 45000.00),
    (13, 'TMBZZZ5EZW300002', 4, 18, '2022-05-27', 70000.00),
    (14, 'SCBZZZ0TZW400002', 5, 23, '2022-07-10', 75000.00),
    (15, 'VF9SP3VZW500002', 6, 4, '2022-09-25', 90000.00);