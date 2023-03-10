use QLDA 
go
--cách tạo hàm giá trị vô hướng
create function tên hàm (@Ts1 kiểu DL = Giá trị mặc định,
						 @Ts2 kiểu DL = Giá trị mặc định,
						 ...
						 )
returns kiểu DL vô hướng
as 
begin 
các câu lệnh code trong đây
return Biểu thức vô hướng
end

GO 

IF OBJECT_ID('fn_calcAge')IS NOT NULL 
DROP FUNCTION fn_calcAge
go
CREATE FUNCTION fn_calcAge(@NamSinh INT = 2000)
RETURNS INT
AS 
BEGIN
    RETURN (YEAR(GETDATE())-@NamSinh)
END
GO

PRINT N'tuổi của bạn là: ' + CAST(dbo.fn_calcAge(2002) AS nvarchar)

DECLARE @kq  INT
SELECT @kq = dbo.fn_calcAge(2002)
SELECT @kq AS tuoi
--sum nv nam 
--sum lương phdo phòng ban đưa vào
--tạo bảng,xây dựng 3 thủ tục để insert

--xây dựng tổng số lượng nhân viên
IF OBJECT_ID('fn_sumStaff') IS NOT NULL
DROP FUNCTION fn_sumStaff
GO 
CREATE FUNCTION fn_sumStaff ()
RETURNS INT
AS 
BEGIN
    RETURN (SELECT COUNT(MANV) FROM dbo.NHANVIEN)
END
GO 
DECLARE @dem INT
SELECT @dem = dbo.fn_sumStaff()
SELECT @dem
GO 

IF OBJECT_ID('fn_sumGender') IS NOT NULL
DROP FUNCTION fn_sumGender
GO 
CREATE FUNCTION fn_sumGender (@n NVARCHAR(3)= N'nam')
RETURNS INT 
AS
BEGIN
    RETURN (SELECT COUNT(MANV) FROM dbo.NHANVIEN WHERE PHAI LIKE @n)
END

PRINT N'số lượng nv nam: '+ CAST( dbo.fn_sumGender(DEFAULT) AS NVARCHAR)

GO
--  hàm giá trị bảng đơn giản
CREATE FUNCTION tên hàm (@Ts1 kiểu DL = Giá trị mặc định,
						 @Ts2 kiểu DL = Giá trị mặc định,
						 ...
						 )
RETURNS TABLE 
AS 
RETURN (câu lệnh SELECT)
GO
IF OBJECT_ID('fn_info') IS NOT NULL 
DROP FUNCTION fn_info
GO 
CREATE FUNCTION fn_info (@maphong INT)
RETURNS TABLE
AS 
RETURN SELECT MANV,TENNV,PHAI FROM dbo.NHANVIEN WHERE PHG = @maphong
GO

SELECT * FROM dbo.fn_info(4) JOIN dbo.NHANVIEN ON NHANVIEN.MANV = fn_info.MANV
GO
-- câu lệnh đa hướng
CREATE FUNCTION tên hàm (@Ts1 kiểu DL = Giá trị mặc định,
						 @Ts2 kiểu DL = Giá trị mặc định,
						 ...
						 )
RETURNS @bảng TABLE 
(-- khai báo cấu trúc bảng
tên cột 1 kiểu DL, 
tên cột 2 kiểu DL,
...
)
AS 
BEGIN
    --các lệnh(bắt buộc phải có insert into để đổ dữ liệu vào bảng)
	RETURN 
END
GO
IF OBJECT_ID('fn_info2') IS NOT NULL 
DROP FUNCTION fn_info2
GO 
CREATE FUNCTION fn_info2 (@maphong INT)
RETURNS @test TABLE (maNV NVARCHAR(9),tenNV NVARCHAR(15),phai NVARCHAR(3) )
AS
BEGIN
	INSERT INTO @test
	SELECT MANV,TENNV,PHAI FROM dbo.NHANVIEN WHERE PHG = @maphong
    RETURN
END

SELECT * FROM dbo.fn_info2(4)
GO 
-- cú pháp view 
CREATE VIEW tên VIEW 
AS 
câu lệnh SELECT 
GO

--tạo view chứa toàn bộ các nhân viên nam
CREATE VIEW vw_nvNam
AS 
SELECT * FROM dbo.NHANVIEN 
WHERE PHAI LIKE N'nam'
--gọi
SELECT * FROM vw_nvNam
--tạo bảng
--3 thủ tục thêm
--1 thủ tục xóa
-- 1 hàm ,1 view