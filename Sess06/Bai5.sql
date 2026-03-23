-- 1.Thêm ít nhất 6 khóa học vào bảng
INSERT INTO Course (title, instructor, price, duration)
VALUES 
('Lập trình SQL cơ bản', 'Nguyễn Văn A', 1200000, 20),
('Java Spring Boot Demo', 'Trần Thị B', 500000, 45),
('Thiết kế UI/UX nâng cao', 'Lê Văn C', 2500000, 35),
('Học SQL Server thực chiến', 'Phạm Minh D', 1800000, 40),
('NodeJS cho người mới', 'Hoàng An', 900000, 25),
('Python Demo cho Data Science', 'Vũ Bình', 300000, 15);

-- 2.Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

-- 3.Xóa khóa học có tên chứa từ khóa “Demo”
DELETE FROM Course
WHERE title LIKE '%Demo%';

-- 4.Hiển thị các khóa học có tên chứa từ “SQL” (không phân biệt hoa thường)
SELECT * FROM Course
WHERE title ILIKE '%SQL%';

-- 5.Lấy 3 khóa học có giá nằm giữa 500,000 và 2,000,000, sắp xếp theo giá giảm dần
SELECT * FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;