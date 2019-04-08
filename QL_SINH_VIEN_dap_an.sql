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
create proc show_sv
as
  
Select MaSV,TenSV,NgaySinh,GioiTinh,TenLop
   From SinhVien,Lop
   Where SinhVien.MaLop=Lop.MaLop


 -- 2.Hien Thi Top 3 sinh vien lop may tinh 3 co diem mon SQL >=7
create proc show_top3sv
as
   Select Top 3 TenSV,TenLop,DiemLan1,TenMH
   From SinhVien,Diem,Lop,MonHoc
   Where TenLop='MÁy tính 3' and DiemLan1>=7 and TenMH='SQL'
         And SinhVien.MaLop=Lop.MaLop And Diem.MaSV=SinhVien.MaSV And Diem.MaMH=MonHoc.MaMH

 -- 3.Hien Thi MaSV,TenSV,Ngay Sinh,Que Quan cua cac sinh vien ten la Ba va co tuoi lon hon 19.
create proc show_svba19
as  
Select MaSV,TenSV,NgaySinh,QueQuan
   From SinhVien
   Where (TenSV like '%Ba') And (Year(getdate()) - Year(NgaySinh) >19)

 -- 4. Hien Thi Tat Ca Nhung Sinh Vien Khoa Cong Nghe Thong Tin
 create proc show_svcntt
as
 Select TenSV,TenLop,NgaySinh,QueQuan
   From (SinhVien Inner join Lop on SinhVien.MaLop=Lop.MaLop)
         Inner join Khoa on Khoa.MaKhoa=Lop.MaKhoa
   Where TenKhoa=N'Công nghệ thông tin'

 -- 5. Hien Thi Diem cua sinh vien lop May Tinh 3 Khoa 2 Sap Xep Diem Giam Dan
   create proc show_diemsvmt3
as
Select TenSV,TenLop,DiemLan1
   From SinhVien,Lop,KhoaHoc,Diem
   Where SinhVien.MaLop=Lop.MaLop And Lop.MaKhoaHoc=KhoaHoc.MaKhoaHoc And Diem.MaSV=SinhVien.MaSV And TenKhoaHoc='dai hoc khoa 2' And TenLop='may tinh 3'
   Order By DiemLan1 DESC 
 
 --6. Tinh Trung Binh Diem Cac Mon Hoc Cua Cac Sinh Vien Lop May tinh 3
    create proc show_diemtbsvmt3
as
Select SinhVien.MaSV,TenSV,Lop.TenLop, SUM(DiemLan1*SoTrinh)/SUM(SoTrinh) as DiemTrungBinh
   From SinhVien,Diem,MonHoc,Lop
   Where SinhVien.MaLop=Lop.MaLop And Diem.MaSV=SinhVien.MaSV And Diem.MaMH=MonHoc.MaMH
         And TenLop=N'MÁy Tính 3'
   Group By SinhVien.MaSV,TenSV,Lop.TenLop

 --7.Hien Thi Tat Ca Sinh Vien Phai Hoc Lai Mon Mang May Tinh
    create proc show_svhlmt3
as
Select TenSV,TenMH,DiemLan1,DiemLan2
   From SinhVien,Diem,MonHoc
   Where SinhVien.MaSV=Diem.MaSV And Diem.MaMH=MonHoc.MaMH And (DiemLan1<5) And (DiemLan2<5) And TenMH='Mạng máy tính'
--SV phai thi lai
    create proc show_svthilai
as
Select TenSV,DiemLan1
   From SinhVien,Diem
   Where SinhVien.MaSV=Diem.MaSV And (DiemLan1<5)
--SV thi lai mang may tinh

create proc show_svthilaimmt
as
Select TenSV,DiemLan1,TenMH
   From SinhVien,Diem,MonHoc
Where SinhVien.MaSV=Diem.MaSV And Diem.MaMH=MonHoc.MaMH And (DiemLan1<5) And TenMH='Mạng máy tính'
  


 --8. Dem So Luong Sinh Vien Cua Khoa Cong Nghe Thong Tin
    create proc show_demsvcntt
as
     select count(*) as CNTT from SINHVIEN,KHOA,LOP
     where SINHVIEN.MALOP=LOP.MALOP and LOP.MAKHOA=KHOA.MAKHOA and TENKHOA=N'Công nghệ thông tin'

 --9. Dem So Luong Sinh Vien Cua Tung Khoa
      create proc show_demsvkhoa
as
     select KHOA.MAKHOA, count(*) as SoLuong from SINHVIEN,LOP,KHOA
     where SINHVIEN.MALOP=LOP.MALOP and LOP.MAKHOA=KHOA.MAKHOA
     group by KHOA.MAKHOA

 --10. Cho biet diem thap nhat cua moi mon hoc
     create proc show_diemthapnhat
as
     select MonHoc.MAMH,min(diemlan1) as [Min diem]
     from MonHoc inner join diem on MonHoc.MAMH=diem.MAMH
     group by MonHoc.MAMH

                   
---11. Tao cac Thu Tuc Sau:
    -- 11.1 Hien Thi Chi Tiet Sinh Vien Va Diem
  create proc hienthisv_diem
  as
  SELECT SinhVien.MaSV,TenSV,QueQuan,MaMH,DiemLan1
  from SinhVien join diem
  on Sinhvien.masv=diem.masv
  
   --11.4 Tao thu tuc nhap them sinh vien moi
    create procedure nhapmoiSV
    @Masv char(15),
    @Tensv nvarchar(20),
    @gioitinh bit,
    @ngaysinh datetime,
    @quequan nvarchar(50),
    @malop char(5)
    as
    begin
      insert into sinhvien
      values(@Masv,@Tensv,@gioitinh,@ngaysinh,@quequan,@malop)
    end
    --test
     nhapmoiSV '0241060898','my love',0,'5/5/1987','vung tau','KT1'
     go
     select * from sinhvien
 
 --12. CAC THAO TAC DU LIEU VOI CAC BANG
    -- 12.1 BANG SINH VIEN
       --A. THEM DU LIEU
          create PROCEDURE sp_insSINHVIEN
          (
          @MASV char(15),
          @TENSV nvarchar(20),
          @GIOITINH bit,
          @NGAYSINH DATETIME,
          @QueQuan nvarchar(50),
          @MALOP char(5)
          )
          AS
          BEGIN
          insert into SINHVIEN
          (
             MASV,
             TENSV,
             GIOITINH,
           NGAYSINH,
             QueQuan,
             MALOP
          )
           values (@MASV,@TENSV,@GIOITINH,@NGAYSINH,@QUEQUAN,@MALOP)
         END
  
          --TEST
              sp_insSINHVIEN '0241061298','BANG KIEU',1,'5/5/1987','HA NOI','MT3'
              SELECT * FROM SINHVIEN

      --B. XOA DU LIEU
          create procedure sp_delSINHVIEN
          @MASV char(15)
          as
            delete from SINHVIEN
            where MASV=@MASV
   
             -- TEST
              sp_delSINHVIEN '0241060218'
              select * from sinhvien

      --C. HIEN THI DU LIEU
          create proc sp_showSINHVIEN
          as
            select * from SINHVIEN
  
              --TEST
                 sp_showSINHVIEN
   
      --D. SUA DU LIEU
          create procedure sp_updateSINHVIEN
          (
           @MASV char(15),
           @TENSV nvarchar(20),
           @GIOITINH bit,
           @NGAYSINH DATETIME,
           @QUEQUAN nvarchar(50),
           @MALOP char(5)
          )
          as

          update SINHVIEN
            set  
               MASV=@MASV,
               TENSV=@TENSV,
           GIOITINH=@GIOITINH,
               NGAYSINH=@NGAYSINH,
               QUEQUAN=@QUEQUAN,
               MALOP=@MALOP
             where MASV=@MASV
         --- KIEM TRA
         sp_updateSINHVIEN '0241060218','BANG KIEU',1,'5/5/1987','HA NOI','MT3'
         select * from SINHVIEN
            
   -- 12.2 BANG LOP
     --A. THEM DU LIEU
          create PROCEDURE sp_insLOP
          (
          @MALOP char(5),
          @TENLOP nvarchar(30),
          @MAKHOA CHAR(5),
          @MaHeDT CHAR(5),
          @MaKhoaHoc CHAR(5)
          )
          AS
          BEGIN
          insert into LOP
          (
             MALOP,
             TENLOP,
             MAKHOA,
           MaHeDT,
             MaKhoaHoc
             )
     
         values (@MALOP,@TENLOP,@MAKHOA,@MaHeDT,@MaKhoaHoc)
         END

          --TEST
        
           sp_insLOP 'KT4','KINH TE 4','KT','A01','K2'
           select * from lop

      --B. XOA DU LIEU
          create procedure sp_delLOP
          @MALOP char(5)
          as
            delete from LOP
            where MALOP=@MALOP
          -- TEST
            sp_delLOP 'KT4'
 
       --C. HIEN THI DU LIEU
          create proc sp_showLOP
          as
            select * from LOP

     
       --D. SUA DU LIEU
          create procedure sp_updateLOP
          (
           @MALOP char(5),
           @TENLOP nvarchar(30),
           @MAKHOA CHAR(5),
           @MaHeDT CHAR(5),
           @MaKhoaHoc CHAR(5)
          )
          as

          update LOP
            set  
               MALOP=@MALOP,
               TENLOP=@TENLOP,
           MAKHOA=@MAKHOA,
               MaHeDT=@MaHeDT,
               MaKhoaHoc=@MaKhoaHoc
             where MALOP=@MALOP

   -- 12.3 BANG MON HOC
    
      --A. THEM DU LIEU
          create PROCEDURE sp_insMONHOC
          (
          @MaMH char(5),
          @TenMH nvarchar(30),
          @SoTrinh INT
          )
          AS
          BEGIN
          insert into MONHOC
          (
             MAMH,
             TENMH,
             SOTRINH
           )
     
         values (@MAMH,@TENMH,@SOTRINH)
         END
      --B. XOA DU LIEU
          create procedure sp_delMONHOC
          @MAMH char(5)
          as
            delete from MonHoc
            where MAMH=@MAMH
 
       --C. HIEN THI DU LIEU
          create proc sp_showMONHOC
          as
            select * from MONHOC

     
       --D. SUA DU LIEU
          create procedure sp_updateMONHOC
          (
           @MaMH char(5),
           @TenMH nvarchar(30),
           @SoTrinh INT
          )
          as

          update MONHOC
            set  
               MAMH=@MAMH,
               TENMH=@TENMH,
           SOTRINH=@SOTRINH
             where MAMH=@MAMH

  --- 12.4 BANG KHOA HOC
     --A. THEM DU LIEU
          create PROCEDURE sp_insKHOAHOC
          (
           @MaKhoaHoc char(5),
           @TenKhoaHoc nvarchar(20)
          )
          AS
          BEGIN
          insert into KHOAHOC
          (
             MaKhoaHoc,
             TenKhoaHoc
             )
     
         values (@MaKhoaHoc,@TenKhoaHoc)
         END
  
      --B. XOA DU LIEU
          create procedure sp_delKHOAHOC
          @MaKhoaHoc char(5)
          as
            delete from KHOAHOC
            where MaKhoaHoc=@MaKhoaHoc
 
       --C. HIEN THI DU LIEU
          create proc sp_showKHOAHOC
          as
            select * from KHOAHOC

     
       --D. SUA DU LIEU
          create procedure sp_updateKHOAHOC
          (
            @MaKhoaHoc char(5),
            @TenKhoaHoc nvarchar(20)
          )
          as

          update KHOAHOC
            set  
               MaKhoaHoc=@MaKhoaHoc,
               TenKhoaHoc=@TenKhoaHoc
            where MaKhoaHoc=@MaKhoaHoc

 --- 12.5 BANG KHOA
     --A. THEM DU LIEU
          create PROCEDURE sp_insKHOA
          (
            @MaKhoa char(5),
            @TenKhoa nvarchar(30),
            @DiaChi nvarchar(100),
            @DienThoai varchar(20)
          )
          AS
          BEGIN
          insert into KHOA
          (
             MaKhoa,
             TenKhoa,
             DiaChi,
           DienThoai
            )
     
         values (@MaKhoa,@TenKhoa,@DiaChi,@DienThoai)
         END
      --B. XOA DU LIEU
          create procedure sp_delKHOA
          @MAKHOA char(5)
          as
            delete from KHOA
            where MAKHOA=@MAKHOA
 
       --C. HIEN THI DU LIEU
          create proc sp_showKHOA
          as
            select * from KHOA

     
       --D. SUA DU LIEU
         create procedure sp_updateKHOA
          (
            @MaKhoa char(5),
            @TenKhoa nvarchar(30),
            @DiaChi nvarchar(100),
            @DienThoai varchar(20)
          )
          as

          update KHOA
            set  
               MaKhoa=@MaKhoa,
               TenKhoa=@TenKhoa,
           DiaChi=@DiaChi,
               DienThoai=@DienThoai
             where MaKhoa=@MaKhoa

 -- 12.6 BANG HE DAO TAO
   --A. THEM DU LIEU
          create PROCEDURE sp_HEDT
          (
           @MaHeDT char(5),
           @TenHeDT nvarchar(40)
          )
          AS
          BEGIN
          insert into HEDT
          (
             MaHeDT,
             TenHeDT
             )
     
         values (@MaHeDT,@TenHeDT)
         END
  
      --B. XOA DU LIEU
          create procedure sp_delHEDT
          @MaHeDT char(5)
          as
            delete from HEDT
            where MaHeDT=@MaHeDT
 
       --C. HIEN THI DU LIEU
         create proc sp_showHEDT
          as
            select * from HEDT

     
       --D. SUA DU LIEU
          create procedure sp_updateHEDT
          (
            @MaHeDT char(5),
            @TenHeDT nvarchar(40)
          )
          as

          update HEDT
            set  
               MaHeDT=@MaHeDT,
               TenHeDT=@TenHeDT
            where MaHeDT=@MaHeDT

 -- 12.7 BANG DIEM
      --A. THEM DU LIEU
         create PROCEDURE sp_insDIEM
          (
          @MaSV char(15),
          @MaMH CHAR(5),
          @HocKy INT,
          @DiemLan1 INT,
          @DiemLan2 INT
          )
          AS
          BEGIN
          insert into DIEM
          (
             MASV,
             MAMH,
             HOCKY,
           DIEMLAN1,
             DIEmLAN2
             )
     
         values (@MaSV,@MaMH,@HocKy,@DiemLan1,@DiemLan2)
         END
      --B. XOA DU LIEU
          create procedure sp_delDIEM
          @MASV char(15)
          as
            delete from DIEM
            where MASV=@MASV
 
       --C. HIEN THI DU LIEU
          create proc sp_showDIEM
          as
            select * from DIEM

     
       --D. SUA DU LIEU
          create procedure sp_updateDIEM
          (
           @MaSV char(15),
           @MaMH CHAR(5),
           @HocKy INT,
           @DiemLan1 INT,
           @DiemLan2 INT
          )
          as

          update DIEM
            set  
               MaSV=@MaSV,
               MaMH=@MaMH,
           HocKy=@HocKy,
               DiemLan1=@DiemLan1,
               DiemLan2=@DiemLan2
             where MaSV=@MaSV

     


 --- TAO TRIGGER

---13. Tao trigger khong cho phep xoa mon hoc

  --- Tao Trigger insert Bang Diem
   CREATE TRIGGER trginsert_Diem
   ON Diem
   For insert
   as
   DECLARE @DiemLan1 int
   DECLARE @DiemLan2 int
   SELECT @DiemLan1=DiemLan1,@DiemLan2=DiemLan2
   FROM Inserted
   IF (@DiemLan1 <0 ) or (@DiemLan1 >10) or (@DiemLan2 <0) or (@DiemLan2 >10)
     begin
     print 'Sai gia tri diem'
     Rollback transaction
     end
   else
     begin
     Print 'qua trinh chen dl thanh cong'
     end
   Go
  -- check
  INSERT INTO Diem VALUES ('0241060148','SQL',5,14,8)
  INSERT INTO Diem VALUES ('0241060158','SQL',5,-2,8)
  INSERT INTO Diem VALUES ('0241060168','SQL',5,8,8)
  INSERT INTO Diem VALUES ('0241060178','SQL',5,12,24)
  INSERT INTO Diem VALUES ('0241060918','JV',5,12,24)
 
  Go
  SELECT * FROM Diem

 -- Tao trigger de tat cac truong trong bang sv phai nhap

  create trigger trginsert_Sinhvien
  on Sinhvien
  for insert
  as
  begin
  -- khai bao 4 bien luu tru
  Declare @tensv nvarchar(20)
  Declare @quequan nvarchar(50)
  Declare @gioitinh bit
  Declare @ngaysinh datetime
  -- lay du lieu ra cac bien tu bang inserterd
  select @tensv=inserted.tensv,
         @quequan=inserted.quequan,
         @gioitinh=inserted.gioitinh,
         @ngaysinh=inserted.ngaysinh
  From Inserted
  if((@tensv is null) or (@quequan is null)
    or (@gioitinh is null) or (@ngaysinh is null))
    begin
    print'Ban phai day du cac thong'
    print'qua trinh them dl khong thanh cong'
    rollback tran
    end
  else
    begin
    print'ban da them du lieu thanh cong'
    end
end
  -- kiem tra

  select* from sinhvien