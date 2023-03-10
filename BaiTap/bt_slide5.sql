USE QLDA
GO
IF OBJECT_ID('spInsertPhongBan') IS NOT NULL
DROP PROC spInsertPhongBan
GO
CREATE PROC spInsertPhongBan
	@TENPHG NVARCHAR (15) = NULL,
	@MAPHG INT  = NULL,
	@TRPHG NVARCHAR (9) = NULL,
	@NG_NHANCHUC DATE  = NULL
	AS 
	BEGIN
	BEGIN TRY 
	IF (@TENPHG IS NULL OR @MAPHG IS NULL OR @NG_NHANCHUC IS NULL)
	PRINT 'Khong duoc de trong thong tin TENPHG  end MaPHG end NG_NHANCHUC!'

	      ELSE IF exists (SELECT * FROM dbo.PHONGBAN WHERE MAPHG like @MAPHG)
		PRINT 'TENPHG da co roi ,  khong them duoc'

		         ELSE IF not EXISTS(SELECT * FROM dbo.NHANVIEN WHERE MANV = @TRPHG)
         PRINT 'MAPHG chua co tren bang DIADIEM_PHG, loi khoa ngoai'
		 ELSE 
			BEGIN
 INSERT INTO dbo.PHONGBAN
 
VALUES(	@TENPHG ,
	@MAPHG ,
	@TRPHG ,
	@NG_NHANCHUC)
	  PRINT 'THEM THANH CONG'
			END
	END TRY
	BEGIN CATCH
	PRINT N'lỗi thêm dữ liệu: '+ ERROR_MESSAGE()
	END CATCH
	END
	--gọi thủ tục
	EXEC dbo.spInsertPhongBan @TENPHG = N'vật lý'  ,   -- nvarchar(15)
	                          @MAPHG = 7,      -- int
	                          @TRPHG = N'005',      -- nvarchar(9)
	                          @NG_NHANCHUC = '2023-02-08' -- date
	SELECT * FROM dbo.NHANVIEN 
	SELECT * FROM dbo.PHONGBAN
	--bai2
	IF OBJECT_ID('bai2') IS NOT NULL
DROP PROC bai2
GO

