--Tạo database
create database LibraryDB

--Tạo schema
create schema library

--Tạo bảng Books
CREATE TABLE library.Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INT,
    price Float
);

--Xem tất cả database
SELECT datname FROM pg_database;

--Xem tất cả schema trong database
SELECT schema_name FROM information_schema.schemata;

--Xem cấu trúc bảng BOOKS
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema = 'library' AND table_name = 'books';