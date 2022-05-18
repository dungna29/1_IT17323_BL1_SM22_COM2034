-- SQLQuery_NangCao_DungNA29_IT17202_SP22_BL1
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