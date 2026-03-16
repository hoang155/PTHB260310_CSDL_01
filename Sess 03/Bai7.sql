-- Tạo Schema sales
CREATE SCHEMA sales;

-- ạo bảng Products trong schema sales
CREATE TABLE sales.Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0
);

-- Tạo bảng Orders trong schema sales
CREATE TABLE sales.Orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    member_id INTEGER,
    CONSTRAINT fk_order_member 
        FOREIGN KEY (member_id) 
        REFERENCES library.Members(member_id)
);

-- Tạo bảng OrderDetails trong schema sales
CREATE TABLE sales.OrderDetails (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    CONSTRAINT fk_detail_order 
        FOREIGN KEY (order_id) 
        REFERENCES sales.Orders(order_id),
    CONSTRAINT fk_detail_product 
        FOREIGN KEY (product_id) 
        REFERENCES sales.Products(product_id)
);