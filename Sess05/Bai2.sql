-- 1.Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
-- a.Hiển thị: product_name, total_revenue
SELECT p.product_name, SUM(o.total_price) AS total_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
    -- Subquery tìm mức doanh thu cao nhất của một sản phẩm bất kỳ
    SELECT MAX(s.total_sales)
    FROM (
        SELECT SUM(total_price) AS total_sales
        FROM orders
        GROUP BY product_id
    ) s
);
-- 2.Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
SELECT p.category, SUM(o.total_price) AS total_category_revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

-- 3.Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000
SELECT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
HAVING SUM(o.total_price) = (
    SELECT MAX(total_sales) FROM (SELECT SUM(total_price) AS total_sales FROM orders GROUP BY product_id) s
)

INTERSECT

SELECT p.category
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;