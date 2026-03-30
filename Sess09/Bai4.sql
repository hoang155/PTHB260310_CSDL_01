-- 1.Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
CREATE VIEW CustomerSales AS
SELECT customer_id, SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;

-- 2.Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
SELECT * FROM CustomerSales 
WHERE total_amount > 1000;

-- 3.Thử cập nhật một bản ghi qua View và quan sát kết quả
UPDATE CustomerSales 
SET total_amount = 5000 
WHERE customer_id = 1;