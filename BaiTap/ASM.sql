CREATE DATABASE QLNT
USE QLNT
GO
CREATE TABLE loaiNha
(
    maLoaiNha VARCHAR(10) PRIMARY KEY,
    tenLoaiNha NVARCHAR(30)
)
CREATE TABLE quan
(
    maQuan VARCHAR(10)PRIMARY KEY,
    tenQuan NVARCHAR(20)
)
CREATE TABLE nguoiDung
(
    maND VARCHAR(10)PRIMARY KEY,
    tenND NVARCHAR(30),
    gioiTinh NVARCHAR(30),
    dienThoai NVARCHAR(30),
    diaChi NVARCHAR(30),
	Email NVARCHAR(30),
    maQuan VARCHAR(10) REFERENCES dbo.quan(maQuan)
)
CREATE TABLE nhaTro
(
    maNhaTro VARCHAR(10)PRIMARY KEY,
    tenNhaTro NVARCHAR(30),
    maLoaiNha VARCHAR(10)REFERENCES dbo.loaiNha(maLoaiNha),
    giaPhong MONEY,
    maQuan VARCHAR(10)REFERENCES dbo.quan(maQuan),
    diaChi NVARCHAR(30),
    moTa NVARCHAR(30),
    ngayDangTin DATE,
	dienTich DECIMAL(9,1),
    maND VARCHAR(10) REFERENCES dbo.nguoiDung(maND)
)

CREATE TABLE hopDongThue
(
    maND VARCHAR(10) REFERENCES dbo.nguoiDung(maND),
    maNhaTro VARCHAR(10) REFERENCES dbo.nhaTro(maNhaTro),
    ngayDen DATE,
    ngayDi DATE,
    PRIMARY KEY(maND,maNhaTro)
)
CREATE TABLE danhGia
(
    maDG VARCHAR(10)PRIMARY KEY,
    maND VARCHAR(10) REFERENCES dbo.nguoiDung(maND),
    maNhaTro VARCHAR(10),
    likes BIT,
    noiDungDG NVARCHAR(30)
)

INSERT INTO loaiNha
VALUES
    ('MaN01', N'Nhà cấp 4'),
    ('MaN02', N'Nhà cấp 3 '),
    ('MaN03', N'Nha cấp 2')
--
INSERT INTO quan
VALUES
    ('MaQ01', N'Quận 1'),
    ('MaQ02', N'Quận 2'),
    ('MaQ03', N'Quận 3'),
    ('MaQ04', N'Quận 4'),
    ('MaQ05', N'Quận 5'),
    ('MaQ06', N'Quận 6'),
    ('MaQ07', N'Quận 7'),
    ('MaQ08', N'Quận 8'),
    ('MaQ09', N'Quận 9'),
    ('MaQ10', N'Quận 10')
--
INSERT INTO nguoiDung
VALUES
    ('MaND01', N'Nguyễn Văn 01', N'Nam', N'0123456781', N'Quận 1',N'qwe@gmail.com', 'MaQ01'),
    ('MaND02', N'Nguyễn Văn 02', N'Nam', N'0123456782', N'Quận 2',N'rty@gmail.com', 'MaQ02'),
    ('MaND03', N'Nguyễn Văn 03', N'Nam', N'0123456783', N'Quận 3',N'uio@gmail.com', 'MaQ03'),
    ('MaND04', N'Nguyễn Văn 04', N'Nam', N'0123456784', N'Quận 4',N'asd@gmail.com', 'MaQ04'),
    ('MaND05', N'Nguyễn Văn 05', N'Nam', N'0123456785', N'Quận 5',N'fgh@gmail.com', 'MaQ05'),
    ('MaND06', N'Nguyễn Văn 06', N'Nữ', N'0123456786', N'Quận 6',N'jkl@gmail.com', 'MaQ06'),
    ('MaND07', N'Nguyễn Văn 07', N'Nữ', N'0123456787', N'Quận 7',N'zxc@gmail.com', 'MaQ07'),
    ('MaND08', N'Nguyễn Văn 08', N'Nữ', N'0123456788', N'Quận 8',N'vbn@gmail.com', 'MaQ08'),
    ('MaND09', N'Nguyễn Văn 09', N'Nữ', N'0123456789', N'Quận 9',N'mlp@gmail.com', 'MaQ09'),
    ('MaND10', N'Nguyễn Văn 10', N'Nữ', N'0123456710', N'Quận 10',N'qaz@gmail.com', 'MaQ10')
--

INSERT INTO nhaTro
VALUES
    ('MaNT01', N'Nhà Trọ 01', 'MaN01', 1000, 'MaQ01', N'Quận 1', N'Rộng', '2022-01-01',35, 'MaND01'),
    ('MaNT02', N'Nhà Trọ 02', 'MaN02', 2000, 'MaQ02', N'Quận 2', N'Rộng', '2022-02-02',20, 'MaND02'),
    ('MaNT03', N'Nhà Trọ 03', 'MaN03', 3000, 'MaQ03', N'Quận 3', N'Vừa', '2022-03-03',60, 'MaND03'),
    ('MaNT04', N'Nhà Trọ 04', 'MaN01', 4000, 'MaQ04', N'Quận 4', N'Rộng', '2022-04-04',40, 'MaND04'),
    ('MaNT05', N'Nhà Trọ 05', 'MaN02', 5000, 'MaQ05', N'Quận 5', N'Vừa', '2022-05-05',55, 'MaND05'),
    ('MaNT06', N'Nhà Trọ 06', 'MaN03', 6000, 'MaQ06', N'Quận 6', N'Rộng', '2022-06-06',100, 'MaND06'),
    ('MaNT07', N'Nhà Trọ 07', 'MaN01', 7000, 'MaQ07', N'Quận 7', N'Rộng', '2022-07-07',80, 'MaND07'),
    ('MaNT08', N'Nhà Trọ 08', 'MaN02', 8000, 'MaQ08', N'Quận 8', N'Vừa', '2022-08-08',75, 'MaND08'),
    ('MaNT09', N'Nhà Trọ 09', 'MaN03', 9000, 'MaQ09', N'Quận 9', N'Rộng', '2022-09-09',90, 'MaND09'),
    ('MaNT10', N'Nhà Trọ 10', 'MaN01', 1100, 'MaQ10', N'Quận 10', N'Rộng', '2022-10-10',80, 'MaND10')
--

INSERT INTO hopDongThue
VALUES
    ('MaND01', 'MaNT01', '2022-01-01', '2023-01-29'),
    ('MaND02', 'MaNT02', '2022-02-01', '2023-02-27'),
    ('MaND03', 'MaNT03', '2022-03-01', '2023-04-29'),
    ('MaND04', 'MaNT04', '2022-04-01', '2023-06-29'),
    ('MaND05', 'MaNT05', '2022-05-01', '2023-08-29'),
    ('MaND06', 'MaNT06', '2022-06-01', '2023-10-29'),
    ('MaND07', 'MaNT07', '2022-07-01', '2023-07-11'),
    ('MaND08', 'MaNT08', '2022-08-01', '2023-08-15'),
    ('MaND09', 'MaNT09', '2022-09-01', '2023-09-10'),
    ('MaND10', 'MaNT10', '2022-10-01', '2023-10-25')
--

INSERT INTO danhGia
VALUES
    ('MaDG01', 'MaND01', 'MaNT01', 1, N'Tốt'),
    ('MaDG02', 'MaND02', 'MaNT02', 1, N'Khá'),
    ('MaDG03', 'MaND03', 'MaNT03', 1, N'Tốt'),
    ('MaDG04', 'MaND04', 'MaNT04', 1, N'Khá'),
    ('MaDG05', 'MaND05', 'MaNT04', 1, N'Tốt'),
    ('MaDG06', 'MaND06', 'MaNT06', 0, N'không tốt'),
    ('MaDG07', 'MaND07', 'MaNT07', 1, N'Tốt'),
    ('MaDG08', 'MaND08', 'MaNT08', 1, N'khá'),
    ('MaDG09', 'MaND09', 'MaNT04', 1, N'Tốt'),
    ('MaDG10', 'MaND10', 'MaNT10', 0, N'không Tốt')

SELECT * FROM danhGia
SELECT * FROM loaiNha
SELECT * FROM quan
SELECT * FROM nhaTro
SELECT * FROM nguoiDung
SELECT * FROM hopDongThue


IF OBJECT_ID('spInsertNguoidung') IS NOT NULL
DROP PROC spInsertNguoidung
GO

CREATE PROC spInsertNguoidung
	@maND VARCHAR(10) = NULL ,
	@tenND NVARCHAR(30) = NULL,
	@gioiTinh NVARCHAR(30) = NULL,
	@dienThoai NVARCHAR(30) = NULL,
	@diaChi NVARCHAR(30) = NULL,
	@maQuan VARCHAR(10) = NULL
	AS 
	BEGIN 
BEGIN TRY
	    -- Kiem tra cac cot khong chap nhan thuoc tinh null
    if (@maND is null or @tenND is null or @maQuan is NULL)
        PRINT 'Khong duoc de trong thong tin MaND end tenND end maQuan!'

        -- -- Neu bai hoi kiem tra khoa chinh, ton tai da co thi loi
        ELSE IF exists (SELECT * FROM nguoiDung WHERE maND like @maND)
        PRINT 'maND da co roi ,  khong them duoc'
        -- -- Neu bai hoi kiem tra khoa ngoai , Neu khong ton tai gia tri khoa ngoai tren bang 1 => Loi 
        ELSE IF not EXISTS(SELECT * FROM quan WHERE maQuan like @maQuan)
         PRINT 'MaQuan chua co tren bang quan, loi khoa ngoai'
        ELSE 
        BEGIN 
            -- Them vao bang nguoi dung
            INSERT INTO nguoiDung 
            VALUES (
                @maND ,
                @tenND,
                @gioiTinh,
                @dienThoai,
                @diaChi,
                @maQuan
            )
            -- THONG BAO THANH CONG
            PRINT 'THEM THANH CONG'

        END
END TRY
BEGIN CATCH
PRINT N'lỗi thêm dữ liệu: '+ ERROR_MESSAGE()
END CATCH
	END
--gọi thủ tục
EXEC spInsertNguoiDung 'MaND12' , N'Tran Quang Toi',N'Nam',N'0394202276',N'HaNoi','MaQ10'

SELECT * FROM dbo.nguoiDung
GO


IF OBJECT_ID('spInsertNhaTro') IS NOT NULL
DROP PROC spInsertNhaTro
GO
CREATE PROC spInsertNhaTro
	@maNhaTro VARCHAR(10) =  NULL,
	@tenNhaTro NVARCHAR(30) = NULL,
	@maLoaiNha VARCHAR(10) = NULL,
	@giaPhong MONEY = NULL,
	@maQuan VARCHAR(10) = NULL,
	@diaChi NVARCHAR(30) = NULL,
	@moTa NVARCHAR(30) = NULL,
	@ngayDangTin DATE = NULL,
	@dienTich DECIMAL(9, 1) = NULL,
	@maND VARCHAR(10) = NULL
	AS
	BEGIN
	    BEGIN TRY
		IF(@maNhaTro IS NULL)
		PRINT N'khong duoc de trong thong tin maNhaTro !'
		ELSE 
		BEGIN
		    INSERT INTO dbo.nhaTro
		    VALUES
		    (
			    @maNhaTro,
		        @tenNhaTro,
		        @maLoaiNha,
		        @giaPhong,
		        @maQuan,
		        @diaChi,
		        @moTa,
		        @ngayDangTin,
		        @dienTich,
		        @maND
		        )
				PRINT N'success'
		END
        END TRY
		BEGIN CATCH
		PRINT N'loi them du lieu: '+ ERROR_MESSAGE()
		END CATCH
	END
	EXEC dbo.spInsertNhaTro 'MaNT11',N'Nhà Trọ 11','MaN03',120000,'MaQ06',N'Quận 3',N'nhỏ','2020-07-21',120,'MaND01'
	
	SELECT * FROM dbo.nhaTro
GO
IF OBJECT_ID('spInsertDanhGia') IS NOT NULL
DROP PROC spInsertDanhGia
GO
CREATE PROC spInsertDanhGia
	@maDG VARCHAR (10) = NULL,
	@maND VARCHAR (10)= NULL,
	@maNhaTro VARCHAR (10) =NULL,
	@likes BIT = NULL,
	@noiDungDG NVARCHAR (30) =NULL
	AS
	BEGIN
	    BEGIN TRY
		IF(@maDG IS NULL)
		PRINT N'khong duoc de trong thong tin maDG !'
		ELSE
BEGIN
    		INSERT INTO dbo.danhGia
		VALUES
		(   @maDG,
		    @maND,
		    @maNhaTro,
		    @likes,
		    @noiDungDG
			)
			PRINT N'success'
END
        END TRY
		BEGIN CATCH
		PRINT N'loi them du lieu: '+ ERROR_MESSAGE()
		END CATCH
	END
	EXEC dbo.spInsertDanhGia 'MaDG11','MaND01','MaNT11',0,N'Không Tốt'
	SELECT * FROM dbo.danhGia
	
--2. Truy vấn thông tin
--a. Viết một SP với các tham số đầu vào phù hợp. SP thực hiện tìm kiếm thông tin các
--phòng trọ thỏa mãn điều kiện tìm kiếm theo: Quận, phạm vi diện tích, phạm vi ngày đăng
--tin, khoảng giá tiền, loại hình nhà trọ.
--SP này trả về thông tin các phòng trọ, gồm các cột có định dạng sau:
--o Cột thứ nhất: có định dạng ‘Cho thuê phòng trọ tại’ + <Địa chỉ phòng trọ>
--+ <Tên quận/Huyện>
--o Cột thứ hai: Hiển thị diện tích phòng trọ dưới định dạng số theo chuẩn Việt Nam +
--m2. Ví dụ 30,5 m2
--o Cột thứ ba: Hiển thị thông tin giá phòng dưới định dạng số theo định dạng chuẩn
--Việt Nam. Ví dụ 1.700.000
--o Cột thứ tư: Hiển thị thông tin mô tả của phòng trọ
--o Cột thứ năm: Hiển thị ngày đăng tin dưới định dạng chuẩn Việt Nam.
--Ví dụ: 27-02-2012
--o Cột thứ sáu: Hiển thị thông tin người liên hệ dưới định dạng sau:
--▪ Nếu giới tính là Nam. Hiển thị: A. + tên người liên hệ. Ví dụ A. Thắng
--▪ Nếu giới tính là Nữ. Hiển thị: C. + tên người liên hệ. Ví dụ C. Lan
--o Cột thứ bảy: Số điện thoại liên hệ
--o Cột thứ tám: Địa chỉ người liên hệ
-- Viết hai lời gọi cho SP này

IF OBJECT_ID('sp_TTNT')IS NOT NULL
DROP PROC sp_TTNT
GO
CREATE PROC sp_TTNT 
@quan NVARCHAR(20)='%',
@maxDienTich  decimal(9,1)=0,
@minDienTich  decimal(9,1)=0,
@minNgayDang  datetime = NULL,
@maxNgayDang  datetime = NULL,
@maxGaiPhong MONEY = 10000000000,
@minGaiPhong MONEY =0,
@loaiNha NVARCHAR(30)='%'
AS 
BEGIN
    IF(@maxNgayDang IS NULL)
	SET @maxNgayDang = GETDATE()
	IF(@minNgayDang IS NULL)
	SET @minNgayDang = GETDATE()-7
	--ln,nt,nd,quan
	SELECT dbo.nhaTro.diaChi+N' Quận '+tenQuan AS N'địa chỉ nhà trọ',
	CAST(dientich AS NVARCHAR)+ ' m2',
	giaPhong,
	moTa,
	CONVERT(NVARCHAR,ngayDangTin,105) AS N'ngày đăng tin',
	IIF(gioiTinh LIKE N'nam',N'A.'+tenND,N'C.'+tenND)AS tenLH,
	dienThoai,
	dbo.nguoiDung.diaChi AS DiaChiLH
	FROM dbo.loaiNha 
	JOIN dbo.nhaTro ON nhaTro.maLoaiNha = loaiNha.maLoaiNha
	JOIN dbo.quan ON quan.maQuan = nhaTro.maQuan
	JOIN dbo.nguoiDung ON dbo.nhaTro.maND = dbo.nguoiDung.maND
	WHERE tenQuan LIKE @quan
	AND dientich BETWEEN @minDienTich AND @maxDienTich
	AND ngayDangTin BETWEEN @minNgayDang AND @maxNgayDang
	AND giaPhong BETWEEN @minGaiPhong AND @maxGaiPhong
	AND tenLoaiNha LIKE @loaiNha
END


EXEC dbo.sp_TTNT 
GO

--b. Viết một hàm có các tham số đầu vào tương ứng với tất cả các cột của bảng
--NGUOIDUNG. Hàm này trả về mã người dùng (giá trị của cột khóa chính của bảng
--NGUOIDUNG) thỏa mãn các giá trị được truyền vào tham số.
IF OBJECT_ID('fc_NguoiDung') IS NOT NULL
DROP FUNCTION fc_NguoiDung
GO
CREATE FUNCTION fc_NguoiDung (
	@tenND NVARCHAR (30)  ,
	@gioiTinh NVARCHAR (30)  ,
	@dienThoai NVARCHAR (30)  ,
	@diaChi NVARCHAR (30)  ,
	@email NVARCHAR(30),
	@maQuan VARCHAR (10)
	)
	RETURNS TABLE 
	AS 
RETURN( SELECT maND FROM dbo.nguoiDung WHERE RTRIM(LTRIM(tenND))LIKE @tenND
AND	RTRIM(LTRIM(gioiTinh))LIKE @gioiTinh
AND RTRIM(LTRIM(dienThoai))LIKE @dienThoai
 AND RTRIM(LTRIM(diaChi))LIKE @diaChi
  AND RTRIM(LTRIM(Email))LIKE @email
AND RTRIM(LTRIM(maQuan))LIKE @maQuan)

GO
SELECT maND FROM dbo.fc_NguoiDung(N'%',N'%',N'%',N'%',N'%','MaQ01')
SELECT * FROM dbo.nguoiDung
GO

--c. Viết một hàm có tham số đầu vào là mã nhà trọ (cột khóa chính của bảng
--NHATRO). Hàm này trả về tổng số LIKE và DISLIKE của nhà trọ này.
IF OBJECT_ID('fc_NhaTro') IS NOT NULL
DROP FUNCTION fc_NhaTro
GO
CREATE FUNCTION fc_NhaTro (@maNT VARCHAR(10))
RETURNS @bang TABLE( 
tongLike INT,tongDislike INT 
)
AS 
BEGIN
    DECLARE @numlike INT=0, @numDislike INT=0
	SELECT @numlike = COUNT(maNhaTro) FROM dbo.danhGia
	WHERE likes =1 AND maNhaTro LIKE @maNT
	SELECT @numDislike = COUNT(maNhaTro) FROM dbo.danhGia
	WHERE likes = 0 AND maNhaTro LIKE @maNT
	INSERT INTO @bang
	VALUES(@numlike,@numDislike)
	RETURN
END
GO
SELECT * FROM dbo.fc_NhaTro('MaNT04')

--d. Tạo một View lưu thông tin của TOP 10 nhà trọ có số người dùng LIKE nhiều nhất gồm
--các thông tin sau:
--- Diện tích
--- Giá
--- Mô tả
--- Ngày đăng tin
--- Tên người liên hệ
--- Địa chỉ
--- Điện thoại
--- Email
IF OBJECT_ID('vw_top10') IS NOT NULL
DROP VIEW vw_top10
GO
CREATE VIEW vw_top10
AS 
SELECT TOP 10 COUNT(likes)AS luotLike, dienTich,giaPhong,moTa,ngayDangTin,tenND,nhaTro.diaChi,dienThoai,Email  FROM dbo.nhaTro
JOIN dbo.nguoiDung ON nguoiDung.maND = nhaTro.maND 
JOIN dbo.danhGia ON danhGia.maNhaTro = nhaTro.maNhaTro 
WHERE likes = 1
GROUP BY  dienTich,giaPhong,moTa,ngayDangTin,tenND,nhaTro.diaChi,dienThoai,Email
GO
SELECT * FROM dbo.vw_top10



--e. Viết một Stored Procedure nhận tham số đầu vào là mã nhà trọ (cột khóa chính của
--bảng NHATRO). SP này trả về tập kết quả gồm các thông tin sau:
-- - Mã nhà trọ
-- - Tên người đánh giá
-- - Trạng thái LIKE hay DISLIKE
-- - Nội dung đánh giáIF OBJECT_ID('sp_TTDanhGia')IS NOT NULL
DROP PROC sp_TTDanhGia 
GO
CREATE PROC sp_TTDanhGia
@maNT VARCHAR(10) = '%'
AS 
BEGIN
    SELECT danhGia.maNhaTro,tenND AS tenNDG,IIF(likes = 1, N'like',N'dislike') AS STATUS
	,noiDungDG FROM dbo.nguoiDung 
	JOIN dbo.hopDongThue ON hopDongThue.maND = nguoiDung.maND
	JOIN dbo.danhGia ON danhGia.maNhaTro = hopDongThue.maNhaTro AND danhGia.maND = hopDongThue.maND
	WHERE danhGia.maNhaTro LIKE @maNT
END

EXEC dbo.sp_TTDanhGia 
EXEC dbo.sp_TTDanhGia @maNT = 'MaNT01' 

--1. Viết một SP nhận một tham số đầu vào kiểu int là số lượng DISLIKE. SP này thực hiện
--thao tác xóa thông tin của các nhà trọ và thông tin đánh giá của chúng, nếu tổng số lượng
--DISLIKE tương ứng với nhà trọ này lớn hơn giá trị tham số được truyền vào.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một thao tác
--xóa thực hiện không thành công.

IF OBJECT_ID('sp_xoaNT')IS NOT NULL
DROP PROC sp_xoaNT 
GO
CREATE PROC sp_xoaNT
@num INT 
AS 
BEGIN
    BEGIN TRY
        BEGIN TRAN 
		DECLARE @bang TABLE (maNT VARCHAR(10))
		--lay ma nha tro co tong so  luong dislike >1
		INSERT INTO @bang
		SELECT maNhaTro FROM dbo.danhGia
		WHERE likes = 0
		GROUP BY maNhaTro
		HAVING COUNT(likes)>@num
		--xoa  danhgia cua nhatro co trong @bang
		DELETE FROM dbo.danhGia WHERE maNhaTro IN (SELECT maNT FROM @bang)
				--xoa  hopDongThue cua nhatro co trong @bang
		DELETE FROM dbo.hopDongThue WHERE maNhaTro IN (SELECT maNT FROM @bang)
				--xoa  NhaTro cua nhatro co trong @bang
		DELETE FROM dbo.nhaTro WHERE maNhaTro IN (SELECT maNT FROM @bang)
		COMMIT TRAN
		PRINT N'xóa thành công'
    END TRY 
	BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRAN
	END CATCH
END

EXEC dbo.sp_xoaNT 0




GO
IF OBJECT_ID('sp_xoaNT_NDT')IS NOT NULL
DROP PROC sp_xoaNT_NDT 
GO
CREATE PROC sp_xoaNT_NDT
@minND DATETIME,
@maxND DATETIME
AS 
BEGIN
    BEGIN TRY
        BEGIN TRAN 
				DECLARE @bang TABLE (maNT VARCHAR(10))
		
		INSERT INTO @bang
		SELECT maNhaTro FROM dbo.nhaTro
		WHERE ngayDangTin BETWEEN @minND AND @maxND
		--xoa  danhgia cua nhatro co trong @bang
		DELETE FROM dbo.danhGia WHERE maNhaTro IN (SELECT maNT FROM @bang)
				--xoa  hopDongThue cua nhatro co trong @bang
		DELETE FROM dbo.hopDongThue WHERE maNhaTro IN (SELECT maNT FROM @bang)
				--xoa  NhaTro cua nhatro co trong @bang
		DELETE FROM dbo.nhaTro WHERE maNhaTro IN (SELECT maNT FROM @bang)
		COMMIT TRAN
	
		PRINT N'xóa thành công'
    END TRY 
	BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRAN
	END CATCH
END
EXEC dbo.sp_xoaNT_NDT '2022-01-01','2022-03-03'
SELECT * FROM dbo.nhaTro

