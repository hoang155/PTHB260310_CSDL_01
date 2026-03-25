-- 1.Tạo một View tên v_order_summary hiển thị:
-- a.full_name, total_amount, order_date
-- b.(ẩn thông tin email và phone)
CREATE VIEW v_order_summary AS
SELECT 
    c.full_name, 
    o.total_amount, 
    o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;

-- 2.Viết truy vấn để xem tất cả dữ liệu từ View
SELECT * FROM v_order_summary;

-- 3.Tạo 1 view lấy về thông tin của tất cả các đơn hàng với điều kiện total_amount ≥ 1 triệu .
--  Sau đó bạn hãy cập nhật lại thông tin 1 bản ghi trong view đó nhé .
CREATE VIEW v_high_value_orders AS
SELECT * FROM orders 
WHERE total_amount >= 1000000;

UPDATE v_high_value_orders
SET total_amount = 1500000
WHERE order_id = 1;

-- 4.Tạo một View thứ hai v_monthly_sales thống kê tổng doanh thu mỗi tháng
CREATE VIEW v_monthly_sales AS
SELECT 
    DATE_TRUNC('month', order_date) AS sales_month,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date);

-- 5.Thử DROP View và ghi chú sự khác biệt giữa DROP VIEW và DROP MATERIALIZED VIEW trong PostgreSQL
DROP VIEW v_order_summary;

-- DROP VIEW chỉ xóa câu lệnh truy vấn (ảo) lưu trong hệ thống,
-- trong khi DROP MATERIALIZED VIEW xóa cả câu lệnh lẫn dữ liệu vật lý đã được lưu trữ thực tế trên ổ đĩa.