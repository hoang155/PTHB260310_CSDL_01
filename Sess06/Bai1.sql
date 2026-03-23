-- 1.Thêm 5 sản phẩm vào bảng bằng lệnh INSERT
INSERT INTO Product (name, category, price, stock)
VALUES 
('iPhone 15 Pro', 'Điện tử', 28000000, 50),
('Samsung Galaxy S23', 'Điện tử', 15000000, 30),
('Loa Bluetooth JBL', 'Điện tử', 2500000, 100),
('Bàn làm việc gỗ', 'Nội thất', 1200000, 15),
('Chuột máy tính Logi', 'Điện tử', 500000, 200);

-- 2.Hiển thị danh sách toàn bộ sản phẩm
SELECT * FROM Product;

-- 3.Hiển thị 3 sản phẩm có giá cao nhất
SELECT * FROM Product
ORDER BY price DESC
LIMIT 3;

-- 4.Hiển thị các sản phẩm thuộc danh mục “Điện tử” có giá nhỏ hơn 10,000,000
SELECT * FROM Product
WHERE category = 'Điện tử' AND price < 10000000;

-- 5.Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
SELECT * FROM Product
ORDER BY stock ASC;
