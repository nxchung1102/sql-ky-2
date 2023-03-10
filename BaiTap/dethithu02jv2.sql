CREATE DATABASE QLSVJV2;
GO
USE QLSVJV2;
GO
CREATE TABLE sinhvien
(
    Masv VARCHAR(10) PRIMARY KEY NOT NULL,
    hoten NVARCHAR(30) NOT NULL,
    ngsinh DATE,
    gioitinh NVARCHAR(30),
    lop NVARCHAR(30)
);
CREATE TABLE diem
(
    Masv VARCHAR(10)
        REFERENCES dbo.sinhvien (Masv) NOT NULL,
    MaMH VARCHAR(10) NOT NULL,
    diemL1 FLOAT,
    diemL2 FLOAT,
    PRIMARY KEY (
                    Masv,
                    MaMH
                )
);
GO
IF OBJECT_ID('sp_insertSV') IS NOT NULL
    DROP PROC sp_insertSV;
GO
CREATE PROC sp_insertSV
    @Masv VARCHAR(10) = NULL,
    @hoten NVARCHAR(30) = NULL,
    @ngsinh DATE = NULL,
    @gioitinh NVARCHAR(30) = NULL,
    @lop NVARCHAR(30) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Masv IS NULL
            PRINT N'khong duoc de trong masv';
        ELSE
            INSERT INTO dbo.sinhvien
            VALUES
            (@Masv, @hoten, @ngsinh, @gioitinh, @lop);
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
IF OBJECT_ID('sp_insertD') IS NOT NULL
    DROP PROC sp_insertD;
GO
CREATE PROC sp_insertD
    @Masv VARCHAR(10) = NULL,
    @MaMH VARCHAR(10) = NULL,
    @diemL1 FLOAT = NULL,
    @diemL2 FLOAT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Masv IS NULL
           OR @MaMH IS NULL
            PRINT N'khong duoc de trong masv,maMH';
        ELSE
            INSERT INTO dbo.diem
            VALUES
            (@Masv, @MaMH, @diemL1, @diemL2);

        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO
EXEC dbo.sp_insertSV 'sv1', 'chung', '2002-07-21', N'nam', N'tin học';
EXEC dbo.sp_insertSV 'sv2', 'lan', '2004-08-15', N'nữ', N'hóa học';

EXEC dbo.sp_insertD 'sv1', 'MHT', 8.5, 9;
EXEC dbo.sp_insertD 'sv2', 'MHH', 7.5, 8;

--3
IF OBJECT_ID('fc_sv') IS NOT NULL
    DROP FUNCTION fc_sv;
GO
CREATE FUNCTION fc_sv
(
    @hoten NVARCHAR(30) = NULL,
    @ngsinh DATE = NULL,
    @gioitinh NVARCHAR(30) = NULL,
    @lop NVARCHAR(30) = NULL
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM dbo.sinhvien
    WHERE hoten = @hoten
          AND ngsinh = @ngsinh
          AND gioitinh = @gioitinh
          AND lop = @lop
);
GO
SELECT *
FROM dbo.fc_sv('chung', '2002-07-21', N'nam', N'tin học');
GO
--4
IF OBJECT_ID('sp_del') IS NOT NULL
    DROP PROC sp_del;
GO
CREATE PROC sp_del @kqthi FLOAT = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
        DECLARE @bang TABLE
        (
            masv VARCHAR(10)
        );
        INSERT INTO @bang
        SELECT Masv
        FROM dbo.diem
        WHERE diemL1 < @kqthi;
        DELETE FROM dbo.diem
        WHERE diemL1 < @kqthi;
        DELETE FROM dbo.sinhvien
        WHERE Masv IN
              (
                  SELECT * FROM @bang
              );
        COMMIT TRAN;
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        ROLLBACK TRAN;
    END CATCH;
END;
GO


EXEC dbo.sp_del @kqthi = 8;

SELECT *
FROM dbo.sinhvien;
SELECT *
FROM dbo.diem;
GO
--5
IF OBJECT_ID('vw_top2') IS NOT NULL
    DROP VIEW vw_top2;
GO
CREATE VIEW vw_top2
AS
SELECT TOP 2
       hoten,
       diem.Masv,
       COUNT(MaMH) AS somonthi
FROM dbo.diem
    JOIN dbo.sinhvien
        ON sinhvien.Masv = diem.Masv
GROUP BY hoten,
         diem.Masv
ORDER BY somonthi DESC;
GO

SELECT *
FROM dbo.vw_top2;




