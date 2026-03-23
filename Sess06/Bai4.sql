-- 1.Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
INSERT INTO OrderInfo (customer_id, order_date, total, status)
VALUES 
(1, '2024-10-15', 1200000, 'Completed'),
(2, '2024-10-20', 450000, 'Pending'),
(3, '2024-11-05', 800000, 'Shipping'),
(1, '2024-10-02', 600000, 'Cancelled'),
(4, '2024-12-12', 300000, 'Completed');

-- 2.Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
SELECT * FROM OrderInfo 
WHERE total > 500000;

-- 3.Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
SELECT * FROM OrderInfo 
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

-- 4.Liệt kê các đơn hàng có trạng thái khác “Completed”
SELECT * FROM OrderInfo 
WHERE status <> 'Completed';

-- 5.Lấy 2 đơn hàng mới nhất
SELECT * FROM OrderInfo 
ORDER BY order_date DESC 
LIMIT 2;