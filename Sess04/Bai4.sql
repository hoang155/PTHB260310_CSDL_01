-- Chèn dữ liệu mới:
-- Thêm sản phẩm “Chuột không dây Logitech M170”, loại Phụ kiện, giá 300000, tồn kho 20, hãng Logitech
INSERT INTO products (name, category, price, stock, manufacturer) 
VALUES ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- Cập nhật dữ liệu:
-- Tăng giá tất cả sản phẩm của Apple thêm 10%
UPDATE products 
SET price = price * 1.1 
WHERE manufacturer = 'Apple';

-- Xóa dữ liệu:
-- Xóa sản phẩm có stock = 0
DELETE FROM products 
WHERE stock = 0;

-- Lọc theo điều kiện:
-- Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
SELECT * FROM products 
WHERE price BETWEEN 1000000 AND 30000000;

-- Lọc giá trị NULL:
-- Hiển thị sản phẩm có stock IS NULL
SELECT * FROM products 
WHERE stock IS NULL;

-- Loại bỏ trùng:
-- Liệt kê danh sách hãng sản xuất duy nhất
SELECT DISTINCT manufacturer FROM products;

-- Sắp xếp dữ liệu
-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
SELECT * FROM products 
ORDER BY price DESC, name ASC;

-- Tìm kiếm (LIKE và ILIKE):
-- Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
SELECT * FROM products 
WHERE name ILIKE '%laptop%';

-- Giới hạn kết quả:
-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp
SELECT * FROM products 
ORDER BY price DESC 
LIMIT 2;