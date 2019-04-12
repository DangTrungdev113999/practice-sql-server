CREATE DATABASE students
go

USE students
go

CREATE TABLE Students (
	StudentID int primary key identity,
	StudentName nvarchar(100) not null,
	Age int not null,
	Email nvarchar(100) null,
)

CREATE TABLE Classes (
	ClassID int primary key identity,
	ClassName char(10) not null,
)

CREATE TABLE ClassStudent (
	ClassID int foreign key references Classes(ClassID),
	StudentID int foreign key references Students(StudentID)
)

CREATE TABLE Subjects (
	SubjectID int primary key identity,
	SubjectName nvarchar(100) not null,
)

CREATE TABLE Marks (
	SubjectID int foreign key references Subjects(SubjectID),
	StudentID int foreign key references  Students(StudentID),
	Mark int not null
)

INSERT INTO Students(StudentName, Age, Email)
values ('Nguyen Quang An', 18, 'an@gamil.com'),
('Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
('Nguyen Van Quyen', 19, 'quyen@gmail.com'),
('Pham Thanh Binh', 25, 'binh@gmail.com'),
('Pham Chi Pheo', 30, 'pheo@gmail.com')
go

INSERT INTO Students(StudentName, Age, Email)
values ('Dang Hoang An', 18, 'an'),

INSERT INTO Classes(ClassName)
VALUES ('CL506L'),( 'CL603L')
GO

INSERT INTO ClassStudent(ClassID, StudentID)
VALUES (1,1),(1,2),(2,3),(2,3),(2,5)
GO

INSERT INTO Subjects(SubjectName)
VALUES ('SQL'), ('java'), ('c'), ('visual Basic')
go

INSERT INTO Marks
VALUES (1,1,8),(2,1,4),(1,1,9),(1,3,7),(1,4,3),(2,5,5),(3,3,8),
(3,5,1),(2,4,3)
GO

-- TẠO VIEW
-- 1. Hiển thị danh sách tất cả các học viên(Danh sách phải sắp xếp theo tên học viên)
CREATE VIEW vwStudentsInfo
AS
	SELECT TOP 10 * FROM Students
	ORDER BY StudentName DESC
GO
-- 2. Hiển thị danh sách tát cả các học viên 
-- 3. Hiển thị danh sách những học viên nào có địa chỉ email chính xác
CREATE VIEW vwEmail
AS
SELECT * FROM Students
WHERE Email LIKE '%@%'
GO
-- 4. hiển thị danh sách những học viên có họ Nguyễn
CREATE VIEW vwHoNuyen
AS
SELECT * FROM Students
WHERE StudentName like '%Nguyen%'
go
-- 5. hiển thị danh sách các bạn học viên của lớ c0706L.
CREATE VIEW vwCL603L
AS
SELECT S.StudentID, S.StudentName, CS.ClassName FROM Students S 
JOIN ClassStudent C ON S.StudentID = C.StudentID
JOIN Classes CS ON CS.ClassID = C.ClassID
WHERE CS.ClassName = 'CL603L'
GO

-- 6. Hiển thị danh sách và điểm học viên ứng với môn học
CREATE VIEW vwMark
AS
SELECT S.StudentID, S.StudentName, SS.SubjectName, M.Mark
FROM Students S
JOIN Marks M ON M.StudentID = S.StudentID
JOIN Subjects SS ON SS.SubjectID = M.SubjectID
GO
-- 7. Hiển thị danh sách học viên chưa thi môn nào(chưa có điểm)
CREATE VIEW vwChuaThi
AS
SELECT S.StudentID, S.StudentName FROM students S
WHERE S.StudentID NOT IN (
	SELECT M.StudentID FROM Marks M
)
GO
-- 8. Hiển thị môn học nào chưa được học viên thi
CREATE VIEW	vwasdf
AS
SELECT * FROM Subjects S
WHERE S.SubjectID NOT IN (
	SELECT M.SubjectID FROM Marks M
)
GO
-- 9. Tính điểm trung bình cho các sinh viên.
CREATE VIEW vwAVG
AS
SELECT S.StudentID, S.StudentName, AVG(M.Mark) AS N'Điểm trung bình'
FROM students S
JOIN Marks M ON M.StudentID = S.StudentID
GROUP BY S.StudentID, S.StudentName
GO
-- 10. Hiển thị môn học nào được thi nhiều nhất.
CREATE VIEW vwMax
AS
	SELECT TOP 1 M.SubjectID, S.SubjectName, COUNT(M.SubjectID) FROM Marks M
	JOIN Subjects S ON S.SubjectID = M.SubjectID
	GROUP BY M.SubjectID, S.SubjectName
	ORDER BY COUNT(M.SubjectID) DESC
GO

-- 11. Hiển thị môn học nào có thí sinh thi được điểm cao nhất.
CREATE VIEW vwMax1
AS
SELECT S.*, MAX(M.Mark) AS MAX FROM Subjects S
JOIN Marks M ON M.SubjectID = S.SubjectID
GROUP BY S.SubjectID, S.SubjectName
GO
-- 12. Hiển thị môn học nào có nhiều điểm dưới trung bình nhất (<5)
SELECT TOP 1 S.*, COUNT(M.Mark) FROM Marks M
JOIN Subjects S ON S.SubjectID = M.Mark 
GROUP BY S.SubjectID, S.SubjectName
ORDER BY COUNT(M.Mark)
GO


-- tẠO RÀNG BUỘC

-- 1 viết check Constaint để kiểm tra độ tuổi nhập vào trong bảng Student yêu caafuu Age > 15 và Age < 50
ALTER TABLE students
ADD CHECK( Age BETWEEN 15 AND 50)
GO
-- 2 Loại bỏ quan hệ giữa các bảng.
-- 3 Xoá học viên có StudentID là 1.
-- 4 Trong bảng Student thêm một column Status có kiểu dữ liệu là Bit và có giá trị default là 1
ALTER TABLE students
ADD status BIT DEFAULT(1)
GO
SELECT * FROM Students
-- 5. Cập nhật giá trị Status trong bảng Student là 1.
UPDATE students
SET status = 1
GO
-- TẠO THỦ TỤC.
-- 1. Thủ tục nhận tham số là StudentID và hiển thị điểm từng môn học của học sinh này
ALTER PROC DIEM
@ID INT
AS
BEGIN
	SELECT S.StudentID, S.StudentName, SS.SubjectName, M.Mark FROM Students S
	JOIN Marks M ON M.StudentID = S.StudentID
    JOIN Subjects SS ON SS.SubjectID = M.SubjectID
	WHERE S.StudentID = @ID
END

EXEC DIEM 1
-- 2. Thủ tục nhận tham số là subjectID, thực hiện cập nhật toàn hộ điểm của sinh viên trong môn học này về 0
CREATE PROC MON111
@ID INT
AS
BEGIN
	UPDATE Marks
	SET Mark = 0
	WHERE SubjectID = @ID
END

exec MON111 1

SELECT * FROM Marks

-- 3. Tạo thủ tục nhận tham số đầu vào là StudentID, subjectID và hiển thị điểm môn học của sinh viên này.
CREATE PROC ABC
 @StuID int, @subID int
AS 
BEGIN
	SELECT S.StudentID, S.StudentName, SS.SubjectName, M.Mark FROM students S
	JOIN Marks M ON M.StudentID = S.StudentID
	JOIN Subjects SS ON SS.SubjectID = M.SubjectID
	WHERE S.StudentID = @StuID AND SS.SubjectID = @subID
END

EXEC ABC 1,2

--TẠO TRIGGER
--1. Trigger thực hiện khi xoá Student thì xoá toàn bộ thông tin tương ứng ở các bảng khác
CREATE TRIGGER HAHA
ON students
INSTEAD OF DELETE
AS
BEGIN
	DELETE ClassStudent  
	WHERE studentID = (SELECT StudentID FROM deleted)

	DELETE Marks  
	WHERE studentID = (SELECT StudentID FROM deleted)
END

DELETE students
WHERE StudentID = 1
--2. Trigger khi thêm mới MARK, nếu Mark < 0 thì thông bào lỗi và không cho insert
ALTER TRIGGER HEHE
ON Marks
FOR UPDATE
AS
	IF((SELECT Mark FROM inserted) < 0)
	BEGIN 
		PRINT N' ĐIỂM KHÔNG THỂ NHỎ HƠN KHÔNG';
		ROLLBACK TRANSACTION;
	END

	select * from Marks

UPDATE Marks
SET Mark = -32
WHERE StudentID = 2
go