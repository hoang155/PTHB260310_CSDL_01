-- 1.Thêm 6 nhân viên mới
INSERT INTO Employee (full_name, department, salary, hire_date)
VALUES 
('Nguyễn Văn An', 'IT', 15000000, '2023-05-15'),
('Trần Thị Bình', 'HR', 12000000, '2023-02-10'),
('Lê Văn Cường', 'IT', 9000000, '2022-11-20'),
('Phạm Thùy An', 'Marketing', 11000000, '2023-08-01'),
('Hoàng Anh Tuấn', 'Sales', 5500000, '2024-01-10'),
('Đỗ Bảo Ngọc', 'IT', 20000000, '2023-12-25');

-- 2.Cập nhật mức lương tăng 10% cho nhân viên thuộc phòng IT
UPDATE Employee
SET salary = salary * 1.1
WHERE department = 'IT';

-- 3.Xóa nhân viên có mức lương dưới 6,000,000
DELETE FROM Employee
WHERE salary < 6000000;

-- 4.Liệt kê các nhân viên có tên chứa chữ “An” (không phân biệt hoa thường)
SELECT * FROM Employee
WHERE full_name ILIKE '%An%';

-- 5.Hiển thị các nhân viên có ngày vào làm việc trong khoảng từ '2023-01-01' đến '2023-12-31'
SELECT * FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';