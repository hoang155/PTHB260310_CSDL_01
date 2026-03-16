-- Tạo Database
CREATE DATABASE "LibraryDB";

-- Tạo Schema
CREATE SCHEMA IF NOT EXISTS library;

-- Tạo bảng Books
CREATE TABLE library.Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150)
    published_year INTEGER,
    available BOOLEAN DEFAULT TRUE
);

-- Tạo bảng Members
CREATE TABLE library.Members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE 
);