use QLDA
go
--1. Cho biết thông tin về Phòng Ban
select * from PHONGBAN
--2. Cho biết thông tin về Nhân Viên
select * from NHANVIEN
--3. Cho biết thông tin về Công việc
select * from CONGVIEC
--4. Cho biết thông tin về Nhân Viên và phòng Ban của họ: Mã NV, họ tên, ngày sinh, địa
--chỉ, mã phòng, tên phòng, mã trưởng phòng
select MANV,HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten, NGSINH,DCHI,PHONGBAN.MAPHG as MaPhong
,TENPHG, TRPHG as MaTruongPhong 
from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG
--5. Giống câu 4, nhưng chỉ đưa ra thông tin các nhân viên của phòng Nghiên cứu.
select MANV,HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten, NGSINH,DCHI,PHONGBAN.MAPHG as MaPhong
,TENPHG, TRPHG as MaTruongPhong 
from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG
where TENPHG like N'Nghiên Cứu'
--6. Cho biết thông tin về nhân viên và công việc của họ: MaNV, họ tên, mã phòng, Thời
--gian, tên công việcselect MANV,HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten,PHONGBAN.MAPHG as MaPhong, THOIGIAN,TEN_CONG_VIEC  from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIENjoin CONGVIEC on PHANCONG.MADA = CONGVIEC.MADA and PHANCONG.STT = CONGVIEC.STT--7. Cho biết thonong tin công việc của phòng Điều hành: MaNV, họ tên, mã phòng, Thời
--gian, tên công việc
select MANV,HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten,PHONGBAN.MAPHG as MaPhong, THOIGIAN,TEN_CONG_VIEC  from PHONGBAN join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG join PHANCONG on NHANVIEN.MANV = PHANCONG.MA_NVIENjoin CONGVIEC on PHANCONG.MADA = CONGVIEC.MADAwhere MAPHG = 4--8. Cho biết thông tin về Đề án của các phòng ban, kể cả những phòng ban không có đề án
--nào: mã phòng, tên phòng, tên đề án, địa điểm đề án.
select PHONGBAN.MAPHG,PHONGBAN.TENPHG,DEAN.TENDEAN,DEAN.DDIEM_DA
from DEAN right join PHONGBAN on DEAN.PHONG = PHONGBAN.MAPHG
--9. Cho biết thông tin về số đề án của mỗi phòng, kể cả những phòng không có đề án nào:
--Mã phòng, tên phòng, tổng số đề án.
select PHONGBAN.MAPHG,PHONGBAN.TENPHG,COUNT(DEAN.TENDEAN) as soDA
from DEAN right join PHONGBAN on DEAN.PHONG = PHONGBAN.MAPHG
group by PHONGBAN.MAPHG,PHONGBAN.TENPHG
--10. Cho biết thông tin các phòng không có đề án nào: Mã phòng, tên phòng.
--c1:
select PHONGBAN.MAPHG,PHONGBAN.TENPHG,COUNT(DEAN.TENDEAN) as soDA
from DEAN right join PHONGBAN on DEAN.PHONG = PHONGBAN.MAPHG
group by PHONGBAN.MAPHG,PHONGBAN.TENPHG
having COUNT(DEAN.TENDEAN) = 0
--c2:
select PHONGBAN.MAPHG,PHONGBAN.TENPHG
from DEAN right join PHONGBAN on DEAN.PHONG = PHONGBAN.MAPHG
where TENDEAN is null
--11. Cho biết thông tin về số nhân viên của từng phòng ban, kể cả những phòng ban không có
--nhân viên nào: mã phòng, tên phòng, số nhân viên.
select PHONGBAN.MAPHG,TENPHG, COUNT(NHANVIEN.MANV) as soNV from PHONGBAN full join NHANVIEN on PHONGBAN.MAPHG = NHANVIEN.PHG
group by PHONGBAN.MAPHG,TENPHG
--12. Thêm cột quốc tịch vào bảng Nhân viên với giá trị mặc định là Việt Nam
alter table nhanvien
add quocTich nvarchar(50) default N'Việt Nam' with values
select * from NHANVIEN

--lab2 
SELECT TOP 1 MANV,HONV+ ' '+ TENLOT+ ' '+TENNV as Hoten, MAX(LUONG) FROM dbo.NHANVIEN
GROUP BY MANV,HONV+ ' '+ TENLOT+ ' '+TENNV


SELECT
HONV+' '+TENLOT+' '+TENNV Hoten,LUONG
FROM NHANVIEN JOIN PHONGBAN PB on PB.MAPHG = NHANVIEN.PHG
WHERE TENPHG LIKE N'Nghiên cứu' AND NHANVIEN.LUONG > (SELECT AVG(LUONG) FROM NHANVIEN)


SELECT TENPHG,COUNT(MANV) SONHANVIEN FROM PHONGBAN JOIN NHANVIEN NV ON NV.PHG = PHONGBAN.MAPHG
WHERE (SELECT AVG(LUONG) FROM NHANVIEN) > 30000
GROUP BY TENPHG


SELECT TENPHG, COUNT(dbo.DEAN.MADA) AS soLuongDA
FROM dbo.PHONGBAN JOIN dbo.DEAN ON DEAN.PHONG = PHONGBAN.MAPHG
GROUP BY TENPHG