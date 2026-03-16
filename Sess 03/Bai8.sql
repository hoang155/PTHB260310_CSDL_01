-- Thêm cột gerne
ALTER TABLE library.Books 
ADD COLUMN genre VARCHAR(100);

-- Đổi tên cột
ALTER TABLE library.Books 
RENAME COLUMN available TO is_available;

-- Xóa cột email
ALTER TABLE library.Members 
DROP COLUMN email;

-- Xóa bảng
DROP TABLE sales.OrderDetails;