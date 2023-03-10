CREATE DATABASE QLKH;
USE QLKH;
GO
CREATE TABLE KhachHang
(
    Makh VARCHAR(10) PRIMARY KEY,
    tenkh NVARCHAR(30),
    diachi NVARCHAR(30),
    dienThoai VARCHAR(15),
    gioitinh NVARCHAR(5)
);
CREATE TABLE DonDH
(
    MaDH VARCHAR(10) PRIMARY KEY,
    ngaydh DATE,
    ngaygh DATE,
    Makh VARCHAR(10)
        REFERENCES dbo.KhachHang (Makh)
);

--2
IF OBJECT_ID('sp_donhang') IS NOT NULL
    DROP PROC sp_donhang;
GO
CREATE PROC sp_donhang
    @MaDH VARCHAR(10) = NULL,
    @ngaydh DATE = NULL,
    @ngaygh DATE = NULL,
    @Makh VARCHAR(10) = NULL
AS
BEGIN
    BEGIN TRY
        IF @MaDH IS NULL
            PRINT N'madh không được để trống';
        ELSE
        BEGIN
            INSERT INTO dbo.DonDH
            VALUES
            (@MaDH, @ngaydh, @ngaygh, @Makh);
            PRINT 'success';
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

IF OBJECT_ID('sp_khachhang') IS NOT NULL
    DROP PROC sp_khachhang;
GO
CREATE PROC sp_khachhang
    @Makh VARCHAR(10) = NULL,
    @tenkh NVARCHAR(30) = NULL,
    @diachi NVARCHAR(30) = NULL,
    @dienThoai VARCHAR(15) = NULL,
    @gioitinh NVARCHAR(5) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Makh IS NULL
            PRINT N'makh không được để trống';
        ELSE
        BEGIN
            INSERT INTO dbo.KhachHang
            VALUES
            (@Makh, @tenkh, @diachi, @dienThoai, @gioitinh);
            PRINT 'success';
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO

EXEC dbo.sp_khachhang 'KH1', N'chung', N'hà nội', '03343534', N'nam';

EXEC dbo.sp_khachhang 'kh02', N'lan', N'hà nam', '0328667454', N'nữ';
GO
EXEC dbo.sp_donhang 'Dh03', '2020-12-20', '2020-12-22', 'kh01';
EXEC dbo.sp_donhang 'Dh01', '2021-05-18', '2021-06-05', 'kh02';
--3
IF OBJECT_ID('fc_kh') IS NOT NULL
    DROP FUNCTION fc_kh;
GO
CREATE FUNCTION fc_kh
(
    @makh VARCHAR(10)
)
RETURNS INT
AS
BEGIN
    RETURN
    (
        SELECT COUNT(MaDH) FROM dbo.DonDH WHERE Makh = @makh
    );
END;
GO

DECLARE @tong INT;
SELECT @tong = dbo.fc_kh('KH01');
SELECT @tong;
--4
IF OBJECT_ID('SP_xoatt') IS NOT NULL
    DROP PROC SP_xoatt;
GO
CREATE PROC SP_xoatt @makh VARCHAR(10)
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
        DELETE FROM dbo.DonDH
        WHERE Makh = @makh;
        DELETE FROM dbo.KhachHang
        WHERE Makh = @makh;
        PRINT 'success';
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        ROLLBACK TRAN;
    END CATCH;
END;
EXEC dbo.SP_xoatt 'kh01';

--5
IF OBJECT_ID('SP_timtt') IS NOT NULL
    DROP PROC SP_timtt;
GO
CREATE PROC SP_timtt
    @minND DATETIME = NULL,
    @maxND DATETIME = NULL
AS
BEGIN
    BEGIN TRY
        SELECT KhachHang.Makh,
               IIF(gioitinh LIKE N'nam', N'anh' + tenkh, N'chị' + tenkh) AS tenkh,
               diachi,
               MaDH,
               CONVERT(NVARCHAR, ngaydh, 103) AS ngaydh,
               CONVERT(NVARCHAR, ngaygh, 103) AS ngaygh
        FROM dbo.DonDH
            JOIN dbo.KhachHang
                ON KhachHang.Makh = DonDH.Makh --103 dd/mm/yyyy
        WHERE ngaydh
        BETWEEN @minND AND @maxND;
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;

END;
EXEC dbo.SP_timtt '2021-01-01', '2022-06-06';


SELECT *
FROM dbo.KhachHang;
SELECT *
FROM dbo.DonDH;


