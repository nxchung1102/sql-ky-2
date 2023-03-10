USE QLBH
GO 
-- T-SQL
-- tạo
--DECLARE @name NVARCHAR(30)
--gán gtri
--c1
--@name = gtri
--c2
--SELECT @name = gtri from...
--truy xuất
--SELECT @name
DECLARE @dai FLOAT, @rong FLOAT, @chuVi FLOAT, @dienTich FLOAT

SET @dai = 5
SELECT @rong = 3
SET @chuVi = (@dai+@rong)*2
SET @dienTich = @dai*@rong

SELECT @chuVi,@dienTich
--in ket qua
PRINT N'chu vi là: '+CONVERT(NVARCHAR(30), @chuVi)--chuyển chu vi về nvarchar
PRINT N'Diện tích là: '+ CAST(@dienTich AS NVARCHAR(30))--chuyển diện tích về nvarchar

USE QLDA
go
--vd 2 cho biết tổng số nhân viên
DECLARE @TongSoNV INT 
--gán gtri
SELECT @TongSoNV = COUNT(MANV)FROM dbo.NHANVIEN
--truy xuất
PRINT N'tổng số NV là: '+CAST(@TongSoNV AS NVARCHAR)






-- biến bảng
--khai báo 
DECLARE @nameTable TABLE   -- sau table cú pháp giống tạo bảng
(
 TenCot1 NVARCHAR,
 TenCot2 INT 
) 







--vd1 tạo bảo chứa các nhân viên nữ: maNV,hoten
DECLARE @NV TABLE(
maNV NVARCHAR(9),
hoten NVARCHAR(47)
)
-- thêm dữ liệu vào biến bảng dữ liệu: lấy các NV nữ của bảng NV
INSERT INTO @NV

SELECT MANV, HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten FROM dbo.NHANVIEN
WHERE PHAI LIKE N'nữ'
 SELECT * FROM @NV

 --truy xuất nối với bảng nhân thân
 SELECT * FROM @NV nv JOIN dbo.THANNHAN tn ON nv.maNV = tn.MA_NVIEN

 UPDATE @NV SET hoten = N'Phạm Văn Đồng'
 WHERE maNV LIKE '006'
 SELECT * FROM @NV




 --c1
 DECLARE @luong FLOAT
 SELECT @luong =SUM(dbo.NHANVIEN.LUONG) FROM dbo.NHANVIEN 
 WHERE dbo.NHANVIEN.PHG = 4
 PRINT N'tổng số lương: '+ +CAST(@luong AS NVARCHAR)
 --c2
 DECLARE @deAn TABLE (
 maDA INT,
 tenDA NVARCHAR(15),
 ddDA NVARCHAR(15)
 )
 INSERT INTO @deAn

 
SELECT MADA,TENDEAN,DDIEM_DA FROM dbo.DEAN  
WHERE dbo.DEAN.PHONG = 4
SELECT * FROM @deAn
