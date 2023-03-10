CREATE DATABASE CTYBIA
USE CTYBIA
go
CREATE TABLE LOHANG (
MALOHANG VARCHAR(10)PRIMARY KEY NOT NULL,
NGAYSX DATE
)
CREATE TABLE SanPham
(
MASP VARCHAR(10) PRIMARY KEY NOT NULL,
TENSP NVARCHAR(30),
MALOHANG VARCHAR(10)REFERENCES dbo.LOHANG(MALOHANG) NOT NULL,
DONGIA MONEY
)

INSERT INTO dbo.LOHANG
(
    MALOHANG,
    NGAYSX
)
VALUES
('LH01','2022-02-12'),
('LH02','2022-05-20'),
('LH03','2022-07-21')
INSERT INTO dbo.SanPham
(
    MASP,
    TENSP,
    MALOHANG,
    DONGIA
)
VALUES
('SP01','hainiken','LH03',50000),
('SP02','saigon','LH01',20000),
('SP03','tiger','LH02',100000)

--bai2
IF OBJECT_ID('sp_lohang') IS NOT NULL
DROP PROC sp_lohang
GO
CREATE PROC sp_lohang
	@MALOHANG VARCHAR (10) = NULL,
	@NGAYSX DATE = NULL
	AS 
	BEGIN
	    BEGIN TRY
		IF(@MALOHANG IS  NULL OR RTRIM(LTRIM(@MALOHANG)) LIKE '')
		PRINT N'malohang khong duoc de trong'
		ELSE IF EXISTS (SELECT * FROM dbo.LOHANG WHERE MALOHANG LIKE @MALOHANG)
		PRINT N'malohang da co roi, khong duoc them'
		ELSE
		BEGIN
		INSERT INTO dbo.LOHANG

		VALUES
		(
		    @MALOHANG,
		    @NGAYSX
		)
		PRINT N'thanh cong'
		    
		END
        END TRY
		BEGIN CATCH
		PRINT N'loi them du lieu'+ ERROR_MESSAGE()
		END CATCH
	END
	EXEC dbo.sp_lohang 'LH04','2023-12-12'
	--bai3
	IF OBJECT_ID('sp_SanPham')IS NOT NULL
	DROP PROC sp_SanPham
	GO
    CREATE PROC sp_SanPham
		@MASP VARCHAR (10) = NULL,
	@TENSP NVARCHAR (30) = NULL,
	@MALOHANG VARCHAR (10) = NULL,
	@DONGIA MONEY = NULL
	AS
	BEGIN
	    BEGIN TRY 
		IF(@MASP IS NULL OR @MALOHANG IS NULL)
		PRINT N'khong duoc de trong masp va malohang'
		ELSE IF EXISTS (SELECT * FROM dbo.SanPham WHERE MASP LIKE @MASP)
		PRINT N'masp da co roi, khong duoc trung'
		ELSE IF EXISTS (SELECT * FROM dbo.SanPham WHERE  @DONGIA <= 0)
		PRINT N'Dongia phai > 0'
		ELSE
		BEGIN
		    INSERT INTO dbo.SanPham
		    VALUES
					    (
		        @MASP,
		        @TENSP,
		        @MALOHANG,
		        @DONGIA
		    )
			PRINT N'thanh cong'
		END
		END TRY
		BEGIN CATCH
		PRINT N'loi them du lieu: '+ ERROR_MESSAGE()
		END CATCH
	END
	EXEC dbo.sp_SanPham 'SP06','333','LH03',0
	SELECT * FROM dbo.SanPham
	--update
	--bai4
	GO
	IF OBJECT_ID('sp_updateSanPham') IS NOT NULL
	DROP PROC sp_updateSanPham
	GO
    CREATE PROC sp_updateSanPham
			@MASP VARCHAR (10) = NULL,
	@TENSP NVARCHAR (30) = NULL,
	@MALOHANG VARCHAR (10) = NULL,
	@DONGIA MONEY = NULL
	AS BEGIN
	       BEGIN TRY
		   IF (@TENSP IS NULL OR @DONGIA IS NULL)
		   PRINT N'tensp va dongia khong duoc de trong'
		  ELSE IF EXISTS (SELECT * FROM dbo.SanPham WHERE  @DONGIA <= 0)
		  PRINT N'Dongia phai > 0'
		  ELSE BEGIN
		  UPDATE dbo.SanPham
		  SET TENSP = @TENSP,
		  DONGIA = @DONGIA
		  WHERE MASP = @MASP
		  PRINT N'thanh cong'
		  END
		   END TRY
		   BEGIN CATCH
		   PRINT N'loi: '+ ERROR_MESSAGE()
		   END CATCH
	   END
	   EXEC dbo.sp_updateSanPham 'SP04',N'333','LH03',1000
	   SELECT * FROM dbo.SanPham
	   GO
	   --bai5 truy van
       IF OBJECT_ID('sp_getSanPham')IS NOT NULL
	   DROP PROC sp_getSanPham
	   GO
       CREATE PROC sp_getSanPham
	AS
	BEGIN
	    BEGIN TRY
		DECLARE @ltb MONEY
		SELECT @ltb = AVG(DONGIA) FROM dbo.SanPham
		SELECT TENSP,YEAR(CONVERT(NVARCHAR,NGAYSX)) FROM dbo.SanPham JOIN dbo.LOHANG ON LOHANG.MALOHANG = SanPham.MALOHANG
		WHERE DONGIA > @ltb
		PRINT N'thanh cong'
		END TRY
		BEGIN CATCH
		PRINT N'loi: '+ ERROR_MESSAGE()
		END CATCH
	END
	EXEC dbo.sp_getSanPham
	GO
    --bai6 del
	IF OBJECT_ID('sp_deleteLoHang') IS NOT NULL
	DROP PROC sp_deleteLoHang
	GO
    CREATE PROC sp_deleteLoHang
	@malohang VARCHAR(10) = null
	AS
	BEGIN
	    BEGIN TRY 
		BEGIN TRAN
			DELETE FROM dbo.SanPham WHERE MALOHANG LIKE @malohang
		DELETE FROM dbo.LOHANG WHERE MALOHANG LIKE @malohang
		COMMIT TRAN
		PRINT 'sucess'
		END TRY
		BEGIN CATCH
		PRINT ERROR_MESSAGE()
		ROLLBACK TRAN
		END CATCH
	END
	EXEC dbo.sp_deleteLoHang 'LH03'
	SELECT * FROM dbo.LOHANG
	SELECT * FROM dbo.SanPham
	   