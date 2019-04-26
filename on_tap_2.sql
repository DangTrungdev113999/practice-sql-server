CREATE DATABASE ontap_2_fix2
go

USE ontap_2_fix2
go

CREATE TABLE Product
(
	id int not null identity,
	Name nvarchar(250) not null,
	Price float ,
	Sale_price float default(0),
	type tinyint default(0),
	Quantity int default(0)
)
go

ALTER TABLE Product
add check(Price >= 30000)
go

ALTER TABLE Product
add check(Sale_price < Price)
go

ALTER TABLE Product
add check(Type = 0 or Type = 1 or Type = 2)
go

ALTER TABLE Product
add check(Quanity BETWEEN 0 AND 20)
go

INSERT INTO Product
VALUES(N'Đồng hồ nam LOBINNIRef.L16.0',6000000, 5500000 ,1 ,5),
(N'Đồng hồ nam LOBINNI Ref.L1.30.22M',8000000, 7600000 ,2 ,3),
(N'Đồng hồ nam TEINTOP T7009-5',5500000, 5000000 ,0 , 10),
(N'Đồng hồ nam Poniger P7.23-2',5600000, 5300000 ,0 ,5),
(N'Đồng hồ nam Poniger P5.19-5',12000000, 10000000 ,2 ,2),
(N'Đồng hồ nam TEINTOP T7009-1',6000000, 5500000 ,1 ,5),
(N'Đồng hồ nam LOBINNI Ref.L1.30',16000000, 15000000 ,2 ,1)
GO

-- Viết lệnh lấy ra sản phẩm có số lượng lơn nhất
SELECT *  FROM Product
WHERE Quantity in (
	select MAX(Quantity) from Product
)

-- Viết lênh lấy ra sản phẩm có giá lơn nhất
SELECT *  FROM Product
WHERE Sale_price in (
	select MAX(Sale_price) from Product
)

--Viết lệnh lấy ra sản phẩm có giá từ 5 triệu -> 7 triệu

SELECT *  FROM Product
WHERE Sale_price BETWEEN 5000000 AND 7000000  

-- Viết lệnh lấy ra tổng số lượng sản phẩm

SELECT SUM(Quantity) AS N'TONG SO LUONG SAN PHAM'  FROM Product
 
-- Viết lệnh cập nhật trường Price tăng lên 10% cho tất cả các sản phẩm có type = 1
UPDATE Product SET Price = Price + Price*0.1 WHERE type = 1

-- Viết lệnh cập nhất Sale_price lên 10% cho tất cả các sản phẩm có type = 2
UPDATE Product SET Sale_price = Sale_price + Sale_price*0.01 WHERE type = 2

-- Viết lệnh lấy ra danh sách sản phẩm giảm dần theo Price
SELECT *  FROM Product
ORDER BY Price DESC
GO

-- Viết lệnh lấy ra 3 sản phẩm có số lượng cao nhất
SELECT TOP 3 *  FROM Product
ORDER BY Quantity DESC
GO

-- Yêu cầu 2:Tạo thủ tục lấy ra thông tin sản phẩm theo type 
CREATE PROC up_selectInfoProductByType
@type tinyint
as
begin
	SELECT * FROM Product
	WHERE type = @type
end

-- Yeu cầu 3 tạo view hiển thị thông tin sản phẩm sao cho cột type nếu là 0 
-- thì là bình dân, 1 là VIP, 2 là cao cấp
create view uv_xam
as
SELECT id, Name, Price, Sale_price, Quantity, 
CASE
	WHEN type = 0 THEN N'binh dan'
	WHEN Type = 1 THEN N'VIP'
	ELSE N' cap cap'
END AS N'TYPE'
FROM Product