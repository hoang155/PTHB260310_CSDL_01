-- 1.Viết đầy đủ SQL tạo bảng, Function và Trigger
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE FUNCTION update_last_modified()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_last_modified();

-- 2.Kiểm tra Trigger bằng cách UPDATE một hoặc vài bản ghi
INSERT INTO products (name, price) 
VALUES ('Laptop Dell', 1500),
('iPhone 15', 1200);

UPDATE products SET price = 1600 WHERE name = 'Laptop Dell';

SELECT * FROM products;