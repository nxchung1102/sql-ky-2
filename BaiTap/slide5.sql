USE QLDA 
GO
--cú pháp thủ tục
--CREATE PROC tên thủ tục 
--@tham số kiểuDL OUT  --out: tham số đầu ra
--AS BEGIN
--các lệnh sử lý
--END
--vd1 xây dựng thủ tục tính tổng 2 số  đầu vào không có đầu ra
CREATE PROC total 
@a INT,@b INT 
AS 
BEGIN 
DECLARE @total INT 
SET @total = @a+@b
PRINT 'total: '+ CAST(@total AS NVARCHAR)
END
--gọi thủ tục:
--cú pháp 
--EXEC tên thủ tục -- trường hợp không có tham số
--EXEC tên thủ tục gtri1,gtri2 -- trường hợp có 2 tham số 
EXEC dbo.total 7,8 --truyền gtri theo vitri

EXEC dbo.total @a = 5, 
               @b = 6  -- truyền gtri theo tham số
EXEC dbo.total @a = 6, 
			   @b = 5  
			   --vd2 xây dựng thục thủ tính tổng 2 số có 2 tham số đầu vào, có đầu ra
GO
IF OBJECT_ID('tong') IS NOT NULL
DROP PROC tong
go
CREATE PROC tong @so1 INT,@so2 INT, @result INT OUT 
AS 
BEGIN 

SET @result = @so1+@so2
END


DECLARE @kq INT 
EXEC tong 2,5,@kq OUT 
SELECT @kq

GO
 CREATE PROC tong_rt --tổng có return
 @so1 INT, @so2 INT 
 AS 
 BEGIN 
 RETURN @so1+@so2
 END
 DECLARE @nhan INT EXEC @nhan = tong_rt 2,3
  
GO 
IF OBJECT_ID('totalpd ')IS NOT NULL
DROP PROC totalpd
go
CREATE PROC totalpd 
@a INT=5,@b INT=6 
AS 
BEGIN 
DECLARE @tongpd INT 
SET @tongpd = @a+@b
PRINT 'total: '+ CAST(@tongpd AS NVARCHAR)
END
EXEC dbo.totalpd 
GO

--vd5 tạo thủ tục truy xuất nv theo mã nv
IF OBJECT_ID('find')IS NOT NULL
DROP PROC find
GO
CREATE PROC find @maNv NVARCHAR(9)
AS 
BEGIN 
SELECT * FROM dbo.NHANVIEN 
WHERE MANV LIKE @maNv
END

EXEC dbo.find '005'
EXEC dbo.find @maNv = N'005' 

GO
--vd6 tạo thủ tục có đầu vào là MaDa , cho biết số lượng  nhân viên tham gia đề án đó
--c1 dùng RETURN
--c2 dùng ouput
IF OBJECT_ID('findDA')IS NOT NULL
DROP PROC findDA
GO
CREATE PROC findDA @maDA int, @xuat int OUT 
AS 
BEGIN
SELECT @xuat = COUNT(MA_NVIEN)FROM dbo.DEAN JOIN dbo.PHANCONG
ON PHANCONG.MADA = DEAN.MADA JOIN dbo.NHANVIEN 
ON NHANVIEN.MANV = PHANCONG.MA_NVIEN
WHERE DEAN.MADA = @maDA
END 
DECLARE @kq int 
EXEC findDA 1,@kq OUT
SELECT @kq AS slNV

go
IF OBJECT_ID('findDA')IS NOT NULL
DROP PROC findDA
go
CREATE PROC findDA @maDA int
AS 
BEGIN
DECLARE @xuat int 
SELECT @xuat = COUNT(MA_NVIEN)FROM dbo.PHANCONG
WHERE MA_NVIEN = @maDA 
RETURN @xuat
END 
DECLARE @slnv INT = @xuat 
SELECT @slnv





			   
