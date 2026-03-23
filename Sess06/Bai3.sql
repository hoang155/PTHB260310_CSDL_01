-- 1.Thêm 7 khách hàng (trong đó có 1 người không có email)
INSERT INTO Customer (name, email, phone, points)
VALUES 
('Nguyễn An', 'an@gmail.com', '0912345678', 150),
('Trần Bình', 'binh@yahoo.com', '0922345678', 200),
('Lê Cường', NULL, '0932345678', 50), -- Khách hàng không có email
('Phạm Dung', 'dung@outlook.com', '0942345678', 300),
('Hoàng Giang', 'giang@gmail.com', '0952345678', 100),
('Vũ Hoa', 'hoa@gmail.com', '0962345678', 250),
('Đặng Hùng', 'hung@gmail.com', '0972345678', 180);

-- 2.Truy vấn danh sách tên khách hàng duy nhất (DISTINCT)
SELECT DISTINCT name FROM Customer;

-- 3.Tìm các khách hàng chưa có email (IS NULL)
SELECT * FROM Customer
WHERE email IS NULL;

-- 4.Hiển thị 3 khách hàng có điểm thưởng cao nhất, bỏ qua khách hàng cao điểm nhất (gợi ý: dùng OFFSET)
SELECT * FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

-- 5.Sắp xếp danh sách khách hàng theo tên giảm dần
SELECT * FROM Customer
ORDER BY name DESC;