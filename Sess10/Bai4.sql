-- 1.Sinh viên viết Function Trigger bằng PL/pgSQL để tự động cập nhật tồn kho
CREATE FUNCTION sync_product_stock()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE products 
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE id = NEW.product_id;

    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE products 
        SET stock_quantity = stock_quantity + OLD.quantity
        WHERE id = OLD.product_id;

    ELSIF (TG_OP = 'UPDATE') THEN
        UPDATE products 
        SET stock_quantity = stock_quantity + OLD.quantity - NEW.quantity
        WHERE id = NEW.product_id;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 2.Tạo Trigger gắn với bảng orders
CREATE TRIGGER trg_sync_stock
AFTER INSERT OR UPDATE OR DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION sync_product_stock();

-- 3.Thực hành insert/update/delete đơn hàng và kiểm tra tồn kho products
INSERT INTO orders (product_id, quantity) VALUES (1, 10);

UPDATE orders SET quantity = 15 WHERE order_id = 1;

DELETE FROM orders WHERE order_id = 1;

SELECT * FROM products;