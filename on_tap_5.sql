use master 
GO 

DROP database ThucTap
GO

CREATE DATABASE ThucTap
GO

USE ThucTap
GO

CREATE TABLE TBLKhoa
(
	Makhoa char(10)	primary key,
	Tenkhoa char(30),
	Dienthoai char(10)
 )
GO

CREATE TABLE TBLGiangVien
(
	Magv int primary key,
	Hotengv char(30),
	Luong decimal(5,2),
	Makhoa char(10) references TBLKhoa
)
GO

CREATE TABLE TBLSinhVien 
(
	Masv int primary key,
	Hotensv char(40),
	Makhoa char(10)foreign key references TBLKhoa,
	Namsinh int,
	Quequan char(30)
)
GO

CREATE TABLE TBLDeTai
(
	Madt char(10) primary key,
	Tendt char(30),
	Kinhphi int,
	Noithuctap char(30)
)
GO

CREATE TABLE TBLHuongDan
(
	Masv int primary key,
	Madt char(10) foreign key references TBLDeTai,
	Magv int foreign key references TBLGiangVien,
	KetQua decimal(5,2)
)
GO

INSERT INTO TBLKhoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412)
GO

INSERT INTO TBLGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),     
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math')
GO

INSERT INTO TBLSinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An')
GO

INSERT INTO TBLDeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' )
GO

INSERT INTO TBLHuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6)
GO

--1. Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
SELECT GV.*, K.Tenkhoa FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
GO

--2. Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
SELECT GV.*, K.Tenkhoa FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
WHERE K.Tenkhoa = N'DIA LY va QLTN'
GO

--3 Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS N'số sinh viên khoa công nghệ sinh học' 
FROM  TBLSinhVien SV JOIN TBLKhoa K
ON SV.Makhoa = K.Makhoa
WHERE K.Tenkhoa = N'CONG NGHE SINH HOC'
GO

-- 4 Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
SELECT SV.Masv, SV.Hotensv, (YEAR(GETDATE()) - YEAR(SV.Namsinh)) AS N'TUỔI'
FROM  TBLSinhVien SV JOIN TBLKhoa K
ON SV.Makhoa = K.Makhoa
WHERE K.Tenkhoa = N'TOAN'
GO

--5 Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS N'số giảng viên khoa công nghệ sinh học' 
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
WHERE K.Tenkhoa = N'CONG NGHE SINH HOC'
GO

--6 Cho biết thông tin về sinh viên không tham gia thực tập
SELECT * FROM TBLSinhVien SV
WHERE SV.Masv NOT IN (
	SELECT HD.Masv  FROM TBLHuongDan HD
)

--7 Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT K.Tenkhoa, K.Makhoa , COUNT(GV.Magv) AS N'SỐ GIẢNG VIÊN' 
FROM TBLGiangVien GV JOIN TBLKhoa K
ON GV.Makhoa = K.Makhoa
GROUP BY K.Tenkhoa, K.Makhoa
GO

--8 Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT K.Dienthoai
FROM  TBLSinhVien SV JOIN TBLKhoa K
ON SV.Makhoa = K.Makhoa
WHERE SV.Hotensv = N'Le van son'
GO

--9 Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT HD.Madt, DT.Tendt FROM TBLGiangVien GV 
JOIN TBLHuongDan HD ON GV.Magv = HD.Magv
JOIN TBLDeTai DT ON DT.Madt = HD.Madt
WHERE GV.Hotengv = N'Tran son'
GO

--10 Cho biết tên đề tài không có sinh viên nào thực tập
SELECT DT.Madt, DT.Tendt FROM TBLDeTai DT
WHERE DT.Madt NOT IN (
	SELECT DISTINCT HD.Madt FROM TBLHuongDan HD
)
GO

--11 Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 1 sinh viên trở lên.
SELECT GV.Magv, GV.Hotengv, K.Tenkhoa FROM TBLGiangVien GV 
JOIN TBLKhoa K ON K.Makhoa = GV.Makhoa
WHERE GV.Magv IN (
	SELECT HD.Magv FROM TBLHuongDan HD
	GROUP BY HD.Magv
	HAVING COUNT(HD.Magv) > 1
)
GO

--12 Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT Madt, Tendt FROM TBLDeTai
WHERE Kinhphi IN (
	SELECT MAX(Kinhphi) FROM TBLDeTai
)
GO

--13 Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT Madt, Tendt FROM TBLDeTai
WHERE Madt IN (
	SELECT HD.Madt FROM TBLHuongDan HD
	GROUP BY HD.Madt
	HAVING COUNT(HD.Masv) > 2
)
GO
--14 Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
SELECT SV.Masv, SV.Hotensv, HD.KetQua  FROM TBLSinhVien SV
JOIN TBLKhoa K ON K.Makhoa = SV.Makhoa
JOIN TBLHuongDan HD ON HD.Masv = SV.Masv
WHERE K.Tenkhoa = N'Dia ly va QLTN'

--15 Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT K.Tenkhoa, COUNT(SV.Masv) FROM TBLKhoa K
JOIN TBLSinhVien SV ON SV.Makhoa = K.Makhoa
GROUP BY K.Tenkhoa
GO

--16 Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT * FROM TBLSinhVien SV
WHERE Masv IN (
	SELECT HD.Masv FROM TBLHuongDan HD
	JOIN TBLDeTai DT ON HD.Madt = DT.Madt
	WHERE DT.Noithuctap = SV.Quequan
)

--18 Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT * FROM TBLSinhVien SV
WHERE Masv IN (
	SELECT HD.Masv FROM TBLHuongDan HD
	WHERE HD.KetQua IS NULL
)

--19 Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT * FROM TBLSinhVien SV
WHERE Masv IN (
	SELECT HD.Masv FROM TBLHuongDan HD
	WHERE HD.KetQua = 0
)


