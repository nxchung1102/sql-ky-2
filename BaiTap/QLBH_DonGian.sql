create database QLBH --CSDL Lab 2
go
use QLBH
go

Create table KhachHang
(
	MaKhachHang nvarchar(5) not null,
	HovaTenLot nvarchar(50) not null,
	Ten nvarchar(50) not null,
	Diachi nvarchar(255),
	Email nvarchar(50) not null,
	DientThoai nvarchar(13) not null,
	primary key(MaKhachHang)
)
go

create table SanPham
(
	MaSanPham int not null identity, --Tu dong tang
	Mota nvarchar(255) not null,
	SoLuong int not null,
	DonGia money not null,
	TenSP nvarchar(50) not null,
	primary key(MaSanPham),
	check(soluong>0)
	
)
go
Create table HoaDon
(
	MaHoaDon int not null,
	NgayMuaHang datetime not null,
	MaKhachHang nvarchar(5) not null,
	TrangThai nvarchar(30) not null,
	primary key(MaHoaDon),
	foreign key(MaKhachHang) references KhachHang(MaKhachHang)
)
go

create table HoaDonChiTiet
(
	MaHoaDon int not null,
	MaSanPham int not null,
	SoLuong int not null,
	MaHoaDonChiTiet int not null identity,
	primary key(MaHoaDonChiTiet), --Tu dong tang
	foreign key(MaHoaDon) references HoaDon(MaHoaDon),
	foreign key(MaSanPham) references SanPham(MaSanPham)
)
go

--Nhập liệu bảng KhachHang
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH001',N'Lê Minh',N'Hương',N'Hà nội','HuongLM@fpt.edu.vn','0912876823')
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH002',N'Lê Minh',N'Hà',N'Hà nội','HaLM@fpt.edu.vn','0912876825')
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH003',N'Lê Minh',N'Đăng',N'Hà nội','DangLM@fpt.edu.vn','0912876815')
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH004',N'Lê Xuân',N'Lý',N'Thanh Hóa','LyLX@gmail.com','0979876823')
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH005',N'Trần Thu',N'Trang',N'Hà nội','TrangTT@fpt.edu.vn','0978876823')
insert into KhachHang(MaKhachHang,HovaTenLot,Ten,Diachi,Email,DientThoai)
values('KH006',N'Lê Minh ',N'Hà',N'Hà nam','HaTT@fpt.edu.vn','09798745823')
go
--Nhập liệu bảng sanpham- do masanpham tự động tăng nên không phải nhập
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'coi truyền hình',5,10000,N'Tivi')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng để làm mát',3,5000,N'Quạt điện')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng để chiếu sáng',3,5000,N'Bóng đèn sợi đốt')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng để chiếu sáng',3,5000,N'Bóng đèn tuýp')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng để làm mát',10,10000,N'Điều hòa')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng trong lớp học',10,500,N'Bàn học sinh')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng trong lớp học',30,50,N'Ghế học sinh')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng trong lớp học',3,100,N'Máy tính')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng trong lớp học',3,10,N'Bảng viết')
insert into SanPham(Mota,SoLuong,DonGia,TenSP)values(N'dùng trong lớp học',2,20,N'Bàn giáo viên')
go
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(1,'09-12-2016','KH001',N'Đã thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(2,'12-15-2016','KH002',N'Đã thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(3,'12-16-2016','KH002',N'Đã thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(4,'12-17-2016','KH003',N'chưa thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(5,'3-9-2017','KH006',N'Đã thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(6,'6-5-2017','KH004',N'Chưa thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(7,'1-24-2017','KH005',N'Chưa thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(8,'1-25-2017','KH002',N'Chưa thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(9,'2-26-2017','KH006',N'Đã thanh toán')
insert into HoaDon(MaHoaDon,NgayMuaHang,MaKhachHang,TrangThai)values(10,'3-7-2017','KH005',N'chưa thanh toán')
go

--Nhập liệu bảng chitiet hoadon - MaHoaDonchiTiet tự động tăng nên không phải nhập

insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(1,1,1)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(1,2,5)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(1,3,10)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(2,3,2)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(2,4,6)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(2,7,4)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(3,1,10)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(3,2,2)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(3,3,2)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(3,4,20)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(10,10,10)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(10,9,5)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(10,5,4)
insert into HoaDonChiTiet(MaHoaDon,MaSanPham,SoLuong) values(10,3,30)
go


SELECT dbo.KhachHang.MaKhachHang,(HovaTenLot+ ' '+Ten) AS hoTen
,dbo.HoaDon.MaHoaDon,NgayMuaHang,dbo.HoaDonChiTiet.MaSanPham,TenSP,dbo.HoaDonChiTiet.SoLuong
, (dbo.HoaDonChiTiet.SoLuong*DonGia) AS thanhTien FROM
dbo.KhachHang JOIN dbo.HoaDon ON dbo.KhachHang.MaKhachHang=dbo.HoaDon.MaKhachHang
JOIN dbo.HoaDonChiTiet ON HoaDonChiTiet.MaHoaDon = HoaDon.MaHoaDon
JOIN dbo.SanPham ON SanPham.MaSanPham = HoaDonChiTiet.MaSanPham 
ORDER BY KhachHang.MaKhachHang DESC