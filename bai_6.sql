CREATE DATABASE demo_db
go

use demo_db
go

CREATE TABLE Category (
	Id int primary key identity,
	Name nvarchar(100) not null,
	Status tinyint check(Status = 0 OR Status = 1 or Status = 2),
	Ordering tinyint default(0)
)
go

-- tạo index trên cột Name của category
create index ui_name on Category(Name)
go

-- tạo thủ tục thêm mới vào bảng Category với điều kiện là khi thêm mới thì chit id là chỉ số chẵ VD 2,4,6,8... mà không có id lẻ
alter proc up_id
@name nvarchar(100),
 @status tinyint
as
begin tran
	insert into Category(Name,Status)
	values(@name, @status)
	declare @id INT = SCOPE_IDENTITY();
	
	IF(@id % 2 = 0)
		COMMIT TRAN
	ELSE
		BEGIN
			PRINT N'id phải chẵn cơ, đề bài oái ăm vãi'
			ROLLBACK TRAN
		END


EXEC up_id N'dang the trung', 1
go

select * from Category

delete from Category

-- tạo view tên là vallctegory
CREATE VIEW UV_INFO
AS
SELECT Id AS N'MÃ DM', Name AS N'TÊN DANH MỤC',
Ordering AS N'THỨ TỰ',
CASE
	WHEN Status = 0 THEN N'HẾT HÀNG'
	WHEN Status = 1 THEN N'CÒN HÀNG'
	ELSE N'KHÔNG XÁC ĐỊNH'
END AS N'TRẠNG THÁI'
FROM Category

-- TẠO trigger khi thêm mới vào bảng Category thì trường ordering tự đọng tằng kết tiếp 
-- vd trước đó là một thì kết sau là 2...vv...

create trigger ut_or
on Category for insert
as
begin
	declare @or int;
	declare @id int;
	set @or = (select max(Ordering) from Category);
	set @id = (select Id from inserted);

	update Category set Ordering = @or + 1
	WHERE Id = @id
end

-- YỂU CẦU 5

CREATE VIEW UV_INFO2
AS
SELECT Id AS N'MÃ DM', Name AS N'TÊN DANH MỤC',
CONCAT(N'VỊ TRÍ ', Ordering) AS N'THỨ TỰ',
CASE
	WHEN Status = 0 THEN N'HẾT HÀNG'
	WHEN Status = 1 THEN N'CÒN HÀNG'
	ELSE N'KHÔNG XÁC ĐỊNH'
END AS N'TRẠNG THÁI'
FROM Category