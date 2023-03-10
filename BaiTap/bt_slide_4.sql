USE QLDA
GO
SELECT * FROM dbo.DEAN
SELECT * FROM dbo.PHANCONG
SELECT * FROM dbo.CONGVIEC
BEGIN TRY 
INSERT INTO dbo.CONGVIEC
(
    MADA,
    STT,
    TEN_CONG_VIEC
)
VALUES
(   10,  -- MADA - int
    6,  -- STT - int
    N'quảng cáo sản phẩm a' -- TEN_CONG_VIEC - nvarchar(50)
    )
	PRINT  N'thêm thành công'
END TRY
BEGIN CATCH
PRINT N'thêm dữ liệu thất bại'
END CATCH

SELECT MANV,TENNV,IIF(PHAI LIKE N'nam',N'mr.',N'mrs.')AS phai,NGSINH,YEAR(GETDATE())-YEAR(NGSINH) AS tuoi, 
CASE 
WHEN 1960 < YEAR(NGSINH)   THEN N'tuổi trẻ'
WHEN 1960 > YEAR(NGSINH) THEN N'tuổi già'
ELSE N'không đúng'
END 
FROM dbo.NHANVIEN


