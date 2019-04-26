
-- Bài thực hành Lab 09
CREATE DATABASE BKShop
GO
USE BKShop
GO
-- Thực hiện tạo bảng giao dịch rút tiền
CREATE TABLE giao_dich_khachhang(
id int IDENTITY(1,1) PRIMARY KEY,
ten_kh nvarchar(64),
so_tien_rut int
)
-- Thêm dữ liệu
INSERT INTO giao_dich_khachhang(ten_kh, so_tien_rut) VALUES
('minhvt', 1500),
('nangdv', 2700),
('ngoc trinh', 3800)
-- Truy vấn
SELECT * FROM giao_dich_khachhang

-- Tạo 1 trigger: yêu cầu khi thực hiện rút tiền không vượt
-- quá 5000
ALTER TRIGGER KiemTra_SoTienRut
ON giao_dich_khachhang 
FOR INSERT
AS
	IF (SELECT so_tien_rut FROM INSERTED) > 5000
	BEGIN
		PRINT N'Số tiền rút không được vượt quá 5000'
		ROLLBACK TRANSACTION
	END

INSERT INTO giao_dich_khachhang(ten_kh, so_tien_rut) VALUES
('minhvt', 5555)

ALTER TABLE giao_dich_khachhang
ADD ngay_gd DATETIME


-- Tạo trigger cập nhật ngày giao dịch không được lớn hơn 
-- ngày hiện tại
CREATE TRIGGER kiemTra_ngay_gd
on giao_dich_khachhang
FOR UPDATE
AS
	IF(SELECT ngay_gd FROM INSERTED) > GETDATE()
	BEGIN
		PRINT N'không thể cập nhập ngày giao dịch trong tương la'
		ROLLBACK TRANSACTION
	END

INSERT INTO giao_dich_khachhang(ten_kh, so_tien_rut, ngay_gd)
VALUES ('minhvt', 4200, '2016-04-08') -- Insert vẫn được

SELECT * FROM giao_dich_khachhang

UPDATE giao_dich_khachhang
SET ngay_gd = '2020-01-02'
WHERE id = 6

-- Tạo trigger không cho cập nhập cột rút tiền
CREATE TRIGGER k_rut
ON giao_dich_khachhang
FOR UPDATE
AS
	IF UPDATE(so_tien_rut)
	BEGIN
		PRINt N'LẬY THÁNH ĐÒI HACH À'
		ROLLBACK TRANSACTION
	END

UPDATE giao_dich_khachhang
SET so_tien_rut = 200
WHERE id = 6

-- tạo trigger không cho xoá giao dịch có id = 6
CREATE TRIGGER KKK
ON giao_dich_khachhang
FOR DELETE
AS
IF 6 IN (SELECT id FROM DELETED)
	BEGIN
		PRINT N'KHÔNG XOÁ GIAO DỊCH NÀY'
		ROLLBACK TRANSACTION
	END

DELETE giao_dich_khachhang
WHERE giao_dich_khachhang.id = 6

-- tạo trigger đếm số bản ghi đã xoá
CREATE TRIGGER count_ban_ghi_deleted
ON giao_dich_khachhang
FOR DELETE
AS
	BEGIN
		DECLARE @soBanGhi int;
		SELECT @soBanGhi = (SELECT COUNT(*) FROM DELETED);
		PRINT N'số bản ghi đã xoá là ' + convert(varchar(100), @soBanGhi);
	END

	-- Lệnh xóa
DELETE giao_dich_khachhang
WHERE giao_dich_khachhang.id > 0 AND giao_dich_khachhang.id < 3

-- Xem cú pháp tạo trigger
EXEC sp_helptext 'count_ban_ghi_deleted'

-- Tạo bảng Phòng Ban
CREATE TABLE PhongBan(
id_pb int PRIMARY KEY,
ten_pb nvarchar(128)
)
GO
-- Tạo bảng Nhân Viên
CREATE TABLE NhanVien(
id_nv int PRIMARY KEY,
id_pb int FOREIGN KEY REFERENCES PhongBan(id_pb),
ten_nv nvarchar(128)
)
GO
INSERT INTO PhongBan VALUESb   
(1,'Phong ke toan'),
(2,'Hanh chinh TH'),
(3,'Phong ky thuat')
GO
INSERT INTO NhanVien VALUES
(1, 1, 'Vu Tuan Minh'),
(2, 1, 'Nguyen Cong Phuong'),
(3, 3, 'Pham Van Mach')
GO

-- TẠO trigger khi xoá  id của phòng ban thì xoá luôn id của nhân viên
ALTER TRIGGER Xoa
ON PhongBan
INSTEAD OF DELETE -- nó sẽ được thực thi trước khi ràng buộc được sẩy ra
AS
	BEGIN
		DELETE NhanVien
		WHERE NhanVien.id_pb in
		(SELECT id_pb FROM deleted)
	END

-- Thực hiện xóa dữ liệu có ràng buộc
DELETE PhongBan
WHERE id_pb = 1

SELECT * FROM NhanVien
SELECT * FROM PhongBan