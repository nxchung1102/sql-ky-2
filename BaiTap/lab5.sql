IF OBJECT_ID('xuat') IS NOT NULL
DROP PROC xuat
GO
CREATE PROC xuat @ten NVARCHAR(100)
AS 
BEGIN
PRINT N'xin chào '+ @ten
END
EXEC dbo.xuat N'chung'


IF OBJECT_ID('tong') IS NOT NULL
DROP PROC tong
GO
CREATE PROC tong @so1 INT , @so2 INT 
AS 
BEGIN

RETURN @so1+@so2
END
DECLARE @tg INT EXEC @tg =  dbo.tong 1,2
PRINT N'tổng là: '+ CAST(@tg AS NVARCHAR)

IF OBJECT_ID('tongchan') IS NOT NULL
DROP PROC tongchan
GO
CREATE PROC tongchan @n INT
AS 
BEGIN
DECLARE @count INT,@total int
set @count = 1
    WHILE @count <=@n
	BEGIN
	if @count%2 =0
	begin set @count +=@count end
	END
	print N'tổng các số chắn: ' +  cast(@count as nvarchar)
END
exec tongchan 4