-- 1.Tạo View tổng hợp doanh thu theo khu vực:
-- a.Viết truy vấn xem top 3 khu vực có doanh thu cao nhất
SELECT region, total_revenue
FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;

-- 2.Tạo View chi tiết đơn hàng có thể cập nhật được:
-- a.Cập nhật status của đơn hàng thông qua View này
UPDATE mv_monthly_sales
SET status = 'Processing'
WHERE order_id = 101;
-- b.Kiểm tra hành vi khi vi phạm điều kiện WITH CHECK OPTION
INSERT INTO mv_monthly_sales (customer_id, total_amount, status)
VALUES (1, 500000, 'Shipped');

-- 3.Tạo View phức hợp (Nested View):
-- a.Từ v_revenue_by_region, tạo View mới v_revenue_above_avg chỉ hiển thị khu vực có doanh thu > trung bình toàn quốc
CREATE VIEW v_revenue_above_avg AS
SELECT region, total_revenue
FROM v_revenue_by_region
WHERE total_revenue > (
    SELECT AVG(total_revenue) 
    FROM v_revenue_by_region
);