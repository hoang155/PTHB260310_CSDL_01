-- 1.Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
-- a.Đặt bí danh cột như sau:
-- i.total_sales cho tổng doanh thu
-- ii.total_quantity cho tổng số lượng
-- 2.Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
-- 3.Sắp xếp kết quả theo tổng doanh thu giảm dần
SELECT 
    p.category, 
    SUM(o.total_price) AS total_sales, 
    SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;