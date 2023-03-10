--1 trigger for: insert update delete
--cú pháp
 CREATE TRIGGER ten_trigger ON tenbang
 FOR [DELETE/ INSERT/ UPDATE]
 AS 
 các lệnh
 GO 
 USE QLDA
 GO


 --vd1 trigger insert kiểm tra dữ liệu chèn vào bảng nhnaa viên có lương > 5000
 IF OBJECT_ID('tg_insert_NhanVien') IS NOT NULL 
 DROP TRIGGER tg_insert_NhanVien
 GO
 CREATE TRIGGER tg_insert_NhanVien ON NhanVien
 FOR INSERT
 AS 
 IF EXISTS (SELECT * FROM Inserted WHERE Inserted.LUONG < 5000)
 BEGIN
     PRINT N'lương phải lớn hơn 50000'
	 ROLLBACK TRAN
 END
 INSERT INTO dbo.NHANVIEN
 (
     HONV,
     TENLOT,
     TENNV,
     MANV,
     NGSINH,
     DCHI,
     PHAI,
     LUONG,
     MA_NQL,
     PHG
 )
 VALUES
 (   N'đinh',       -- HONV - nvarchar(15)
     N'quỳnh',       -- TENLOT - nvarchar(15)
     N'như',       -- TENNV - nvarchar(15)
     N'018',       -- MANV - nvarchar(9)
     '2000-1-2', -- NGSINH - datetime
     N'hà nội',       -- DCHI - nvarchar(30)
     N'nữ',       -- PHAI - nvarchar(3)
     5000000,       -- LUONG - float
     N'006',       -- MA_NQL - nvarchar(9)
     4          -- PHG - int
     )

	 --vd2
	  IF OBJECT_ID('tg_update_NhanVien') IS NOT NULL 
 DROP TRIGGER tg_update_NhanVien
 GO
 CREATE TRIGGER tg_update_NhanVien ON dbo.NHANVIEN
 FOR UPDATE AS 
 IF EXISTS (SELECT * FROM Inserted WHERE Inserted.LUONG< 5000)
 BEGIN
      PRINT N'lương phải lớn hơn 50000'
	 ROLLBACK TRAN
 END
 UPDATE dbo.NHANVIEN SET LUONG =1 WHERE MANV LIKE '001'

 	 --vd3
	  IF OBJECT_ID('tg_delete_NhanVien') IS NOT NULL 
 DROP TRIGGER tg_delete_NhanVien
 GO

 CREATE TRIGGER tg_delete_NhanVien ON dbo.NHANVIEN
 FOR DELETE AS 
 IF  EXISTS (SELECT * FROM Deleted WHERE Deleted.MANV LIKE '018' )
 BEGIN
     PRINT N'không thể xóa'
	 ROLLBACK TRAN
 END
 DELETE FROM dbo.NHANVIEN WHERE MANV LIKE '018'

 SELECT * FROM dbo.NHANVIEN

 	  IF OBJECT_ID('tg_deleteHCM_NhanVien') IS NOT NULL 
 DROP TRIGGER tg_deleteHCM_NhanVien
 GO

 CREATE TRIGGER tg_deleteHCM_NhanVien ON dbo.NHANVIEN
 FOR DELETE AS 
 IF  EXISTS (SELECT * FROM Deleted WHERE Deleted.DCHI LIKE N'%TP HCM%' )
 BEGIN
     PRINT N'không thể xóa'
	 ROLLBACK TRAN
 END
 DELETE FROM dbo.NHANVIEN WHERE PHAI LIKE N'nam'
 go
  CREATE TRIGGER ten_trigger ON tenbang
 after [DELETE/ INSERT/ UPDATE]
 AS 
 các lệnh
 GO 
 IF OBJECT_ID('tg_after_delete_nv') IS NOT NULL
 DROP TRIGGER tg_after_delete_nv 
 GO
  CREATE TRIGGER tg_after_delete_nv ON dbo.NHANVIEN 
  AFTER DELETE AS 
  BEGIN
      DECLARE @num NVARCHAR
	  SELECT @num = count (*) FROM Deleted
	  PRINT N'số nhân viên đã xóa: '+ @num
  END
  DELETE FROM dbo.NHANVIEN WHERE MANV LIKE '018'

  IF OBJECT_ID('tg_isteadof_delete') IS NOT NULL
  DROP TRIGGER tg_isteadof_delete
  GO
  CREATE TRIGGER tg_isteadof_delete
  ON dbo.NHANVIEN INSTEAD OF DELETE AS 
  BEGIN
      DELETE FROM dbo.THANNHAN 
	  WHERE MA_NVIEN IN (SELECT Deleted.MANV FROM Deleted)
	  DELETE FROM dbo.NHANVIEN WHERE MANV IN(SELECT MANV FROM Deleted)
  END
  DELETE FROM dbo.NHANVIEN WHERE MANV LIKE '001'