CREATE DATABASE buoi16_fix3
GO

USE buoi16_fix3
GO

CREATE TABLE News (
	Id int not null identity,
	Title nvarchar(200) not null,
	StatusId tinyint check(StatusId = 0 or  StatusId = 1),
	CatId int not null
)
go




CREATE TABLE Categories (
	Id int not null identity,
	Name nvarchar(100) not null,
	Ordering tinyint default(0),
	NewCount int default(0)
)
go

delete from Categories


ALTER TABLE News
ADD primary key(Id)
go

ALTER TABLE Categories
ADD primary key(Id)
go

ALTER TABLE News
ADD foreign key(CatId) references Categories(Id)
go

CREATE INDEX ui_title
on News(Title)
go

CREATE INDEX ui_Ordering
on Categories(Ordering)
go

/*
Trigger UpdateNewCount  trên bảng News sao cho khi thêm mới
dữ liệu vào bảng News thì trường NewsCount trong bảng 
Categories sẽ đưọc cập nhật bằng tổng số News theo danh mục đó
*/
select CatId, COUNT(CatId) as N'soluong' from News
group by CatId
go

create TRIGGER UpdateNewCount
ON News for insert
AS
BEGIN
	DECLARE @sumNew int;
	DECLARE @id int;
	select @id = (select CatId from inserted)
	select @sumNew = (select COUNT(CatId) from News 
						WHERE CatId = @id)
	UPDATE Categories SET NewCount = @sumNew where id = @id
END

insert into News(Title, StatusId, CatId)
VALUES(N'ABC1', 0, 1)
go
insert into News(Title, StatusId, CatId)
VALUES(N'ABC2', 0, 1)
go
insert into News(Title, StatusId, CatId)
VALUES(N'ABC3', 0, 2)
go
insert into News(Title, StatusId, CatId)
VALUES(N'ABC4', 0, 2)
go

/*
Trigger CheckCatName trên  bảng Categories sao cho không 
cho phép thêm mới một danh nục trùng tên, nếu có tình thêm
danh mục trùng tên thì hiển thị thông báo Danh mục này đã 
có trogn bảng, vui lòng thử lại
*/

alter trigger CheckCatName
on Categories for insert
AS
BEGIN TRAN
	DECLARE @name1 nvarchar(100);
	DECLARE @maxId int;
	DECLARE @a int = 1;
	select @name1 = (select count(Name) from inserted);
	select @maxId = (select MAX(Id) from Categories);
	

	while(@a <= @maxId)
		begin
			if(@name1 = (select Name from Categories
							 where Id = @a))
				BEGIN
					PRINT N'vui long nhap lai'
					ROLLBACK TRAN
				END
			set @a = @a + 1;
		end



INSERT INTO Categories(Name, Ordering)
VALUES(N'danh mục 1', 1), (N'danh mục 2', 2)
go

select * from Categories


-- yêu cầu 3: tạo thủ tục
-- Tạo thủ tục sp_addnewCategory  thêm mới vào bảng Categories

select * from Categories

select * from News

CREATE PROC sp_addnewCategory
@name nvarchar(100)
AS
BEGIN
	INSERT INTO Categories(Name) VALUES(@name)
END
GO

exec sp_addnewCategory N'danh muc 3'
go

-- Tạo thủ tục sp_adNewcateOrrdering sao cho khi thêm mới vào bảng Categories sao cho trường Ordering sẽ tự động tăng lên so với giá trị cao nhất của dòng trước đó
-- VD 1,2,3,4..v.v…

ALTER PROC sp_adNewcateOrrdering
@name nvarchar(100)
AS
BEGIN 
	DECLARE @or int;
	DECLARE @id int; 
	set @id = (select Id from Categories)
	set @or = (select max(Ordering) from Categories)
	INSERT INTO Categories(Name, Ordering) VALUES(@name, @or + 1)
END
	

exec sp_adNewcateOrrdering N'danh muc 5'
go

SELECT * FROM Categories

-- Tạo thủ tục lấy ra thông tin của một News theo Id
CREATE PROC up_selectNewById
@id int
AS
BEGIN
	SELECT * FROM News WHERE Id = @id
END

SELECT * FROM News

EXEC up_selectNewById 11
GO

-- Tạo thủ tục cho phép tìm kiếm gần đúng them Title của News
CREATE PROC up_likeTitle
@title nvarchar(100)
AS
BEGIN
	SELECT * FROM News WHERE Title LIKE '%@title%'
END
go

EXEC up_likeTitle N'C1'
GO