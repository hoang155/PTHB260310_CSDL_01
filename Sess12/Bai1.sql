-- 1.Tạo bảng customers:
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

-- 2.Tạo bảng customer_log:
CREATE TABLE customer_log (
    log_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    action_time TIMESTAMP DEFAULT NOW()
);

-- 3.Tạo TRIGGER để tự động ghi log khi INSERT vào customers
CREATE FUNCTION log_customer_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_log (customer_name)
    VALUES (NEW.name);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4.Thêm vài bản ghi vào customers và kiểm tra customer_log
INSERT INTO customers (name, email) VALUES ('HoangPK', 'hoang@example.com');
INSERT INTO customers (name, email) VALUES ('Nguyen Van A', 'a.nguyen@example.com');

SELECT * FROM customers;

SELECT * FROM customer_log;