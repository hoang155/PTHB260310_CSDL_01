-- 1.Dùng bảng products và sales từ bài tập 2
-- 2.Viết TRIGGER AFTER INSERT để giảm số lượng stock trong products
CREATE FUNCTION update_stock_after_sale()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products 
    SET stock = stock - NEW.quantity 
    WHERE product_id = NEW.product_id;

    RAISE NOTICE 'Đã trừ kho cho sản phẩm ID: %. Số lượng trừ: %', NEW.product_id, NEW.quantity;
    
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_insert_sale
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_sale();

-- 3.Thêm đơn hàng và kiểm tra products để thấy số lượng tồn kho giảm đúng
INSERT INTO sales (product_id, quantity) 
VALUES (1, 3);

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM sales;