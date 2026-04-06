-- 1.Tạo bảng orders:
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_amount NUMERIC
);

-- 2.Viết TRIGGER BEFORE INSERT để tự động tính total_amount
CREATE FUNCTION calculate_total_amount()
RETURNS TRIGGER AS $$
DECLARE
    v_unit_price NUMERIC;
BEGIN
    SELECT price INTO v_unit_price 
    FROM products 
    WHERE product_id = NEW.product_id;

    NEW.total_amount := v_unit_price * NEW.quantity;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auto_calculate_total
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_total_amount();

-- 3.Thêm vài đơn hàng và kiểm tra cột total_amount
INSERT INTO orders (product_id, quantity) 
VALUES (1, 3);

SELECT * FROM orders;