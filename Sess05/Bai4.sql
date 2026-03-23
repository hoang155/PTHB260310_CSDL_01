-- 1.ALIAS:
-- a.Hiển thị danh sách tất cả các đơn hàng với các cột:
-- i.Tên khách (customer_name)
-- ii.Ngày đặt hàng (order_date)
-- iii.Tổng tiền (total_amount)
SELECT 
    c.customer_name AS "Tên khách", 
    o.order_date AS "Ngày đặt hàng", 
    o.total_amount AS "Tổng tiền"
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- 2.Aggregate Functions:
-- a.Tính các thông tin tổng hợp:
-- i.Tổng doanh thu (SUM(total_amount))
-- ii.Trung bình giá trị đơn hàng (AVG(total_amount))
-- iii.Đơn hàng lớn nhất (MAX(total_amount))
-- iv.Đơn hàng nhỏ nhất (MIN(total_amount))
-- v.Số lượng đơn hàng (COUNT(order_id))
SELECT 
    SUM(total_amount) AS "Tổng doanh thu",
    AVG(total_amount) AS "Giá trị đơn hàng trung bình",
    MAX(total_amount) AS "Đơn hàng lớn nhất",
    MIN(total_amount) AS "Đơn hàng nhỏ nhất",
    COUNT(order_id) AS "Tổng số lượng đơn hàng"
FROM orders;

-- 3.GROUP BY / HAVING:
-- a.Tính tổng doanh thu theo từng thành phố
-- b.chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
SELECT 
    c.city, 
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

-- 4.JOIN:
-- a.Liệt kê tất cả các sản phẩm đã bán, kèm:
-- i.Tên khách hàng
-- ii.Ngày đặt hàng
-- iii.Số lượng và giá
-- iv.(JOIN 3 bảng customers, orders, order_items)
SELECT 
    c.customer_name AS "Tên khách hàng",
    o.order_date AS "Ngày đặt hàng",
    oi.quantity AS "Số lượng",
    oi.price AS "Giá bán"
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id;

-- 5.Subquery:
-- a.Tìm tên khách hàng có tổng doanh thu cao nhất.
-- b.Gợi ý: Dùng SUM(total_amount) trong subquery để tìm MAX
SELECT c.customer_name, SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT SUM(total_amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) AS sub
);

-- 6.UNION và INTERSECT:
-- a.Dùng UNION để hiển thị danh sách tất cả thành phố có khách hàng hoặc có đơn hàng
SELECT city FROM customers
UNION
SELECT c.city 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- b.Dùng INTERSECT để hiển thị các thành phố vừa có khách hàng vừa có đơn hàng
SELECT city FROM customers
INTERSECT
SELECT c.city 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;