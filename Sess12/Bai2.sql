-- Tạo bảng products:
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    stock INT
);

-- Tạo bảng sales:
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT
);

-- Viết TRIGGER BEFORE INSERT để kiểm tra tồn kho
CREATE FUNCTION check_stock_before_sale()
RETURNS TRIGGER AS $$
DECLARE
    v_current_stock INT;
BEGIN
    SELECT stock INTO v_current_stock 
    FROM products 
    WHERE product_id = NEW.product_id;

    IF v_current_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Lỗi: Không đủ hàng trong kho! (Còn: %, Yêu cầu: %)', 
            v_current_stock, NEW.quantity;
    END IF;

    UPDATE products 
    SET stock = stock - NEW.quantity 
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_sale();

-- Thử thêm các đơn hàng vượt quá tồn kho và quan sát Trigger hoạt động
INSERT INTO sales (product_id, quantity) VALUES (1, 2);

SELECT * FROM products;
SELECT * FROM sales;