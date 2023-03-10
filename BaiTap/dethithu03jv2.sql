CREATE DATABASE QLDA2;
GO
USE QLDA2;
GO
CREATE TABLE DuAn
(
    MaDA VARCHAR(10) PRIMARY KEY NOT NULL,
    TenDA NVARCHAR(30) NOT NULL,
    DDiemDA NVARCHAR(30)
);
CREATE TABLE NhanVien
(
    MaNV VARCHAR(10) PRIMARY KEY NOT NULL,
    HoTenNV NVARCHAR(30) NOT NULL,
    GioiTinh NVARCHAR(5),
    Luong MONEY
);
CREATE TABLE CTDA
(
    MaNV VARCHAR(10) NOT NULL
        REFERENCES dbo.NhanVien (MaNV),
    MaDA VARCHAR(10) NOT NULL
        REFERENCES dbo.DuAn (MaDA),
    Sogio INT,
    PRIMARY KEY (
                    MaNV,
                    MaDA
                )
);

--2
IF OBJECT_ID('sp_insertNV') IS NOT NULL
    DROP PROC sp_insertNV;
GO
CREATE PROC sp_insertNV
    @MaNV VARCHAR(10) = NULL,
    @HoTenNV NVARCHAR(30) = NULL,
    @GioiTinh NVARCHAR(5) = NULL,
    @Luong MONEY = NULL
AS
BEGIN
    BEGIN TRY
        IF @MaNV IS NULL
           OR @HoTenNV IS NULL
            PRINT N'không được để trống maNV va Hoten';
        ELSE
        BEGIN
            INSERT INTO dbo.NhanVien
            VALUES
            (@MaNV, @HoTenNV, @GioiTinh, @Luong);
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;




GO
IF OBJECT_ID('sp_insertDA') IS NOT NULL
    DROP PROC sp_insertDA;
GO
CREATE PROC sp_insertDA
    @MaDA VARCHAR(10) = NULL,
    @TenDA NVARCHAR(30) = NULL,
    @DDiemDA NVARCHAR(30) = NULL
AS
BEGIN
    BEGIN TRY
        IF @MaDA IS NULL
           OR @TenDA IS NULL
            PRINT N'MaDA va TenDA khong duoc de trong';
        ELSE
        BEGIN
            INSERT INTO dbo.DuAn
            VALUES
            (@MaDA, @TenDA, @DDiemDA);
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
IF OBJECT_ID('sp_insertCTDA') IS NOT NULL
    DROP PROC sp_insertCTDA;
GO
CREATE PROC sp_insertCTDA
    @MaNV VARCHAR(10) = NULL,
    @MaDA VARCHAR(10) = NULL,
    @Sogio INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @MaDA IS NULL
           OR @MaNV IS NULL
            PRINT N'khong duoc de trong MaDA va MaNV';
        ELSE
        BEGIN
            INSERT INTO dbo.CTDA
            VALUES
            (@MaNV, @MaDA, @Sogio);
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC dbo.sp_insertDA 'DA1', N'Chế tạo bom', N'hà nội';
EXEC dbo.sp_insertDA 'DA2', N'xây dựng web', N'hà nam';
EXEC dbo.sp_insertDA 'DA3', N'luyên kim', N'tp.HCM';

-----------------------
EXEC dbo.sp_insertNV 'NV3', N'ngọc', N'nữ', 10000;
EXEC dbo.sp_insertNV 'NV1', N'hoàng', N'nam', 15000;
EXEC dbo.sp_insertNV 'NV2', N'phúc', N'nam', 18000;
-------------------------
EXEC dbo.sp_insertCTDA 'NV3', 'DA1', 10;
EXEC dbo.sp_insertCTDA 'NV2', 'DA3', 8;
EXEC dbo.sp_insertCTDA 'NV1', 'DA2', 10;

--3
IF OBJECT_ID('fc_nv') IS NOT NULL
    DROP FUNCTION fc_nv;
GO
CREATE FUNCTION fc_nv
(
    @HoTenNV NVARCHAR(30),
    @GioiTinh NVARCHAR(5),
    @Luong MONEY
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM dbo.NhanVien
    WHERE HoTenNV = @HoTenNV
          AND GioiTinh = @GioiTinh
          AND Luong = @Luong
);
GO

SELECT *
FROM dbo.fc_nv(N'hoàng', N'nam', 15000);
--3a
IF OBJECT_ID('fc_DA') IS NOT NULL
    DROP FUNCTION fc_DA;
GO
CREATE FUNCTION fc_DA
(
    @TenDA NVARCHAR(30),
    @DDiemDA NVARCHAR(30)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM dbo.DuAn
    WHERE TenDA = @TenDA
          AND DDiemDA = @DDiemDA
);
GO
SELECT *
FROM dbo.fc_DA(N'Chế tạo bom', N'hà nội');

--4
IF OBJECT_ID('vw_nv') IS NOT NULL
    DROP VIEW vw_nv;
GO
CREATE VIEW vw_nv
AS
SELECT TOP 2
       CTDA.MaNV,
       HoTenNV,
       GioiTinh,
       SUM(Sogio) AS tongsogio
FROM dbo.CTDA
    JOIN dbo.NhanVien
        ON NhanVien.MaNV = CTDA.MaNV
GROUP BY CTDA.MaNV,
         HoTenNV,
         GioiTinh
ORDER BY SUM(Sogio) DESC;
GO
SELECT *
FROM dbo.vw_nv;
--4a
IF OBJECT_ID('vw_nv2') IS NOT NULL
    DROP VIEW vw_nv2;
GO
CREATE VIEW vw_nv2
AS
SELECT TOP 2
       CTDA.MaDA,
       TenDA,
       COUNT(MaNV) AS tongSoNV
FROM dbo.CTDA
    JOIN dbo.DuAn
        ON DuAn.MaDA = CTDA.MaDA
GROUP BY CTDA.MaDA,
         TenDA
ORDER BY tongSoNV DESC;
GO
SELECT *
FROM dbo.vw_nv2;
--5
IF OBJECT_ID('sp_xoa') IS NOT NULL
    DROP PROC sp_xoa;
GO
CREATE PROC sp_xoa @manv VARCHAR(10) = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
        DELETE FROM dbo.CTDA
        WHERE MaNV LIKE @manv;
        DELETE FROM dbo.NhanVien
        WHERE MaNV LIKE @manv;
        COMMIT TRAN;
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        ROLLBACK TRAN;
    END CATCH;
END;
GO
EXEC dbo.sp_xoa 'nv2';
SELECT *
FROM dbo.NhanVien;
--6
IF OBJECT_ID('sp_delLuong') IS NOT NULL
    DROP PROC sp_delLuong;
GO
CREATE PROC sp_delLuong @luong MONEY = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
        DECLARE @bang TABLE
        (
            maNV VARCHAR(10)
        );
        INSERT INTO @bang
        SELECT MaNV
        FROM dbo.NhanVien
        WHERE Luong < @luong;
        DELETE FROM dbo.CTDA
        WHERE MaNV IN
              (
                  SELECT * FROM @bang
              );
        DELETE FROM dbo.NhanVien
        WHERE Luong < @luong;
        COMMIT TRAN;
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        ROLLBACK TRAN;
    END CATCH;
END;

GO
EXEC dbo.sp_delLuong 11000;
SELECT *
FROM dbo.NhanVien;
