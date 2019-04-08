Create Database BTLSQL
go
Use BTLSQL
go
-- Tao Bang Mon Hoc --
Create Table MonHoc
 (
   MaMH char(5) primary key,
   TenMH nvarchar(30) not null,
   SoTrinh int not null check ( (SoTrinh>0)and (SoTrinh<7) )
 )
--- Tao Bang He Dao Tao ---
Create Table HeDT
 (
   MaHeDT char(5) primary key,
   TenHeDT nvarchar(40) not null
 )

--- Tao Bang Khoa Hoc ---
Create Table KhoaHoc
 (
   MaKhoaHoc char(5) primary key,
   TenKhoaHoc nvarchar(20) not null
 )
--- Tao Bang Khoa --
Create Table Khoa
 (
   MaKhoa char(5) primary key,
   TenKhoa nvarchar(30) not null,
   DiaChi nvarchar(100) not null,
   DienThoai varchar(20) not null
 )
-- Tao Bang Lop ---
Create Table Lop
 (
   MaLop char(5) primary key,
   TenLop nvarchar(30) not null,
   MaKhoa char(5) foreign key references Khoa (MaKhoa),
   MaHeDT char(5) foreign key references HeDT (MaHeDT),
   MaKhoaHoc char(5) foreign key references KhoaHoc (MaKhoaHoc),
 )
--- Tao Bang Sinh Vien ---
Create Table SinhVien
 (
   MaSV char(15) primary key,
   TenSV nvarchar(20) ,
   GioiTinh bit ,
   NgaySinh datetime ,
   QueQuan nvarchar(50) ,
   MaLop char(5) foreign key references Lop(MaLop)
 )
--- Tao Bang Diem ---
Create Table Diem
 (
   MaSV char(15) foreign key references SinhVien(MaSV),
   MaMH char(5) foreign key references MonHoc (MaMH),
   HocKy int check(HocKy>0) not null,
   DiemLan1 int ,
   DiemLan2 int
)

---Nhap Du Lieu Cho Bang He Dao Tao --
insert into HeDT values('A01',N'Ðại Học')
insert into HeDT values('B01',N'Cao Ðẳng')
insert into HeDT values('C01',N'Trung Cấp')
insert into HeDT values('D01',N'Công nhân')

  Select * from HeDT

-- Nhap Du Lieu Bang Ma Khoa Hoc ---
insert into KhoaHoc values('K1',N'Ðại học khóa 1')
insert into KhoaHoc values('K2',N'Ðại học khóa 2')
insert into KhoaHoc values('K3',N'Ðại học khóa 3')
insert into KhoaHoc values('K9',N'Ðại học khóa 4')
insert into KhoaHoc values('K10',N'Ðại học khóa 5')
insert into KhoaHoc values('K11',N'Ðại học khóa 6')

  Select * from KhoaHoc

-- Nhap Du Lieu bang Khoa --
insert into Khoa values('CNTT',N'Công nghệ thông tin',N'Tầng 4 nhà B','043768888')
insert into Khoa values('CK',N'Cõ Khí',N'Tầng 5 nhà B','043768888')
insert into Khoa values('DT',N'Ðiện tử',N'Tằng 6 nhà B','043768888')
insert into Khoa values('KT',N'Kinh Tế',N'Tầng 2 nhà C','043768888')

  Select * from Khoa

--- Nhap Du Lieu Cho Bang Lop --
insert into Lop values('MT1',N'MÁy Tính 1','CNTT','A01','K2')
insert into Lop values('MT2',N'MÁy Tính 2','CNTT','A01','K2')
insert into Lop values('MT3',N'MÁy Tính 3','CNTT','A01','K2')
insert into Lop values('MT4',N'MÁy Tính 4','CNTT','A01','K2')
insert into Lop values('KT1',N'Kinh tế 1','KT','A01','K2')

 select * from Lop

-- Nhap Du Lieu Bang Sinh Vien --
insert into SinhVien values('0241060218',N'Nguyễn Minh Một',1,'08/27/1989','Hải Dýõng','MT3')
insert into SinhVien values('0241060318',N'Nguyễn Minh Hai',1,'2/08/1989','Nam Dinh','MT1')
insert into SinhVien values('0241060418',N'Nguyễn Minh Ba',1,'7/04/1989','Ninh Binh','MT2')
insert into SinhVien values('0241060518',N'Nguyễn Minh Bốn',1,'7/08/1989','Ninh Binh','MT1')
insert into SinhVien values('0241060618',N'Nguyễn Minh Nãm',0,'7/08/1989','Nam Dinh','MT3')
insert into SinhVien values('0241060718',N'Nguyễn Minh Sáu',1,'7/08/1989','Ha Noi','MT3')
insert into SinhVien values('0241060818',N'Nguyễn Minh Bảy',1,'7/08/1989','Ha Noi','MT3')
insert into SinhVien values('0241060918',N'Nguyễn Minh Tám',1,'7/08/1989','Hai Duong','MT2')
insert into SinhVien values('0241060128',N'Nguyễn Minh Chín',1,'7/08/1989','Hai Duong','MT2')
insert into SinhVien values('0241060138',N'Nguyễn Minh Mýời',1,'7/08/1989','Ha Nam','MT2')
insert into SinhVien values('0241060148',N'Nguyễn Minh Mýời Một',0,'7/08/1989','Bac Giang','MT4')
insert into SinhVien values('0241060158',N'Nguyễn Minh Mýời Hai',0,'7/08/1989','Ha Noi','MT4')
insert into SinhVien values('0241060168',N'Nguyễn Minh Mýời Ba',1,'7/08/1989','Hai Duong','MT4')
insert into SinhVien values('0241060178',N'Nguyễn Minh Mýời Bốn',1,'7/08/1989','Nam Dinh','MT1')
insert into SinhVien values('0241060978',N'Nguyễn Minh Mýời Nãm',1,'7/08/1989','Nam Dinh','KT1')

select * from SinhVien

-- Nhap Du Lieu Bang Mon Hoc --
insert into MonHoc values('SQL','SQL',5)
insert into MonHoc values('JV','Java',6)
insert into MonHoc values('CNPM','Công Nghệ phần mềm',4)
insert into MonHoc values('PTHT','Phân tích hệ thống',4)
insert into MonHoc values('Mang','Mạng máy tính',5)

  select * from MonHoc
-- Nhap Du Lieu Bang Diem --
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060218','SQL',5,7)
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060418','SQL',5,6)
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060218','CNPM',5,8)
insert into Diem values('0241060518','SQL',5,4,6)
insert into Diem values('0241060218','Mang',5,4,5)
insert into Diem values('0241060218','JV',5,4,4)
insert into Diem values('0241060518','JV',5,4,6)
insert into Diem values('0241060218','PTHT',4,2,5)
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060318','SQL',4,9)
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060618','SQL',4,8)
insert into Diem values('0241060318','Mang',5,3,4)
insert into Diem values('0241060418','Mang',5,4,4)
insert into Diem(MaSV,MaMH,HocKy,DiemLan1) values('0241060518','Mang',5,8)

  select * from Diem



----- Cac Cau Lenh
 -- 1.Hiển thị danh sách sinh viên gồm các thông tin sau:MaSV,TenSV, NgaySinh, GioiTinh,Ten Lop



 -- 2.Hien Thi Top 3 sinh vien lop may tinh 3 co diem mon SQL >=7


 -- 3.Hien Thi MaSV,TenSV,Ngay Sinh,Que Quan cua cac sinh vien ten la Ba va co tuoi lon hon 19.


 -- 4. Hien Thi Tat Ca Nhung Sinh Vien Khoa Cong Nghe Thong Tin


 -- 5. Hien Thi Diem cua sinh vien lop May Tinh 3 Khoa 2 Sap Xep Diem Giam Dan

 --6. Tinh Trung Binh Diem Cac Mon Hoc Cua Cac Sinh Vien Lop May tinh 3


 --7.Hien Thi Tat Ca Sinh Vien Phai Hoc Lai Mon Mang May Tinh

--SV phai thi lai

--SV thi lai mang may tinh


 --8. Dem So Luong Sinh Vien Cua Khoa Cong Nghe Thong Tin


 --9. Dem So Luong Sinh Vien Cua Tung Khoa

 --10. Cho biet diem thap nhat cua moi mon hoc
                   
---11. Tao cac Thu Tuc Sau:
    -- 11.1 Hien Thi Chi Tiet Sinh Vien Va Diem
  
   --11.4 Tao thu tuc nhap them sinh vien moi

    --test
 
 --12. CAC THAO TAC DU LIEU VOI CAC BANG
    -- 12.1 BANG SINH VIEN
       --A. THEM DU LIEU
  
          --TEST


      --B. XOA DU LIEU


      --C. HIEN THI DU LIEU

  
              --TEST

   
      --D. SUA DU LIEU

         --- KIEM TRA

            
   -- 12.2 BANG LOP
     --A. THEM DU LIEU

          --TEST
        


      --B. XOA DU LIEU

          -- TEST

 
       --C. HIEN THI DU LIEU


     
       --D. SUA DU LIEU

   -- 12.3 BANG MON HOC
    
      --A. THEM DU LIEU

      --B. XOA DU LIEU

       --C. HIEN THI DU LIEU

     
       --D. SUA DU LIEU

  --- 12.4 BANG KHOA HOC
     --A. THEM DU LIEU
  
      --B. XOA DU LIEU

       --C. HIEN THI DU LIEU

     
       --D. SUA DU LIEU

 --- 12.5 BANG KHOA
     --A. THEM DU LIEU

      --B. XOA DU LIEU
 
       --C. HIEN THI DU LIEU

     
       --D. SUA DU LIEU

 -- 12.6 BANG HE DAO TAO
   --A. THEM DU LIEU

      --B. XOA DU LIEU

 
       --C. HIEN THI DU LIEU


     
       --D. SUA DU LIEU


 -- 12.7 BANG DIEM
      --A. THEM DU LIEU

      --B. XOA DU LIEU

 
       --C. HIEN THI DU LIEU


     
       --D. SUA DU LIEU
     


 --- TAO TRIGGER

---13. Tao trigger khong cho phep xoa mon hoc

  --- Tao Trigger insert Bang Diem

  -- check


 -- Tao trigger de tat cac truong trong bang sv phai nhap


  -- khai bao 4 bien luu tru

  -- lay du lieu ra cac bien tu bang inserterd

  -- kiem tra
