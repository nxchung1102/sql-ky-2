CREATE DATABASE QLNS;
GO
USE QLNS;
GO
CREATE TABLE LOAINHA
(
    MANHA VARCHAR(10) PRIMARY KEY NOT NULL,
    TEN NVARCHAR(30)
);
CREATE TABLE KHACHHANG
(
    ID VARCHAR(10) PRIMARY KEY NOT NULL,
    HOTEN NVARCHAR(30) NOT NULL,
    GIOITINH NVARCHAR(5),
    DIACHI NVARCHAR(30),
    MANHA VARCHAR(10)
        REFERENCES dbo.LOAINHA (MANHA) NOT NULL
);
CREATE TABLE THONGTIN
(
    MANHA VARCHAR(10)
        REFERENCES dbo.LOAINHA (MANHA) NOT NULL,
    ID VARCHAR(10)
        REFERENCES dbo.KHACHHANG (ID) NOT NULL,
    SOTIENCOC MONEY,
    NGAYCOC DATE,
    PRIMARY KEY (
                    MANHA,
                    ID
                )
);
IF OBJECT_ID('sp_iinha') IS NOT NULL
    DROP PROC sp_iinha;
GO
CREATE PROC sp_iinha
    @MANHA VARCHAR(10) = NULL,
    @TEN NVARCHAR(30) = NULL
AS
BEGIN
    BEGIN TRY
        IF @MANHA IS NULL
            PRINT ERROR_MESSAGE();
        ELSE
        BEGIN
            INSERT INTO dbo.LOAINHA
            VALUES
            (@MANHA, @TEN);
            PRINT 'success';
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO

IF OBJECT_ID('sp_iikh') IS NOT NULL
    DROP PROC sp_iikh;
GO
CREATE PROC sp_iikh
    @ID VARCHAR(10) = NULL,
    @HOTEN NVARCHAR(30) = NULL,
    @GIOITINH NVARCHAR(5) = NULL,
    @DIACHI NVARCHAR(30) = NULL,
    @MANHA VARCHAR(10) = NULL
AS
BEGIN
    BEGIN TRY
        IF @ID IS NULL
           OR @HOTEN IS NULL
           OR @MANHA IS NULL
            PRINT ERROR_MESSAGE();
        ELSE
        BEGIN
            INSERT INTO dbo.KHACHHANG
            VALUES
            (@ID, @HOTEN, @GIOITINH, @DIACHI, @MANHA);
            PRINT 'success';
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
GO

IF OBJECT_ID('sp_iiTT') IS NOT NULL
    DROP PROC sp_iiTT;
GO
CREATE PROC sp_iiTT
    @MANHA VARCHAR(10) = NULL,
    @ID VARCHAR(10) = NULL,
    @SOTIENCOC MONEY = NULL,
    @NGAYCOC DATE = NULL
AS
BEGIN
    BEGIN TRY
        IF @MANHA IS NULL
           OR @ID IS NULL
            PRINT ERROR_MESSAGE();
        ELSE
        BEGIN
            INSERT INTO dbo.THONGTIN
            VALUES
            (@MANHA, @ID, @SOTIENCOC, @NGAYCOC);
            PRINT 'success';
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

EXEC dbo.sp_iinha 'NH01', N'biệt thự';
EXEC dbo.sp_iinha 'NH02', N'trung cư';
EXEC dbo.sp_iinha 'NH03', N'nhà trọ';
GO
EXEC dbo.sp_iikh 'KH01', N'chung', N'nam', N'hà nội', 'NH01';
EXEC dbo.sp_iikh 'KH03', N'lan', N'nữ', N'hà nam', 'NH02';
EXEC dbo.sp_iikh 'KH02', N'tới', N'nam', N'hà nội', 'NH03';
GO
EXEC dbo.sp_iiTT 'NH01', 'KH01', 1000, '2022-02-03';
EXEC dbo.sp_iiTT 'NH02', 'KH03', 1000, '2022-10-05';
EXEC dbo.sp_iiTT 'NH03', 'KH02', 1000, '2022-12-10';
--2
IF OBJECT_ID('fc_kh') IS NOT NULL
    DROP FUNCTION fc_kh;
GO
CREATE FUNCTION fc_kh
(
    @ID VARCHAR(10)
)
RETURNS TABLE
AS
RETURN SELECT *
       FROM dbo.KHACHHANG
       WHERE ID = @ID;
GO

SELECT *
FROM dbo.fc_kh('KH01');

--3
IF OBJECT_ID('vw_top3') IS NOT NULL
    DROP VIEW vw_top3;
GO
CREATE VIEW vw_top3
AS
SELECT TOP 3
       THONGTIN.ID,
       HOTEN,
       SUM(SOTIENCOC) tongtiencoc
FROM dbo.THONGTIN
    JOIN dbo.KHACHHANG
        ON KHACHHANG.ID = THONGTIN.ID
GROUP BY THONGTIN.ID,
         HOTEN
ORDER BY SUM(SOTIENCOC) DESC;
GO

SELECT *
FROM dbo.vw_top3;
--4
IF OBJECT_ID('sp_del') IS NOT NULL
    DROP PROC sp_del;
GO
CREATE PROC sp_del
    @MANHA VARCHAR(10) = NULL,
    @ID VARCHAR(10) = NULL,
    @SOTIENCOC MONEY = NULL
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;
		DECLARE @bang TABLE (id VARCHAR(10))
		INSERT INTO @bang
		SELECT ID FROM dbo.THONGTIN
		WHERE @SOTIENCOC < SOTIENCOC AND @ID LIKE ID AND @MANHA LIKE MANHA

        DELETE FROM dbo.THONGTIN
        WHERE  ID IN (SELECT * FROM @bang) 
        DELETE FROM dbo.KHACHHANG
		WHERE ID IN (SELECT * FROM @bang)
        COMMIT TRAN;
        PRINT 'success';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
        ROLLBACK TRAN;
    END CATCH;
END;

EXEC dbo.sp_del 'NH01','KH01',900



