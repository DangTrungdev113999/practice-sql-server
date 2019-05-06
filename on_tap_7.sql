use master
Go
DROP database demodb
go
Create database demodb
go
use demodb
Go
Create table customer_account
(
	id int primary key identity,
	name varchar(100) NOT NULL unique
)
GO

Create table bank_account
(
	id int primary key identity,
	customer_id int NOT NULL unique foreign key references customer_account(id),
	total_money int not null CHECK(total_money > 100000)
)
GO

Create table bank_transaction
(
	id int primary key identity,
	customer_id int foreign key references customer_account(id) not null,
	trans_money int not null
)
GO

INSERT INTO customer_account(name) VALUES 
('Hong Vinh Khanh'),
('Tran Ngoc Diep')
GO
INSERT INTO bank_account(customer_id, total_money) VALUES 
(1,150000000),
(2,550000000)
GO 
-- Tạo view lấy ra thông tin của các tài khoản ngan hàng
Create view back_account_info as 
SELECT c.id, c.name, b.total_money from customer_account c LEFT JOIN bank_account b on c.id = b.customer_id
GO

SELECT * FROM back_account_info

/*
Yêu cầu 1
Tạo thủ tục tạo mới một tài khoản ngân hàng so cho
khi thục hiện procedure này thì thông tin sẽ tự đồng vào cả 2 bảng customer_account và bank_account
Khi một trong các câu lệnh bẹ thát bại thì tất cả dữ liệu các bảng sẽ không bj thay dổi
*/
CREATE PROC up_new_bank_account
@name nvarchar(100), @total_money int
AS
BEGIN TRAN [TRAN1]
	BEGIN TRY
		INSERT INTO customer_account(name) values(@name);
		DECLARE @id int;
		SET @id = (SELECT SCOPE_IDENTITY());
		INSERT INTO bank_account(customer_id, total_money) VALUES(@id, @total_money);
		COMMIT TRAN [TRAN1]
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN [TRAN1]
	END CATCH


/*
Yêu cầu 2: Tạo thủ tục thực hiện giao dịch rút tiến sao cho
Khi thự hiện thủ tục thì dữ liệu giao dịch lưu vào bảng bank_transaction
Update lại trường total_money cho bảng bank_account
Nếu số tiền còn lại trong tài khoản <= 100000 thì tất cả dữ liệu trong các bảng không bị thay đổi
*/