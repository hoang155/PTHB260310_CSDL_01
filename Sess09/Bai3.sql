-- 1.Tạo Clustered Index trên cột category_id
CREATE INDEX idx_products_category_id ON Products(category_id);
CLUSTER Products USING idx_products_category_id;

-- 2.Tạo Non-clustered Index trên cột price
CREATE INDEX idx_products_price ON Products(price);

-- 3.Thực hiện truy vấn SELECT * FROM Products WHERE category_id = X ORDER BY price; và giải thích cách Index hỗ trợ tối ưu
SELECT * FROM Products 
WHERE category_id = 10 
ORDER BY price;