CREATE DATABASE bai5
go

USE bai5
go

CREATE TABLE TblClass (
	Id INT IDENTITY,
	Name NVARCHAR(100) NOT NULL,
	Created date NOT NULL default(GETDATE())
)
GO

ALTER TABLE TblClass 
add PRIMARY KEY(Id)
go

CREATE TABLE TblStudent (
	Id INT PRIMARY KEY IDENTITY,
	Name nvarchar(100)  null,
	Email nvarchar(100) UNIQUE
)
GO

ALTER TABLE TblStudent 
ADD ClassID INT FOREIGN KEY REFERENCES TblClass(Id)
GO

CREATE TABLE TblSubject (
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(100) UNIQUE
)
GO

CREATE TABLE TblMark (
	SubjectId int FOREIGN KEY REFERENCES TblSubject(Id),
	StudentId int FOREIGN KEY REFERENCES TblStudent(Id),
	MarkNumber INT NOT NULL
)
GO

-- viết câu lệnh tạo index trên cột name của bảng tblSuject
CREATE INDEX  ui_name
on TblSubject(Name)
go
-- thêm mới dữ liệu
INSERT INTO TblClass(Name)
VALUES('C1807I1'),('C1809J2'),('C1703I1')
GO

INSERT INTO TblStudent(Name, Email, ClassID)
VALUES('Tòng Thị Phóng', 'phong@gmail.com', 1),
('Quang Trung', 'trung@gmail.com', 2),
('Son Tung', 'tung@gmail.com', 3),
('Dang the Ha', 'Ha@gmail.com', 1),
('The Nam', 'Nam@gmail.com', 3)
go

INSERT INTO TblSubject(NAME) 
VALUES (N'Toán'), (N'lý'), (N'Hoá')

INSERT INTO TblMark(StudentId, SubjectId, MarkNumber)
VALUES(1,2,6), (2,1,7), (3,1,9), (4,3,6), (3,3,6)
GO


--viết câu lệnh view hiển thị thông tin sinh viên gồm có Id, name , email, lớp
CREATE VIEW uv_infoStudent
as
SELECT * FROM TblStudent
go

select * FROM TblStudent
-- tạo view hiển thị thông tin điểm tring bình của sinh viên gồm có: id, name, Email, điểm trung bình
CREATE VIEW UV_diem
as
SELECT S.Id, S.Name,S.Email, AVG(M.MarkNumber) as avg FROM TblStudent S 
JOIN TblMark M ON S.Id = M.StudentId
group by s.Id, s.Name, s.Email
go


-- tạo thủ tục sp_addStudent thực hiện thêm mới sinh viên gồm các tham số sau @name, @Email, @classID.
CREATE PROC sp_addStudent
@Name nvarchar(100),
@Email nvarchar(100),
@class nvarchar(100)
AS
BEGIN
	INSERT INTO TblStudent(Name, Email, ClassID)
	VALUES(@Name, @Email, @class)
END

EXEC sp_addStudent N'Hoàng Quốc Việt', 'Viet@gmail.com', '2'
go

-- tạo thủ tục sp_getStudentInfoById hiển thị thông tin sinh viên theo Id gồm có tham số đầu vào là @StudentId, khi thực thi
-- thì kết quả in ra màn hình thông tin sinh viên gôm có: id, name, email, lớp
CREATE PROC sp_getStudentInfoById
@StudentId nvarchar(100)
AS
BEGIN
	SELECT S.Name, S.Email, S.ClassID FROM TblStudent S
	WHERE S.Id = @StudentId
END

-- tạo trigger khi thêm mới điểm của sinh viên thì không cho phép nhâp điểm <0 hoặc >10,
-- nếu cố tình nập điểm <0 thì hiển thị, điểm của sinh viên phải >= 0 và <=10

create trigger ut_checkmarK
on TblMark for INSERT
AS
BEGIN 
	IF(SELECT MarkNumber from inserted) < 0  or (SELECT MarkNumber from inserted) > 10
		BEGIN 
			PRINT N'chỉ được nhập < 0 và lớn hơn 10'
			ROLLBACK TRANSACTION
		END
END

-- tạo view hiển thị thông tin của sinh viên như câu 6 trong đó xép loại như sau
-- 0-5 yếu, >5 TB, 6.5 <= 7.5 khá, >7.5 giỏi, >8 xuất sắc








