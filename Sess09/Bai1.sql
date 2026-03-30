-- 1.Tạo một B-Tree Index trên cột customer_id
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);

-- 2.Thực hiện truy vấn SELECT * FROM Orders WHERE customer_id = X; trước và sau khi tạo Index, so sánh thời gian thực hiện
EXPLAIN ANALYZE 
SELECT * FROM Orders WHERE customer_id = 1;