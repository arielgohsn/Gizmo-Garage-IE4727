DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Admins;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Promotions;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Brand VARCHAR(100),
    Category VARCHAR(100),
    Image_url VARCHAR(1000),
    Price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    SalePrice DECIMAL(10,2) DEFAULT NULL,
    Specs VARCHAR(500) DEFAULT NULL,
    Stock INT NOT NULL,
    UploadedAt TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(100),
    Discount INT NOT NULL CHECK (Discount >= 0 AND Discount <= 100)
);

CREATE TABLE Customers (
    Email VARCHAR(100) UNIQUE NOT NULL PRIMARY KEY,
    Password VARCHAR(100) NOT NULL
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
    CardNum VARCHAR(4),
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

INSERT INTO Admins (Email, Password) VALUES 
('admin@garage.com', MD5('admin123'));

INSERT INTO Products (ProductName, Brand, Category, Image_url, Price, Stock, Specs) VALUES
('ASUS Chromebook Laptop Student Business 2024', 'ASUS', 'Laptops', 'https://m.media-amazon.com/images/I/61wR4i8il-L._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81Bf5NNca6L._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81bOqPWqWoL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81-obFV8NBL._AC_SX679_.jpg', 239.00, 80, 'Brand: ASUS,Model: 2024 Flagship ASUS Chromebook,Screen size: 14 Inches,Colour: Gravity Grey,Hard disk size: 64 GB,CPU model: Others,Installed RAM memory size: 4 GB,Operating system: Chrome OS'),
('HP EliteBook 640', 'HP', 'Laptops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/c/0/c08473069_4.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/e/l/elitebook-640-g11-rex14-dimension_2.jpg,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/e/l/elitebook-640-g11-rex14-ports_2.jpg', 1859.00, 100, 'Brand: HP,Processor: Intel® Core™ Ultra 5 125U,Graphics: Intel® Graphics,Screen Size: 14\" diagonal WUXGA display,Memory and storage: 16 GB memory; 512 GB SSD storage,Operating system: Windows 11 Pro'),
('HP Pavilion x360', 'HP', 'Laptops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/c/0/c08908326_3_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/r/i/riesling_sb_ports_1_3_1.jpg, https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/A/0/A05LXPA-4_T1711948351_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/r/i/riesling_sb_dimension_1_1.png', 1349.00, 200, 'Brand: HP,Processor: Intel® Core™ Ultra 7 155U,Graphics: Intel® Graphics,Screen Size: 14\" diagonal 2.8K OLED touch display,Memory and storage: 16 GB memory; 1 TB SSD storage,Operating system: Windows 11 Home'),
('HP Spectre x360', 'HP', 'Laptops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/2/3/23c2_spectre_herbie_16_nightfall_black_t_9mp_ir_cam_nonfpr_avicii_2b_win11_core_set_tent_whitebg_touch_evoultra.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/2/4/24c1-spectre-14-x360-willie-black-annotated-img-1_1.jpg,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/2/4/24c1-spectre-14-x360-willie-black-annotated-img-2_1.jpg,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/c/0/c08744276.png', 3499.00, 150, 'Brand: HP,Operating system: Windows 11 Home,Processor: Intel® Core™ Ultra 7 155H (up to 4.8 GHz with Intel® Turbo Boost Technology, 24 MB L3 cache, 16 cores, 22 threads),Graphics: NVIDIA GeForce RTX 4050,Screen Size: 40.6 cm (16\") diagonal 2.8K display,Memory and storage: 32 GB memory 1 TB SSD storage'),
('HP Envy x360', 'HP', 'Laptops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/c/0/c08891498-touch.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/e/n/envy-x360-14-thompson-blue-annotated-img-ports_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/e/n/envy-x360-14-thompson-blue-annotated-img-features_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/e/n/envy-x360-14-thompson-blue-annotated-img-dimensions_1.png', 1599.00, 100, 'Brand: HP,Processor: Intel® Core™ Ultra 7 155U,Graphics: Intel® Graphics,Screen Size: 14\" diagonal 2.8K OLED touch display,Memory and storage: 16 GB memory; 1 TB SSD storage,Operating system: Windows 11 Home'),
('HP ProBook 440', 'HP', 'Laptops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/7/a77nspt-u85zfe_bundle.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/p/r/probook-440-14-g11-olaf14-intel-en-ports.jpg,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/p/r/probook-440-14-g11-olaf14-en-dimension.jpg,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/7/a77nspt_2.png', 1839.00, 150, 'Brand: HP,Processor: Intel® Core™ Ultra 7 258V,Graphics: Intel® Arc™ Graphics,Screen Size: 14\" diagonal 2.8K OLED touch display,Memory and storage: 1 TB SSD storage,Operating system: Windows 11 Home'),
('HP OmniBook Ultra Next Gen AI PC', 'HP', 'Laptops', 'https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c09038282.png?impolicy=Png_Res,https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c09053701.png?impolicy=Png_Res,https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c09039679.png,https://ssl-product-images.www8-hp.com/pub/msc/A5320D92-041C-9371-2F32-816F4E19AAB7.png?impolicy=Png_Res', 1994.47, 100, 'Brand: HP,Processor: Intel® Core™ Ultra 5 226V (up to 4.5 GHz & 8 MB L3 cache),Storage: 512 GB PCIe® Gen4 NVMe™ M.2 SSD,Display: 14" diagonal 2.8K (2880 x 1800) OLED multitouch-enabled,Operating system: Windows 11 Home'),
('ASUS Zenbook 14', 'ASUS', 'Laptops', 'https://m.media-amazon.com/images/I/61sOPUk8FNL._AC_SL1300_.jpg,https://m.media-amazon.com/images/I/41APu5f9kpL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/41QZGjGXUNL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/51oOD+rqcpL._AC_SX679_.jpg', 1117.00, 300, 'Brand: ASUS,Model:	Zenbook,Screen size: 14 Inches,Colour:	Jasper Gray,Hard disk size:	1 TB,CPU model:	Others,Installed RAM memory size:	8 GB,Operating system: Windows 11 Pro'),
('ASUS VivoBook 14', 'ASUS', 'Laptops', 'https://m.media-amazon.com/images/I/71vKxjA8dsL.__AC_SX300_SY300_QL70_ML2_.jpg,https://m.media-amazon.com/images/I/719w3YHnTiL._AC_SL1500_.jpg,https://m.media-amazon.com/images/I/61tjM7DhZ0L._AC_SL1500_.jpg,https://m.media-amazon.com/images/I/51UVsr0gyjL._AC_SL1500_.jpg', 561.00, 180, 'Brand: ASUS,Model name:	5Z8N,Screen size: 14 Inches,Colour: Blue,Hard disk size: 512 GB,CPU model: Core i3 Family,Installed RAM memory size: 16 GB,Operating system: Windows 11 Home'),
('ASUS Chromebook Plus CX34', 'ASUS', 'Laptops', 'https://m.media-amazon.com/images/I/61MWHGFXhIL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81bOqPWqWoL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81xBii4PHjL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/71-tUFSa+7L._AC_SX679_.jpg', 697.00, 150, 'Brand: ASUS,Model: Chromebook Plus CX34,Screen size: 14 Inches,Colour:	Pearl White,CPU model: Core i3,Installed RAM memory size:	8 GB,Operating system: Chrome OS'),
('Lenovo V14 Gen 4', 'Lenovo', 'Laptops', 'https://m.media-amazon.com/images/I/81HBC8P2a1L._AC_SX679_.jpg,https://m.media-amazon.com/images/I/51JoK-2OjqL._AC_US40_.jpg,https://m.media-amazon.com/images/I/710zdvED8IL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/81m-7FRpepL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/71C3UKdrtiL._AC_SX679_.jpg', 545.00, 120, 'Brand: Oemgenuine,Model name: V14 G4,Screen size: 14 Inches,Colour: Black,Hard disk size: 256 GB,CPU model: AMD Ryzen 5 5500U,Installed RAM memory size: 16 GB,Operating system: Windows 11 Pro'),
('Lenovo IdeaPad 3', 'Lenovo', 'Laptops', 'https://m.media-amazon.com/images/I/6183YBeJJFL._AC_SX679_.jpg,https://p4-ofp.static.pub//fes/cms/2024/09/13/wphiy4ngf8k0difkybwyc3jm9p77so192300.png,https://p3-ofp.static.pub//fes/cms/2024/09/13/69tv7fvrb59q6gssfu8psvwmf4kc4h674190.png,https://p1-ofp.static.pub//fes/cms/2024/09/13/xi9zr0uxa158ui2ig1jud8s2ndnbvu676089.png', 583.00, 250, 'Brand: Lenovo.Model:	15ITL6,Screen size: 15.6 Inches,Colour:	Grey,Hard disk size:	1 TB,CPU model:	Core i3 Family,Installed RAM memory size:	24 GB,Operating system:	Windows 11 Home'),
('Lenovo Thinkbook 16 Ultra 7', 'Lenovo', 'Laptops', 'https://m.media-amazon.com/images/I/81k6SvHC23L._AC_SX679_.jpg,https://m.media-amazon.com/images/I/51lha6kezzL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/61LDY-coQsL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/51oteyCWzmL._AC_SX679_.jpg', 1589.00, 340, 'Brand: Lenovo,Model: ThinkBook,Screen size: 16Inches,Colour:	ArcticGrey,Hard disk size:	1TB,CPU model:	Intel Corei5,Installed RAM memory size:	16GB,Operating system: Windows 11 Pro'),
('Lenovo Legion Slim 5', 'Lenovo', 'Laptops', 'https://m.media-amazon.com/images/I/61cGV9ATZxL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/61j9iSNXCSL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/61IWXjT9sKL._AC_SL1500_.jpg,https://m.media-amazon.com/images/I/51X+4Xmm4ZL._AC_SL1097_.jpg', 1646.00, 200, 'Brand:	Lenovo,Model:	Slim 5,Screen size:	16 Inches,Hard disk size:	512 GB,CPU model:	AMD Ryzen 7,Installed RAM memory size:	16 GB,Operating system: Windows 11 Home'),
('Dell Vostro 3000 Series ', 'Dell', 'Laptops', 'https://m.media-amazon.com/images/I/71R2LA5tZJL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/71+wCbHlOqL._AC_SX679_.jpg,https://m.media-amazon.com/images/I/810dQSR2V3L._AC_SX679_.jpg,https://m.media-amazon.com/images/I/61b-R-Rtk7L._AC_SX679_.jpg', 1294.00, 180, 'Brand: Dell,Model name:	Vostro,Screen size:	15.6 Inches,Hard disk size:	2 TB,CPU model:	Intel Core i7,Installed RAM memory size:	64 GB,Operating system: Windows 11 Pro'),
('Samsung Galaxy S24 Ultra', 'Samsung', 'Phones', 'https://www.courts.com.sg/media/catalog/product/i/p/ip191206_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip191206_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip191206_04.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip191206_05.jpg', 2300.00, 50, 'Brand: Samsung,Model: Galaxy S24 Ultra,Screen size: 6.8 Inches,Colour: Titanium Violet,Storage: 1 TB,CPU model: Snapdragon 8 Gen 2,Installed RAM memory size: 12 GB,Operating system: Android'),
('Samsung Fold 6', 'Samsung', 'Phones', 'https://www.courts.com.sg/media/catalog/product/i/p/ip195957_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195957_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195957_07.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195957_08.jpg', 2578.00, 60, 'Brand: Samsung,Model: Fold 6,Screen size: 7.6 Inches,Colour: Navy,Storage: 512 GB,CPU model: Snapdragon 8 Gen 3,Installed RAM memory size: 12 GB,Operating system: Android'),
('Apple iPhone SE (3rd Gen)', 'Apple', 'Phones', 'https://www.istudiosg.com/cdn/shop/files/IMG-4611765_1e68d98b-5e0e-4d19-ad58-f35b9d867b54.jpg,https://www.istudiosg.com/cdn/shop/files/IMG-4611766_823fcfcd-7d02-409a-aa10-fddabf31225d.jpg,https://www.istudiosg.com/cdn/shop/files/IMG-4611768_efa77b6f-a607-4815-a6b5-b50b936eaa21.jpg,https://www.istudiosg.com/cdn/shop/files/IMG-4611767_11ae56ef-c764-46d5-9049-8c7fa1d223bf.jpg', 899.00, 120, 'Brand: Apple,Model: iPhone SE (3rd Gen),Screen size: 4.7 Inches,Colour: Midnight,Storage: 256 GB,CPU model: A15 Bionic,Installed RAM memory size: 4 GB,Operating system: iOS'),
('ASUS M3700', 'Asus', 'Desktops', 'https://dlcdnwebimgs.asus.com/gain/2be09598-c6b5-4bc1-bf4f-ff16dc3c1fdb/w800,https://dlcdnwebimgs.asus.com/gain/0a728bd0-5e74-47e4-852d-d53278bdc198/w800,https://dlcdnwebimgs.asus.com/gain/20a5c952-37ca-49c1-86c1-aab270731cda/w800,https://m.media-amazon.com/images/I/71JSqxcxEBL._AC_SL1500_.jpg', 1512.00, 50, 'Brand: ASUS,Model: M3700,Processor: AMD Ryzen 5000,Graphics: AMD Radeon Graphics,Memory: 16 GB,Storage: 1 TB SSD,Operating System: Windows 11 Home'),
('ASUS M3702WFA', 'Asus', 'Desktops', 'https://dlcdnwebimgs.asus.com/gain/20df81ca-1bb5-4f65-903d-3109d702f14b/w800,https://dlcdnwebimgs.asus.com/gain/c002dafe-6687-4b71-8ef4-7ed8897e61db/w800,https://dlcdnwebimgs.asus.com/gain/3ada58ad-51c5-4842-8a25-abe202b16f52/w800,https://dlcdnwebimgs.asus.com/gain/0afbd767-5120-48fc-b800-ed1bd7522694/w800', 1399.00, 140, 'Brand: ASUS,Model: M3702WFAK-BPE045W,Processor: AMD Ryzen 5 7520U Mobile Processor,Graphics: AMD Radeon Graphics,Memory: 16 GB,Storage: 1 TB SSD,Operating System: Windows 11 Home'),
('HP Victus 15L', 'HP', 'Desktops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/4/a44rdpa-bundle.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/4/a44rdpa_1_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/4/a44rdpa_3_1.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/a/4/a44rdpa_2_1.png', 1999.00, 30, 'Brand: Victus by HP, Model: TG02-2000d PC,Processor: 14th Gen Intel Core i5,Graphics: NVIDIA GeForce RTX 4060,Memory: 16 GB,Storage: 1 TB SSD,Operating System: Windows 11 Home'),
('HP OMEN 35L', 'HP', 'Desktops', 'https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/A/W/AW4A5PA-1_T1726549403.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/A/W/AW4A5PA-2_T1726549404.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/A/W/AW4A5PA-3_T1726549405.png,https://sg-media.apjonlinecdn.com/catalog/product/cache/74c1057f7991b4edb2bc7bdaa94de933/c/0/c09013485.png', 3399.00, 20, 'Brand: OMEN by HP, Model: GT16-0048d PC,Processor: 14th Gen Intel Core i7,Graphics: NVIDIA GeForce RTX 4070,Memory: 32 GB,Storage: 1 TB SSD,Operating System: Windows 11 Home'),
('Alienware Aurora R16', 'Dell', 'Desktops', 'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/desktops/alienware-desktops/alienware-aurora-r16/media-gallery/liquid/desktop-aw-r16-bk-lqd-cooling-gallery-3.psd,https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/desktops/alienware-desktops/alienware-aurora-r16/media-gallery/liquid/desktop-aw-r16-bk-lqd-cooling-gallery-2.psd,https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/desktops/alienware-desktops/alienware-aurora-r16/media-gallery/liquid/desktop-aw-r16-bk-lqd-cooling-gallery-1.psd,https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/desktops/alienware-desktops/alienware-aurora-r16/media-gallery/liquid/desktop-aw-r16-bk-lqd-cooling-gallery-4.psd',2400.00, 50, 'Brand: Alienware by Dell, Model: R16 Gaming Desktop,Processor: 14th Gen Intel Core i7,Graphics: NVIDIA GeForce RTX 4060,Memory: 16 GB,Storage: 1 TB SSD,Operating System: Windows 11 Home'),
('Dell Precision 3680 Tower', 'Dell', 'Desktops', 'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/workstations/fixed-workstations/precision/pr3680/media-gallery/desktop-precision-pr3680-bk-gallery-1.psd,https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/workstations/fixed-workstations/precision/pr3680/media-gallery/desktop-precision-pr3680-bk-gallery-2.psd,https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/workstations/fixed-workstations/precision/pr3680/media-gallery/desktop-precision-pr3680-bk-gallery-3.psd,https://rootitsupport.com/userfiles/Precision-3680-3.png',1800.00, 50, 'Brand: Dell, Model: Precision 3680,Processor: 14th Gen Intel Core i5,Graphics: Intel Integrated Graphics,Memory: 16 GB,Storage: 256 GB,Operating System: Windows 11 Pro'),
('Lenovo Yoga Tab 11', 'Lenovo', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip173381_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip173381_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip173381_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip173381_06.jpg', 560.00, 160, 'Screen Size: 11 2k Ips Tddi,Screen Technology: Dolby Vision,Camera Effective Pixels: Front 8.0mp; Rear 8.0mp,Warranty: 1 Year,Weight: 650g,Operating System: Android 11,Processor Model: Mediatek Helio G90t'),
('Apple iPad Air 5th Gen', 'Apple', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip194107_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194107_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194107_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194107_04.jpg', 899.00, 160, 'Screen Size: 11 Inch Liquid Retina Display,Graphics Processor: 10-Core Gpu,Camera Effective Pixels: 12mp Wide Camera,Warranty: 1 Year,Weight: 462g,Operating System: Ipad Os 17,Processor Model: Apple M2 Chip'),
('Samsung Galaxy Tab A9', 'Samsung', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip189851_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip189851_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip189851_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip189851_03.jpg', 251.00, 100, 'Screen Size: 8.7 Inch Wuxga+ (1430 X 800),Dimensions: 211.0 X 124.7 X 8.0mm,Main Memory: 4gb + 64gb,Warranty: 1 Year,Weight: 332,Operating System: Android 11,Processor Model: Mediatek (mt8781)'),
('Lenovo Tab M11', 'Lenovo', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip192298_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192298_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192298_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192298_04.jpg', 339.00, 60, 'Screen Size: 11 Inch Wuxga+ (1920 X 1200) Tft,Graphics Processor: Integrated Arm MalI-G52 Mc2,Internal Storage: 128gb,Main Memory: 4gb,Weight: 465g,Operating System: Android 13,Processor Model: Mediatek Helio G88 2.0ghz'),
('Samsung Galaxy Tab S6 Lite', 'Samsung', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip197342_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip197342_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip197342_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip197342_03.jpg', 610.00, 160, 'Screen Size: 10.4 Inch Wuxga+ (2000 X 1200) Tft,Camera Effective Pixels: Front 5.0mp; Rear 8.0mp,Warranty: 1 Year,Weight: 467g,Operating System: Android 14,Processor Model: Exynos 1280 2.4ghz'),
('Samsung Galaxy Buds FE Graphite', 'Samsung', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip188176_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip188176_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip188176_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip188176_02.jpg', 159.00, 150, 'Key Features: Noise Control (anc & Ambient Sound),Battery Life: 4/14 Hours Tlk Time/buds,Key Features (1): Robust Call Quality / Enriched Bass Sound,Key Features (2): Comfortable & Secure Fit / Easy Grip & Easy Touch,Warranty: 1 Years,Weight: EarbudS-5.6g / CradlE-40g,Key Features (3): Long Last Play Time 30 Hours'),
('Apple Airpods 3rd Gen', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip172829_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip172829_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip172829_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip172829_04.jpg', 274.00, 50, 'Battery Life: Up To 6 Hours,Dimensions (w X H X d): 54.40mmx46.40mmx21.38mm,Warranty: 1 Year,Weight: 37.91g'),
('Apple Airpods Max', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip198711_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198711_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198711_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198711_08.jpg', 749.00, 50, 'Connectivity: Bluetooth 5.0 Wireless technology,Key Features: Up To 20 Hours Of Listening Time,High-Fidelity Audio and Pro-Level ANC,Weight: 386.2g'),
('Asus ROG Falchion M603', 'Asus', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip196825_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196825_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196825_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196825_04.jpg', 289.00, 20, 'Connectivity: Usb 2.0 (Typec To Typea), Bluetooth 5.1 / Rf 2.4ghz,Dimensions: 306 X 110 X 26.5 mm,Compact, 65% Gaming Keyboard,Warranty: 2 Years,Weight: 595g Without Cable'),
('Asus ROG Azoth M701', 'Asus', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip196820_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196820_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196820_04.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip196820_03.jpg', 429.00, 20, 'Connectivity: Usb 2.0 (Typec To Typea), Bluetooth 5.1 / Rf 2.4ghz,Dimensions: 326 X 136 X 40 mm,Custom Keyboard With 75 Keyboard Form Factor,Warranty: 2 Years,Weight: 1186g Without Cable'),
('Apple AirTag', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip167719_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip167719_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip167719_05.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip167719_09.jpg', 45.00, 150, 'Connectivity: Bluetooth For Proximity Finding, Apple-Designed U1 Chip For Ultra Wideband And Precision Finding, Nfc Tap For Lost Mode,A One-Tap Setup Instantly Connects Your Airtag, Weight: 11g'),
('Apple Magsafe Charger (1M)', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip198717_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198717_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198717_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198717_04.jpg', 59.00, 150, 'Makes Wireless Charging A Snap,Perfectly Aligned Magnets Attach To Your iPhone 12 Or Later,Faster Wireless Charging Up To 25w,Wirelessly Charge Airpods With Wireless Charging Case'),
('Apple 35W Dual USB-C Power Adapter', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip192613_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192613_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192613_02.jpg', 85.00, 150, 'Charge Two Devices At The Same Time, Whether You’re At Home; In The Office Or On The Go,Apple Recommends Using It With Macbook Air, Can Also Be Used With iPhone or iPad; Apple Watch and Airpods'),
('Apple 20W USB-C Power Adapter', 'Apple', 'Accessories', 'https://www.courts.com.sg/media/catalog/product/i/p/ip192611_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192611_01.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip192611_02.jpg', 30.00, 150, 'Offers Fast Efficient Charging At Home; In The Office Or On The Go,Pair It With iPhone 8 Or Later For Fast Charging - 50 Percent Battery In Around 30 Minutes,Pair It With iPad Pro And iPad Air For Optimal Charging Performance, Compatible With Any UsB-C Enabled Device');

INSERT INTO Products (ProductName, Brand, Category, Image_url, Price, Stock, Specs, UploadedAt) VALUES
('Apple iPhone 16 Pro Max', 'Apple', 'Phones', 'https://www.courts.com.sg/media/catalog/product/i/p/ip198704_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198704_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198704_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip198704_07.jpg', 2499.00, 80, 'Brand: Apple,Model: iPhone 16 Pro Max,Screen size: 6.9 Inches,Colour: Desert Titanium,Storage: 1 TB,CPU model: A18 Pro Chip,Installed RAM memory size: 12 GB,Operating system: iOS', TIMESTAMP("2024-11-09")),
('Apple iPhone 16', 'Apple', 'Phones', 'https://down-sg.img.susercontent.com/file/sg-11134301-7rdx4-m014vsvi1vf9d3@resize_w900_nl.webp,https://down-sg.img.susercontent.com/file/sg-11134301-7rdyo-lzzra1nolxg4ec@resize_w900_nl.webp,https://down-sg.img.susercontent.com/file/sg-11134301-7rdwg-lzzrshocwbvnc0@resize_w900_nl.webp,https://down-sg.img.susercontent.com/file/sg-11134301-7rdwy-lzzrshryr26042@resize_w900_nl.webp', 1449.00, 100, 'Screen Size: 6.1-Inch (diagonal) AlL-Screen Oled display,Screen Technology: Super Retina Xdr Display,Camera Effective Pixels: Rear: 48mp+12mp+12mp; Front: 12mp,Warranty: 1 Year,Weight: 170g,Operating System: Ios 18,Processor Model: A18 chip', TIMESTAMP("2024-11-09")),
('Apple 2024 MacBook Air', 'Apple', 'Laptops', 'https://m.media-amazon.com/images/I/71-D1xCuVwL.jpg,https://down-sg.img.susercontent.com/file/sg-11134207-7rcbs-lss77touv6yb7d.webp,https://down-sg.img.susercontent.com/file/sg-11134207-7rcdd-lss77tov0t8360@resize_w900_nl.webp,https://down-sg.img.susercontent.com/file/sg-11134207-7rce5-lss77touy03776@resize_w900_nl.webp', 1500.00, 100, 'Screen Size: 13.6\" (2560 X 1664) Retina, Battery Life: Go All Day With Up To 18 Hours Of Battery Life,Dimensions (w X H X d): 1.13(h) X 30.41(w) X 21.5(d) cm,Speaker(s): FouR-Speaker Sound System',TIMESTAMP("2024-11-08")),
('Samsung Galaxy Z Flip 6', 'Samsung', 'Phones', 'https://www.courts.com.sg/media/catalog/product/i/p/ip195951_08.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195951_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195951_07.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip195951_05.jpg', 1700.00, 45, 'Brand: Samsung,Model: Galaxy Z Flip 6,Screen size: 6.7 Inches,Colour: Mint,Storage: 256 GB,CPU model: Snapdragon 8 Gen 3,Installed RAM memory size: 8 GB,Operating system: Android', TIMESTAMP("2024-11-09")),
('Apple iPad Pro (2024)', 'Apple', 'Tablets', 'https://www.courts.com.sg/media/catalog/product/i/p/ip194171_00.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194171_02.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194171_03.jpg,https://www.courts.com.sg/media/catalog/product/i/p/ip194171_04.jpg', 1499.00, 100, 'Screen Size: 11 Inch Ultra Xdr Display,Graphics Processor: 10-Core Gpu,Camera Effective Pixels: 12mp Wide Camera,Warranty: 1 Year,Weight: 444g,Operating System: Ipad Os 17,Processor Model: Apple M4 Chip', TIMESTAMP("2024-11-08"));
