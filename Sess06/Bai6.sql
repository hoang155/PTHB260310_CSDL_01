-- 1.Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn (dùng SUM, COUNT, AVG) - Đặt bí danh cột lần lượt là total_revenue, total_orders, average_order_value
SELECT 
    SUM(total_amount) AS total_revenue,
    COUNT(id) AS total_orders,
    AVG(total_amount) AS average_order_value
FROM Orders;

-- 2.Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm (GROUP BY EXTRACT(YEAR FROM order_date))
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year DESC;

-- 3.Chỉ hiển thị các năm có doanh thu trên 50 triệu (HAVING)
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 50000000;

-- 4.Hiển thị 5 đơn hàng có giá trị cao nhất (dùng ORDER BY + LIMIT)
SELECT * FROM Orders
ORDER BY total_amount DESC
LIMIT 5;