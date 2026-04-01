-- 1.Viết đầy đủ SQL tạo bảng, Function và Trigger	
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    credit_limit NUMERIC(15, 2)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_amount NUMERIC(15, 2)
);

CREATE FUNCTION check_credit_limit()
RETURNS TRIGGER AS $$
DECLARE
    v_credit_limit NUMERIC;
    v_current_total NUMERIC;
BEGIN
    SELECT credit_limit INTO v_credit_limit 
    FROM customers 
    WHERE id = NEW.customer_id;

    SELECT COALESCE(SUM(order_amount), 0) INTO v_current_total 
    FROM orders 
    WHERE customer_id = NEW.customer_id;

    IF (v_current_total + NEW.order_amount) > v_credit_limit THEN
        RAISE EXCEPTION 'Vượt quá hạn mức tín dụng! Hạn mức: %, Tổng sau khi thêm: %', 
            v_credit_limit, (v_current_total + NEW.order_amount);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_credit
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_credit_limit();

-- 2.Thực hành chèn dữ liệu và thử các trường hợp khác nhau (hợp lệ và vượt hạn mức)
INSERT INTO customers (name, credit_limit)
VALUES ('Nguyễn Văn A', 1000.00),
('Trần Thị B', 500.00);

INSERT INTO orders (customer_id, order_amount) VALUES (1, 400.00);
INSERT INTO orders (customer_id, order_amount) VALUES (1, 700.00);
INSERT INTO orders (customer_id, order_amount) VALUES (2, 600.00);