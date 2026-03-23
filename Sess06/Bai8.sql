-- 1.Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần
SELECT 
    c.name, 
    SUM(o.total_amount) AS total_spent
FROM Customer c
INNER JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 2.Tìm khách hàng có tổng chi tiêu cao nhất (dùng Subquery với MAX)
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_amount) = (
    SELECT MAX(sub.total_spent)
    FROM (
        SELECT SUM(total_amount) AS total_spent
        FROM Orders
        GROUP BY customer_id
    ) sub
);

-- 3.Liệt kê khách hàng chưa từng mua hàng (LEFT JOIN + IS NULL)
SELECT c.name
FROM Customer c
LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 4.Hiển thị khách hàng có tổng chi tiêu > trung bình của toàn bộ khách hàng (dùng Subquery trong HAVING)
SELECT 
    c.name, 
    SUM(o.total_amount) AS total_spent
FROM Customer c
JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount) FROM Orders
);