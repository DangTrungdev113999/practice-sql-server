CREATE DATABASE QUANLYBANHANG
GO

USE QUANLYBANHANG
GO

-- Tạo bảng danh mục sản phẩm
CREATE TABLE CATELOG(
CatelogId INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính,kiểu INT, tự tăng
CatelogName NVARCHAR(50) NOT NULL, -- Không được đểtrống
Status TINYINT DEFAULT(1) -- Mặc định dữ liệu là 1
)
GO


INSERT INTO CATELOG(catelogName,status)
VALUES (N'Giâỳ cao gót',1),
(N'Giầy vải',1),
(N'Giầy convert',1)
GO 

INSERT INTO CATELOG (CatelogName) VALUES
(N'Giày nam'),
(N'Giày cao'),
(N'Ủng cao su'),
(N'Bốt nữ cao'),
(N'Bốt nữ da')
GO


-- Tạo bảng SAN_PHAM
CREATE TABLE PRODUCT(
ProductId INT IDENTITY(1,1) PRIMARY KEY, -- Khóa chính
CatelogId INT FOREIGN KEY REFERENCES CATELOG(CatelogId),
ProductName NVARCHAR(200) NOT NULL, -- Không để trống
Content NVARCHAR(250),
ContentDetail NTEXT,
PriceInput FLOAT NOT NULL DEFAULT(0), -- Không để trống, mặc định là 0
 PriceOutput FLOAT NOT NULL DEFAULT(0), -- Không để trống, mặc định là 0
Views INT NOT NULL DEFAULT(0), -- Không để trống, mặc định là 0
Created DATETIME CHECK(Created >= GETDATE()), -- Kiểm tra giá trị nhập luôn >= ngày hiện tại
Status TINYINT CHECK(Status = 0 OR Status = 1) DEFAULT(1), -- Trạng thái chỉ có 2 giá trị 0 hoặc 1
)
GO

INSERT INTO PRODUCT(productName,content,contentDetail,
priceInput, priceOutput, views, created, status)
VALUES (N'Giầy cao gót hở mũi',N'Đây là giầy cao gót hở mũi
mới',
N'Giầy cao gót hỏ mũi đính đá hoa văn sang trọng'
,450000,470000,4,'2019-08-21',1),
(N'Giầy cao gót đế bằng',N'Đây là giầy cao gót đế bằng mới',
N'Giầy cao gót đế bằng trẻ trung'
,350000,380000,8,'2019-08-22',1),
 (N'Giầy convert cao cổ',N'Giầy convert cao cổ',
N'Giầy convert cao cổ cho nữ'
,180000,230000,6,'2019-08-22',1)
GO 

UPDATE PRODUCT SET CatelogId = 5
WHERE ProductId = 1
GO
UPDATE PRODUCT SET CatelogId = 4
WHERE ProductId = 2
GO
UPDATE PRODUCT SET CatelogId = 6
WHERE ProductId = 3
GO

INSERT INTO PRODUCT(ProductName, PriceInput,PriceOutput,
Created, CatelogId) VALUES
('Conserve Chuck 1', 600,650, GETDATE(), 1),
('Gucci SNN69', 120, 150, GETDATE(), 2),
('Adidas', 1450, 1600, GETDATE(), 1),
('Nike MG21', 690,750, GETDATE(), 3),
('Tom 300', 55, 65, GETDATE(), 3),
('Lacoste 066', 99,105, GETDATE(), 5)
GO

-- Thêm 3 cột như mô tả
ALTER TABLE PRODUCT
ADD Bar_code uniqueidentifier
GO
ALTER TABLE PRODUCT
ADD PriceUnit NVARCHAR(16)
GO
ALTER TABLE PRODUCT
ADD Img_thumb NVARCHAR(512)
GO

INSERT INTO PRODUCT(ProductName, PriceInput,PriceOutput, Created,
CatelogId, PriceUnit, Img_thumb, Bar_code) VALUES
( 'Conserve Chuck 111', 600,650, GETDATE(),
1,N'chiếc','/giaynam/cc12016sdsdf.png',NEWID()),
( 'Gucci SNN99', 120,150, '2019-07-12 14:32:15',
2,N'hộp','/giaynu/cc12016sdsdf.png',NEWID()),
( 'Adidas 123', 1450,1500, GETDATE(),
1,N'cái','/giaycao/cc12016sdsdf.png',NEWID())
GO


CREATE TABLE COLOR (
colorId INT IDENTITY(1,1) PRIMARY KEY,
colorName NVARCHAR(100) NOT NULL,
status BIT DEFAULT(1)
)
GO 

INSERT INTO COLOR(colorName,status)
VALUES (N'Màu xanh',1),
(N'Màu vàng',1),
(N'Màu trắng',1),
(N'Màu tím',1),
(N'Màu đen',1),
(N'Màu nâu',1),
(N'Màu hồng',1),
(N'Màu cam',1),
(N'Màu đỏ',1)
GO 

CREATE TABLE SIZE (
sizeId INT IDENTITY (1,1) PRIMARY KEY,
sizeName NVARCHAR(100) NOT NULL,
status BIT DEFAULT(1)
)
GO 

INSERT INTO SIZE(sizeName, status)
VALUES (N'Size 36',1),
(N'Size 37',1),
(N'Size 39',1),
(N'Size 40',1),
(N'Size 41',1),
(N'Size 41',1),
(N'Size 43',1),
(N'Size 44',1)
GO 

CREATE TABLE PRODUCTDETAILD
(
	ProductDetailId INT PRIMARY KEY IDENTITY(1,1),
	ProductId INT FOREIGN KEY REFERENCES PRODUCT(productId),
	colorId int FOREIGN KEY REFERENCES COLOR(colorId),
	sizeId int FOREIGN KEY REFERENCES SIZE(sizeId),
	quantity int not null,
	price float not null,
	status BIT DEFAULT(1)
)
GO

INSERT INTO PRODUCTDETAILD(ProductId,colorId,sizeId, quantity, price)
VALUES
(1,1,1,4,1200000),
(1,2,1,6,1300000),
(2,2,2,5,3400000),
(2,1,3,4,1700000),
(3,4,2,2,6000000),
(5,3,2,3,2300000),
(4,3,2,1,3200000)
go

CREATE TABLE BILL
(
	billId INT IDENTITY(1,1) PRIMARY KEY,
	cusId INT NOT NULL,
	productId int foreign key references PRODUCT(ProductId),
	buyingDate DATE NOT NULL,
	totalMoney FLOAT NOT NULL,
	status SMALLINT default(1),
	name NVARCHAR(100) NOT NULL,
	address NVARCHAR (250) NOT NULL,
	email VARCHAR(50) NOT NULL,
	paymentMethod SMALLINT NOT NULL,
	shippingMethod SMALLINT NOT NULL
)
GO


INSERT INTO BILL(cusId,productId ,buyingDate, totalMoney,
status, name, address, 
email, paymentMethod, shippingMethod )VALUES
(1,2,'2019-09-10',800.00,10,N'Hoàng Anh Tú',N'3/HQV quận
Cầu Giấy HN','anhtu@gmail',3,1),
(2,1,'2019-06-09',1200.00,20,N'Mai Hoa',N'8/TTT quận
Hoàn Kiếm HN','maihoa@gmail',4,0),
(3,4,'2019-07-08',989.00,10,N'Nguyễn Lâm',N'12/Nghĩa Tân
quận Cầu Giấy HN','Nlam@gmail',5,1)
GO

CREATE TABLE CUSTOMER(
cusId INT IDENTITY(1,1) PRIMARY KEY,
name NVARCHAR(128) NOT NULL,
email VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
numberPhone VARCHAR(11) NOT NULL,
birthday DATE,
sex BIT,
wardCode INT,
address NVARCHAR(250),
status BIT default(1),
)
GO

INSERT INTO CUSTOMER(name, email,
password,numberPhone, birthday, sex, wardCode,
address)VALUES
(N'HoàngAnhTú','anhtu@gmail','123456','0909879877',
'1990-09-09',1, 3 ,N'3/HQV quận Cầu Giấy HN'),
(N'Mai Hoa','maihoa@gmail','123','0901239877',
'1987-09-01', 0, 4, N'8/TTT quận Hoàn Kiếm HNN'),
(N'Nguyễn Lâm','Nlam@gmail','abc','0912379877',
'1966-11-12', 1, 5, N'12/Nghĩa Tân quận Cầu Giấy HN')
GO

CREATE TABLE BILLDETAIL(
	ID INT IDENTITY(1,1) PRIMARY KEY,
	billId INT FOREIGN KEY REFERENCES BILL(billId),
	cusId INT FOREIGN KEY REFERENCES CUSTOMER(cusId),
	price FLOAT NOT NULL,
	quantity INT NOT NULL,
	status BIT default(1),
	buyingdate DATE
)
GO

INSERT INTO BILLDETAIL(billId, cusId, price, quantity,
status, buyingdate )VALUES
(1,1,800.00,3,1,'2016-03-10'),
(1,2,800.00,1,1,'2016-03-10'),
(1,3,1600.00,2,1,'2016-03-10'),
(2,3,215.00,1,0,'2016-03-08'),
(3,1,215.00,1,0,'2016-03-08')
GO

select * from PRODUCT
select * from CATELOG
select * from PRODUCTDETAILD
select * from COLOR
select * from SIZE
SELECT * FROM BILL
SELECT * FROM CUSTOMER
select * from BILLDETAIL



-- LẤY DỮ LIỆU CATELOG VÀ SỐ SỐ SẢN PHẦM THEO CATELO
SELECT CatelogId, CatelogName FROM CATELOG
GO

SELECT C.CatelogId, C.CatelogName, COUNT(P.ProductId) FROM CATELOG C JOIN PRODUCT P
ON C.CatelogId = P.CatelogId
GROUP BY C.CatelogId, C.CatelogName
GO

-- LẤY VỀ GIÁ TRỊ TRUNG BÌNH CỦA PRICEOUPUT THEO DANH MỤC SẢN PHẨM ,NHÓM THEO CATELOGID
SELECT * FROM PRODUCT

SELECT CatelogId, AVG(PriceOutput) AS N'GIÁ TRUNG BÌNH' FROM PRODUCT
GROUP BY CatelogId
GO

-- TRUY VẤN BẢN PRODUCTDETAILD, LẤY VỀ TỔNG DANH SỐ CỦA MỖI SẢN PHẨM CHI TIẾT, THẬM CHÍ LẤY CẢ KHU VỰC KHÔNG THỎA
-- MÃN ĐIỀU KIỆN LỌC TRONG WHERE -- TÌNH HUỐNG NÀY SỬ DỤNG GROUP BY VỚ ALL
select * from BILLDETAIL
select * from BILL
select * from PRODUCTDETAILD

SELECT ProductId, SUM(quantity * price) as N'tổng tiền' FROM PRODUCTDETAILD
where ProductId < 6
group by all ProductId
go


-- lấy về các sản phẩm có giá lớn hơn 50 và có tỏng doanh thu lớn hơn 300 của ngày đó
CREATE TABLE ThongKeBanHang(
sanpham NVARCHAR(128),
giatien FLOAT,
ngayban DATE
)

-- Thêm dữ liệu
INSERT INTO ThongKeBanHang VALUES ('Nokia 1200', 100, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('Samsung Trend', 120, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('HTC One', 50, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('HTC One', 50, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('HTC One M8', 100, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('HTC One M9', 150, '2016-03-19')
INSERT INTO ThongKeBanHang VALUES ('Samsung Trend', 120, '2016-03-20')
INSERT INTO ThongKeBanHang VALUES ('Nokia 1200', 120, '2016-03-20')

select ngayban, sum(giatien) from ThongKeBanHang
where giatien > 50
group by ngayban
having sum(giatien) > 300
go

-- viết câu lệnh ứng dụng hành tổng hợp
select * from PRODUCT

select max(PriceOutput) as N'giá bán đắt nhất' from PRODUCT
go


-- lấy về thông tin đơn hàng với điều kiện ngày đặt hàng là ngày gần nhát hiện tại
select * from BILLDETAIL
where buyingdate = (
	select min(buyingdate) from BILLDETAIL
)
go

-- lấy về sản phẩm mà danh mục sản phẩm của nó là áo nam
select * from CATELOG
select * from PRODUCT

select ProductId, ProductName, CatelogId from PRODUCT
where PRODUCT.CatelogId in (
   SELECT CatelogId from CATELOG
   where CatelogName = N'Giầy vải'
)

-- lấy về những sản phẩm có mầy xanh

select * from PRODUCT
select * from PRODUCTDETAILD
select * from COLOR

select ProductId, ProductName, PriceInput, PriceOutput from PRODUCT
where ProductId in (
	select ProductId from PRODUCTDETAILD
	where colorId in (
		select colorId from COLOR
		where colorName = N'Màu xanh'
	)
)

-- tạo thủ tục

CREATE PROC A
AS
BEGIN
	SELECT * FROM PRODUCT
END

--  Thực thi thủ tục
EXEC A

--  tạo thủ tục truyền tham số
CREATE PROC getbill
@id int
AS
BEGIN
	SELECT * FROM PRODUCT
	WHERE ProductId = @id
END

EXEC getbill 3

-- tạo thủ tục có tham số đầu ra
CREATE PROC gettotal
@name NVARCHAR(50),
@sum INT OUTPUT
AS
BEGIN
	SELECT @sum = SUM(b.billId) FROM BILL  B JOIN CUSTOMER C
	ON B.cusId = C.cusId
	WHERE C.name = @name
END

-- thực thi thủ tục
DECLARE @sum INT;
EXEC gettotal 'Mai Hoa', @sum OUTPUT;
PRINT 'so luong don hang: ' + convert(varchar(100), @sum)
GO

SELECT * FROM BILL