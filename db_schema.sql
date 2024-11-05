CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Brand VARCHAR(100),
    Category VARCHAR(100),
    Image_url VARCHAR(1000),
    Price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    SalePrice DECIMAL(10,2) DEFAULT NULL,
    Specs VARCHAR(500) DEFAULT NULL,
    Stock INT NOT NULL
);

CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(100),
    Discount INT NOT NULL CHECK (Discount >= 0 AND Discount <= 100)
);

CREATE TABLE Customers (
    Email VARCHAR(100) UNIQUE NOT NULL PRIMARY KEY,
    Password VARCHAR(100) UNIQUE NOT NULL
);  

CREATE TABLE Admins(
    AdminID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Address TEXT,
    PaymentDetails TEXT,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'Processing', 'Completed', 'Cancelled')),
    Total DECIMAL(10, 2),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (Email) REFERENCES Customers(Email) ON DELETE CASCADE
);

CREATE TABLE OrderItems (
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);




