USE QLDA
GO
-- SELECT 'today is'+ GETDATE()
--không chuyển đổi được vì chuỗi k về được date
--giải quyết
SELECT'today is '+ CAST(GETDATE()AS VARCHAR)
--* cú pháp: cast(biểu thức as kiểu dữ liệu)


--vd2
--dùng hàm covert
--* cú pháp: convert(kiểu dữ liệu ,biểu thức [,định dạng])
SELECT'today is '+ CONVERT(VARCHAR,GETDATE(),101)
--dd/mm/yyyy

SELECT'today is '+ CONVERT(VARCHAR,GETDATE(),103)
--mm/dd/yyyy

SELECT'today is '+ CONVERT(VARCHAR,GETDATE(),105)
--dd-mm-yyyy

SELECT'today is '+ CONVERT(VARCHAR,GETDATE(),107)
--(english)mm dd yyyy

SELECT'today is '+ CONVERT(VARCHAR,GETDATE(),110)
--mm-dd-yyyy

SELECT MANV,HONV+' '+TENLOT+' '+TENNV AS hoten,NGSINH,
CONVERT(VARCHAR,NGSINH,101) AS'mm/dd/yyyy',
CONVERT(VARCHAR,NGSINH,103) AS'dd/mm/yyyy',
CONVERT(VARCHAR,NGSINH,105)AS'dd-mm-yyyy',
CONVERT(VARCHAR,NGSINH,107),
CONVERT(VARCHAR,NGSINH,110)AS'mm-dd-yyyy'
FROM dbo.NHANVIEN

--vd3
DECLARE @money MONEY = 2498099.7653
SELECT @money,
CONVERT(VARCHAR,@money) AS khongDinhDang,--2498099.77
CONVERT(VARCHAR,@money,1) AS DinhDang1,--2,498,099.77
CONVERT(VARCHAR,@money,2) AS DinhDang2--2498099.7653

go
--2 các hàm toán học
--vd1
SELECT SQRT(25) AS can5, PI()AS soPI
--căn và pi

--vd2
DECLARE @money MONEY = 2498099.7653
SELECT @money, ROUND(@money,1)AS tron1,
			   ROUND(@money,2)AS tron2
--làm tròn 

--vd3
SELECT LEN('FPT Polytechnic') AS DoDaiChuoi, --15
		LEFT('FPT Polytechnic',3) AS fpt,
		RIGHT('FPT Polytechnic',7)AS technic,
		SUBSTRING('FPT Polytechnic',5,4) AS poly
--độ dài & cắt chuỗi

--vd4
SELECT CHARINDEX('er','SQL Server') AS TimTuDau,
		CHARINDEX('er','SQL Server',8) AS TimTuVTri8,
		CHARINDEX('er','SQL Server',10) AS TimTuVTri9
-- find

--vd5
SELECT REPLACE('456,789,123',',','.')AS ThayPhayThanhCham
--replace
--vd 456,789.79 => 456.789,79

--dùng 1 biến trung gian: temp
--b1 . -> temp
SELECT REPLACE('456,789.79','.','temp'),--456,789temp79
--b2 , -> .
 REPLACE(REPLACE('456,789.79','.','temp'),',','.'),--456.789temp79
--b3 temp -> ,
REPLACE( REPLACE(REPLACE('456,789.79','.','temp'),',','.'),'temp',',')--456.789,79

--ass: chuyển giá phòng(money)-> về dạng '456.789.456,87'
--(dấu chấm phân cách phần nghìn)
--dấu phẩy phân cách phân thập phân
--có 2 chữ số sau phần thập phân
