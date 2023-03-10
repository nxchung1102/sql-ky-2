--vd1 khai báo biến điểm và gán giá trị cho điểm 
--lý luận xếp loại theo miền nếu điểm <5 thì trượt còn lại đạt
--print xếp loại
USE QLDA
GO
DECLARE @diem FLOAT
SET @diem = 6.5
IF @diem < 5
PRINT N'xếp loại: trượt'
ELSE PRINT N'xếp loại: đạt'

go
--vd2 lý luận theo miền sau 
-- if diem <5: trượt
-- if diem <5 - <6: tb
-- if diem <6 - <7 tb khá
-- if diem <7 - <8 khá
-- if diem <8 - <9 giỏi
-- còn lại xuất sắc

dECLARE @diem FLOAT
SET @diem = 11
IF (@diem<5) PRINT N'xếp loại: trượt'
ELSE IF  (@diem<6) PRINT N'xếp loại: tb'
ELSE IF (@diem<7) PRINT N'xếp loại: tb khá'
ELSE IF (@diem<8) PRINT N'xếp loại: khá'
ELSE IF (@diem<9) PRINT N'xếp loại: giỏi'
ELSE  PRINT N'xếp loại: xuất sắc'
GO
--nếu tồn tại nhân viên  lương > 50000 thì xuất ds nhân viên này
-- ngước lai không có nv nào lương > 50000
IF EXISTS (SELECT * FROM dbo.NHANVIEN WHERE LUONG > 50000)
BEGIN
PRINT N'ds nhân viên lương > 50000'
SELECT * FROM dbo.NHANVIEN WHERE LUONG > 50000
 END
 ELSE PRINT N' không có nv nào lương > 50000'
 GO

 -- cú pháp iif (đk , đk đúng, đk sai)
 --vd3 lấy tt nv maNV, tenNV,luong,chucVu
 --Trong đó nếu lương > 30000 thì chức vụ là trưởng phòng còn lại là nhân viên
 SELECT MANV,TENNV,LUONG, IIF (LUONG>30000,N'trưởng phòng',N'nhân viên') AS N'chức vụ' FROM dbo.NHANVIEN
GO
--vd CASE
--cú pháp simple case 
--case <biểu thức>
--WHEN <gtri1>THEN <kq1>
--WHEN <gtri2>THEN <kq2>
--...
--ELSE <kqn>
--END
-- cho biết thông tin nv và gtinh của họ : maNV, phai,lienhe
--trong do lienHe
-- phai là nam thì ghi mr.
-- phai là nữ thì ghi ms.
-- còn lại ghi free
SELECT 
MANV,PHAI, CASE PHAI WHEN N'nam' THEN 'mr.'+TENNV
WHEN N'nữ' THEN 'ms.'+TENNV
ELSE 'free'
END AS N'liên hệ'
FROM dbo.NHANVIEN
go
--vd searched case 
-- cú pháp searched case
--CASE 
--WHEN <dk1> THEN <kq1>
--WHEN <dk2> THEN <kq2>
--...
--WHEN <dkn> THEN <kqn>
--END

SELECT 
MANV,PHAI, CASE  WHEN PHAI = N'nam' THEN 'mr.'+TENNV
WHEN PHAI = N'nữ' THEN 'ms.'+TENNV
ELSE 'free'
END AS N'liên hệ'
FROM dbo.NHANVIEN
GO
--vd loop
--vd1 tính tổng các số 1-10
DECLARE @total INT = 0 , @count INT =0
WHILE @count <= 10
BEGIN
SET @total = @total + @count
SET @count = @count+1
END
PRINT CAST(@total AS NVARCHAR)
GO

--vd try catch
--*cú pháp
--BEGIN TRY 
--nội dung
--END TRY
--BEGIN CATCH
--xử lý lỗi
--END CATCH
BEGIN TRY
PRINT N'điểm của tới'+ -10
END TRY
BEGIN CATCH
 PRINT N'Mã lỗi: '+ CAST(ERROR_NUMBER() AS NVARCHAR)
 PRINT N'Tên lỗi: '+ CONVERT(NVARCHAR , ERROR_MESSAGE())
 END CATCH
 GO
 
 --vd2 thục hiện chèn thêm 1 dòng dữ liệu vào bảng phongban theo 2 bước 
-- nhận thông báo thêm dữ liệu thành công từ khối try
-- chèn sai dữ liệu có thông báo thêm dữ liệu thất bại từ khối catch
BEGIN TRY 
INSERT INTO dbo.PHONGBAN
(
    TENPHG,
    MAPHG,
    TRPHG,
    NG_NHANCHUC
)
VALUES
(   N'hóa học',    3,       N'006', '1890-01-19' )
	PRINT N'thêm dữ liệu thành công'
END TRY
BEGIN CATCH
--PRINT N'thêm dữ liệu thất bại'
--PRINT N'gặp lỗi: '+ ERROR_MESSAGE()

RAISERROR(N'thêm dữ liệu thất bại',1,1)
END CATCH
GO
--vd raiserror 