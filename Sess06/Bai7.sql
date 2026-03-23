-- 1.Liệt kê danh sách nhân viên cùng tên phòng ban của họ (INNER JOIN)
SELECT 
    e.full_name, 
    d.name AS department_name
FROM Employee e
INNER JOIN Department d ON e.department_id = d.id;

-- 2.Tính lương trung bình của từng phòng ban, hiển thị:
-- a.department_name
-- b.avg_salary
-- c.Gợi ý: dùng GROUP BY và bí danh cột
SELECT 
    d.name AS department_name,
    AVG(e.salary) AS avg_salary
FROM Department d
INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name;

-- 3.Hiển thị các phòng ban có lương trung bình > 10 triệu (HAVING)
SELECT 
    d.name AS department_name,
    AVG(e.salary) AS avg_salary
FROM Department d
INNER JOIN Employee e ON d.id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;

-- 4.Liệt kê phòng ban không có nhân viên nào (LEFT JOIN + WHERE employee.id IS NULL)
SELECT 
    d.name AS department_name
FROM Department d
LEFT JOIN Employee e ON d.id = e.department_id
WHERE e.id IS NULL;