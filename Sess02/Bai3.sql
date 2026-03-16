--Tạo Database
CREATE DATABASE "SalesDB";

--Tạo Schema
CREATE SCHEMA sales;

--Tạo bảng Khách hàng
CREATE TABLE sales.Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20)
);

--Tạo bảng Sản phẩm
CREATE TABLE sales.Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(12, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0
);

--Tạo bảng Đơn hàng
CREATE TABLE sales.Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES sales.Customers(customer_id),
    order_date DATE NOT NULL DEFAULT CURRENT_DATE
);

--Tạo bảng Chi tiết đơn hàng
CREATE TABLE sales.OrderItems (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES sales.Orders(order_id),
    product_id INT NOT NULL REFERENCES sales.Products(product_id),
    quantity INT NOT NULL CHECK (quantity >= 1)
);