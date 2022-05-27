﻿-- SQLQuery_NangCao_DungNA29_IT17202_SP22_BL1
-- Các phím tắt cơ bản:
-- Ctrl + /: Dùng comment code
-- F5: Dùng để chạy câu lệnh SQL

-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lệnh Declare trong SQL SERVER
-- 1.1 Để khai báo biến thì các bạn sử dụng từ khóa Declare với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến
-- Ví dụ:
DECLARE @YEAR AS INT
DECLARE @NAME AS NVARCHAR,
		@YEAR_OF_BIRTH AS INT

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
SELECT @YEAR

-- Bài 1: Tính tổng 3 số.
DECLARE @a INT,@b INT, @c INT
SET @a = 1
SET @b = 2
SET @c = 3
SELECT (@a + @b + @c)
-- Bài 2: Tính diện tích hình chữ nhật.

-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @KhoaMax INT
SET @KhoaMax = (SELECT MAX(Id) FROM NhanVien)
--SELECT @KhoaMax
PRINT N'Nhân viên có FK lớn nhất ' + CONVERT(VARCHAR,@KhoaMax)

-- Lấy sản phẩm có số lượng tồn lớn nhất trong bảng bảng Chi tiết sản phẩm và gán vào biến rồi in ra.

-- 1.4 Biến bảng
DECLARE @TB_NhanVien TABLE(Ma VARCHAR(30), Ten NVARCHAR(50))

-- Chèn dữ liệu vào Biến Bảng
INSERT INTO @TB_NhanVien
SELECT Ma,Ten FROM NhanVien
WHERE Ten LIKE 'T%'

SELECT * FROM @TB_NhanVien

-- Chèn dữ liệu vào biến bảng
DECLARE @TB_SINHVIEN TABLE(Id INT,Ten NVARCHAR(50),Msv VARCHAR(50))

INSERT INTO @TB_SINHVIEN
VALUES(1,N'Dũng','PH12345')

SELECT * FROM @TB_SINHVIEN
-- Sử dụng câu lệnh UPDATE Sau đoạn INSERT, Sửa lại Dũng Thành FPT
-- Bài tập: Sử dụng 2 biến Bảng (TB_ChucVu & TB_HD) để đổ dữ liệu từ bảng Chức Vụ và bảng Hóa đơn. Lấy tất cả các cột ngoại trừ cột ID để đổ vào 2 biến bảng trên. Thực hiện cả hành động Update và DELETE với biến bảng. (Bài về nhà)

-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
	SELECT Id,SoLuongTon,GiaBan 
	FROM ChiTietSP
	WHERE SoLuongTon > 1000

	IF @@ROWCOUNT = 0
	PRINT N'Không có sản phẩm nào tồn lớn hơn 900'
	ELSE
	PRINT N'Có tìm thấy sản phẩm tồn lớn hơn 900'
END
-- 1.8 Begin và End có thể lồng nhau
BEGIN
	DECLARE @MaNV VARCHAR(50)
	SELECT TOP 1
	@MaNV = Ma
	FROM NhanVien WHERE Ten LIKE 'T%'

	IF @@ROWCOUNT <> 0
	BEGIN
		PRINT N'Tìm thấy nhân viên có tên T đứng đầu: ' + @MaNV
	END
	ELSE
	BEGIN
		PRINT N'Không tìm thấy nhân viên nào có chữ T đứng đầu'
	END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])

SELECT CAST(4.3 AS INT) -- = 4
SELECT CAST(13.1 AS FLOAT)
SELECT CAST(13.1 AS VARCHAR)
SELECT CAST('13.1' AS FLOAT)
SELECT CAST('2022-1-15' AS DATE)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày).
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(int,15.6) -- = 5
SELECT CONVERT(float,'15.6')
SELECT CONVERT(date,'2022-1-15')
-- Các định dạng trong convert 101,102,....... là các tham số định dạng
-- https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
SELECT CONVERT(varchar,'01/15/2021',101)
SELECT CONVERT(varchar,GETDATE(),112)-- yyyy/mm/dd
SELECT CONVERT(datetime,'2022.01.15',102)--yyyy/mm/dd
SELECT CONVERT(datetime,'15/01/2022',103)--dd/mm/yyyy

-- Hiển thị danh sách ngày sinh của nhân viên
SELECT Ma,NgaySinh,
	CAST(NgaySinh AS VARCHAR) AS N'Ngày sinh 1',
	CONVERT(VARCHAR,NgaySinh,101) AS N'Ngày 101',
	CONVERT(VARCHAR,NgaySinh,102) AS N'Ngày 102',
	CONVERT(VARCHAR,NgaySinh,103) AS N'Ngày 103'
FROM NhanVien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi 2 đầu nhưng từ bản SQL 2017 trở lên mới hoạt động
*/
SELECT LEN(N'Học Lại')-- = 7
SELECT LTRIM(N'  Học Lại')
SELECT RTRIM(N'  Học Lại    ')
SELECT LEFT(N'Học Lại',LEN(N'Học Lại') - 3)
/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @TB_SV TABLE(Ten NVARCHAR(50))
INSERT INTO @TB_SV
VALUES(N'Nguyễn Ngọc Anh'),(N'Phan Xuân Đỉnh')
SELECT 
	LEN(Ten) AS N'Độ dài tên',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten)-1) AS N'Họ',
	RIGHT(Ten,LEN(Ten) - CHARINDEX(' ',Ten)) AS N'Tên'
FROM @TB_SV
-- Tách nốt tên và tên đệm ra thành 2 thành phần riêng biệt.
-- Cách 2:
DECLARE @TB_SV TABLE(Ten NVARCHAR(50))
INSERT INTO @TB_SV
VALUES(N'Nguyễn Ngọc Anh'),(N'Phan Xuân Đỉnh')
SELECT 
	Ten,
	PARSENAME(REPLACE(Ten,' ','.'),3) AS N'Họ',
	PARSENAME(REPLACE(Ten,' ','.'),2) AS N'Đệm',
	PARSENAME(REPLACE(Ten,' ','.'),1) AS N'Tên'
FROM @TB_SV
-- Cách 3:
DECLARE @TB_SV TABLE(Ten NVARCHAR(50))
INSERT INTO @TB_SV
VALUES(N'Nguyễn Xuân Anh'),(N'Phan Xuân Đỉnh')
SELECT 
	LEN(Ten) AS N'Độ dài tên',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten)-1) AS N'Họ',
	RTRIM(LTRIM(REPLACE(REPLACE(Ten,SUBSTRING(Ten , 1, CHARINDEX(' ', Ten) - 1),''),REVERSE( LEFT( REVERSE(Ten), CHARINDEX(' ', REVERSE(Ten))-1 ) ),'')))as N'TÊN ĐỆM',
	RIGHT(Ten,CHARINDEX(' ',Ten)) AS N'Tên'
FROM @TB_SV
-- Buổi sau xem lại

 -- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 ,[  start_location ] ) = 1 số nguyên
SELECT CHARINDEX('POLY','FPT POLYTECHNIC')-- = 5
SELECT CHARINDEX('POLY','FPT POLYTECHNIC',6)-- = 0 Không tìm thầy

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
SELECT SUBSTRING('FPT POLYTECHNIC',5,LEN('FPT POLYTECHNIC'))
SELECT SUBSTRING('FPT POLYTECHNIC',CHARINDEX(' ','FPT POLYTECHNIC') +1,LEN('FPT POLYTECHNIC'))
SELECT SUBSTRING('FPT POLYTECHNIC',5,8)-- 8 Được tính từ vị trí index 5

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-345-678','-',' ')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT REVERSE('SQL')
SELECT LOWER('SQL')
SELECT 'SQ' + '  ' + 'L'
SELECT 'SQ' + SPACE(20) + 'L'

-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(DATE,GETDATE())
SELECT CONVERT(TIME,GETDATE())
SELECT YEAR(GETDATE()) AS N'NĂM',
		MONTH(GETDATE()) AS N'THÁNG',
		DAY(GETDATE()) AS N'NGÀY'

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT 
	DATENAME(YEAR,GETDATE()) AS 'YEAR',
	DATENAME(MONTH,GETDATE()) AS 'MONTH',
	DATENAME(DAY,GETDATE()) AS 'DAY',
	DATENAME(WEEK,GETDATE()) AS 'WEEK',
	DATENAME(DAYOFYEAR,GETDATE()) AS 'DAYOFYEAR',
	DATENAME(WEEKDAY,GETDATE()) AS 'WEEKDAY'
-- Truyền ngày sinh bản thân
DECLARE @NgaySInh DATE
SET @NgaySInh = '1990-07-27'
SELECT 
	DATENAME(YEAR,@NgaySInh) AS 'YEAR',
	DATENAME(MONTH,@NgaySInh) AS 'MONTH',
	DATENAME(DAY,@NgaySInh) AS 'DAY',
	DATENAME(WEEK,@NgaySInh) AS 'WEEK',
	DATENAME(DAYOFYEAR,@NgaySInh) AS 'DAYOFYEAR',
	DATENAME(WEEKDAY,@NgaySInh) AS 'WEEKDAY'

-- 2.8 Câu điều kiện IF ELSE trong SQL
/* Lệnh if sẽ kiểm tra một biểu thức có đúng  hay không, nếu đúng thì thực thi nội dung bên trong của IF, nếu sai thì bỏ qua.
IF BIỂU THỨC   
BEGIN
    { statement_block }
END		  */
IF 1=1
BEGIN
	PRINT N'Đúng'
END
ELSE
BEGIN	
	PRINT N'SAI'
END

IF 1=1
	PRINT N'Đúng'
ELSE	
	PRINT N'SAI'

-- Viết 1 chương trình truyền điểm thi COM2034 đánh giá qua môn hoặc học lại
DECLARE @DiemThi_COM2034 FLOAT
SET @DiemThi_COM2034 = 4.9
IF @DiemThi_COM2034 >= 5
BEGIN
	PRINT N'Chúc mừng bạn đã qua môn'
END
ELSE
BEGIN
	PRINT N'Chúc mừng bạn đã mất 659K'
END

/* 2.9 IF EXISTS
IF EXISTS (CaulenhSELECT)
Cau_lenhl | Khoi_lenhl
[ELSE
Cau_lenh2 | Khoi_lenh2] 
*/
-- Kiểm tra xem trong bảng Chi tiết sản phẩm có sản phẩm nào tồn lớn hơn 900?
IF EXISTS(
	SELECT * FROM ChiTietSP 
	WHERE SoLuongTon > 900)

	BEGIN
		PRINT N'CÓ DANH SÁCH SẢN PHẨM TỒN LỚN HƠN 900'
		SELECT * FROM ChiTietSP 
		WHERE SoLuongTon > 900
	END
ELSE
	BEGIN
		PRINT N'KHÔNG CÓ DANH SÁCH SẢN PHẨM TỒN LỚN HƠN 900'
	END

/*
 3.0 Hàm IIF () trả về một giá trị nếu một điều kiện là TRUE hoặc một giá trị khác nếu một điều kiện là FALSE.
IIF(condition, value_if_true, value_if_false)
*/
SELECT IIF(900>1000,N'ĐÚNG',N'SAI')

SELECT Ma,Ten,GioiTinh,
	IIF(IdCH = 1,N'Cửa Hàng 1',IIF(IdCH = 2,N'Cửa Hàng 2',N'Không xác định'))
FROM NhanVien

/*
3.1 Câu lệnh CASE đi qua các điều kiện và trả về một giá trị khi điều kiện đầu tiên được đáp ứng (như câu lệnh IF-THEN-ELSE). 
Vì vậy, một khi một điều kiện là đúng, nó sẽ ngừng đọc và trả về kết quả. 
Nếu không có điều kiện nào đúng, nó sẽ trả về giá trị trong mệnh đề ELSE.
Nếu không có phần ELSE và không có điều kiện nào đúng, nó sẽ trả về NULL.
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/
-- MR MS MRS
SELECT Ma,Ten =
	(CASE GioiTinh
	WHEN 'Nam' THEN 'Mr. '+Ten
	WHEN N'Nữ' THEN 'Mrs. '+Ten
	ELSE 'Không xác định '+Ten
	END),
	GioiTinh
FROM NhanVien

/*Vòng lặp WHILE (WHILE LOOP) được sử dụng nếu bạn muốn 
chạy lặp đi lặp lại một đoạn mã khi điều kiện cho trước trả về giá trị là TRUE.*/
DECLARE @DEM INT = 0
WHILE @DEM < 5
BEGIN
	PRINT N'LẦN THỨ' + CONVERT(VARCHAR,@DEM)
	PRINT N'MUỐN HỌC LẠI COM2034 THÌ PHẢI...'
	SET @DEM = @DEM + 1
END

/*Lệnh Break (Ngắt vòng lặp)*/
/* Lệnh Continue: Thực hiện bước lặp tiếp theo bỏ qua các lệnh trong */
DECLARE @DEM INT = 0
WHILE @DEM < 10
BEGIN
	IF @DEM < 5
		BEGIN
			SET @DEM += 1
			CONTINUE
		END
	PRINT N'LẦN THỨ' + CONVERT(VARCHAR,@DEM)
	PRINT N'MUỐN HỌC LẠI COM2034 THÌ PHẢI...'
	SET @DEM = @DEM + 1
END

/* 3.2 Try...Catch 
SQLServer Transact-SQL cung cấp cơ chế kiểm soát lỗi bằng TRY … CATCH
như trong các ngôn ngữ lập trình phổ dụng hiện nay (Java, C, PHP, C#).
Một số hàm ERROR thường dùng
_
ERROR_NUMBER() : Trả về mã số của lỗi dưới dạng số
ERROR_MESSAGE() Trả lại thông báo lỗi dưới hình thức văn bản 
ERROR_SEVERITY() Trả lại mức độ nghiêm trọng của lỗi kiểu int
ERROR_STATE() Trả lại trạng thái của lỗi dưới dạng số
ERROR_LINE() : Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
ERROR_PROCEDURE() Trả về tên thủ tục/Trigger gây ra lỗi
*/
BEGIN TRY
	SELECT 1 + '1a'
END TRY
BEGIN CATCH
	SELECT
	ERROR_NUMBER() AS N'Trả về mã số của lỗi dưới dạng số',
	ERROR_MESSAGE() AS N'Trả lại thông báo lỗi dưới hình thức văn bản'
END CATCH
--
BEGIN TRY
	SELECT 1 + '1a'
END TRY
BEGIN CATCH
	PRINT N'Thông báo: ' + CONVERT(VARCHAR(MAX),ERROR_NUMBER())
	PRINT N'Thông báo: ' + ERROR_MESSAGE()
END CATCH
/* 3.3 RAISERROR*/
BEGIN TRY
	INSERT INTO MauSac VALUES('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','b')
END TRY
BEGIN CATCH
	DECLARE @erERROR_MESSAGE VARCHAR(MAX), @erERROR_SEVERITY INT, @erERROR_STATE INT
	SELECT 
		@erERROR_MESSAGE = ERROR_MESSAGE(),
		@erERROR_SEVERITY = ERROR_SEVERITY(),
		@erERROR_STATE = ERROR_STATE()
	RAISERROR(@erERROR_MESSAGE,@erERROR_SEVERITY,@erERROR_STATE)
END CATCH

-- 3.4 Ý nghĩa của Replicate
DECLARE @ten1234 NVARCHAR(50)
SET @ten1234 = REPLICATE(N'Á',5)--Lặp lại số lần với String truyền vào
PRINT @ten1234

/* TỔNG KẾT STORE PROCEDURE :
 -- Là lưu trữ một tập hợp các câu lệnh đi kèm trong CSDL cho phép tái sử dụng khi cần
 -- Hỗ trợ các ứng dụng tương tác nhanh và chính xác
 -- Cho phép thực thi nhanh hơn cách viết từng câu lệnh SQL
 -- Stored procedure có thể làm giảm bớt vấn đề kẹt đường truyền mạng, dữ liệu được gởi theo gói.
 -- Stored procedure có thể sử dụng trong vấn đề bảo mật, phân quyền
 -- Có 2 loại Store Procedure chính: System stored	procedures và User stored procedures   
 
 -- Cấu trúc của Store Procedure bao hồm:
	➢Inputs: nhận các tham số đầu vào khi cần
	➢Execution: kết hợp giữa các yêu cầu nghiệp vụ với các lệnh
	lập trình như IF..ELSE, WHILE...
	➢Outputs: trả ra các đơn giá trị (số, chuỗi…) hoặc một tập kết quả.
 
 --Cú pháp:
 CREATE hoặc ALTER(Để cập nhật nếu đã tồn tại tên SP) PROC <Tên STORE PROCEDURE> <Tham số truyền vào nếu có>
 AS
 BEGIN
  <BODY CODE>
 END
 ĐỂ GỌI SP dùng EXEC hoặc EXECUTE
SPs chia làm 2 loại:
System stored procedures: Thủ tục mà những người sử dụng chỉ có quyền thực hiện, không được phép thay đổi.	
User stored procedures: Thủ tục do người sử dụng tạo và thực hiện.
 -- SYSTEM STORED PROCEDURES
 Là những stored procedure chứa trong Master Database, thường bắt đầu bằng tiếp đầu ngữ	 sp_
 Chủ yếu dùng trong việc quản lý cơ sở dữ liệu(administration) và bảo mật (security).
❑Ví dụ: sp_helptext <tên của đối tượng> : để lấy định nghĩa của đối tượng (thông số tên đối
tượng truyền vào) trong Database
 */
 GO
 ALTER PROCEDURE SP_DsNVNam -- CREATE là tạo mới , ALTER, DROP
 AS
 SELECT * FROM NhanVien WHERE GioiTinh = N'NỮ'

 GO
 CREATE PROC SP_DSNhanVien
 AS
 SELECT * FROM NhanVien WHERE Ten LIKE 'T%' AND TrangThai = 1

 -- Muốn thực thi Proc sử dụng câu lệnh EXCUTE đến store đã đặt tên.
 EXECUTE SP_DsNVNam
 EXEC SP_DsNVNam

 -- TRIỂN KHAI STORE PROC NÂNG CAO - GIÚP QUA MÔN, HỌC JAVA3, DỰN ÁN 1 hoặc DỰ ÁN TỐT NGHIỆP

GO
CREATE PROC SP_CRUD_TB_MAUSAC
		(@Id INT,@Ma VARCHAR(20),
		@Ten NVARCHAR(30),@SQLTYPE VARCHAR(20))
AS
BEGIN
	IF @SQLTYPE = 'SELECT'
	BEGIN
		SELECT * FROM MauSac
	END
	IF @SQLTYPE = 'INSERT'
	BEGIN
		INSERT INTO MAUSAC VALUES(@Ma,@Ten)
	END
	IF @SQLTYPE = 'UPDATE'
	BEGIN
		UPDATE MauSac SET Ten = @Ten WHERE Id = @Id
	END
		IF @SQLTYPE = 'DELETE'
	BEGIN
		DELETE MauSac WHERE Id = @Id
	END
END 

EXEC SP_CRUD_TB_MAUSAC @ID = 0,@Ma = '',@Ten = '',@SQLTYPE = 'SELECT'
EXEC SP_CRUD_TB_MAUSAC @ID = 0,@Ma = NULL,@Ten = 'D',@SQLTYPE = 'INSERT'

-- Bài Tập Viết STORE PROC CRUD BẢNG NHÂN VIÊN Không truyền khóa phụ mà là truyền mã MÃ CỬA HÀNG, MÃ CHỨC VỤ. CÒN CÁC THAM SỐ HỢP LÝ.
