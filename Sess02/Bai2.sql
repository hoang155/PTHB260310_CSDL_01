--Tạo Database
CREATE DATABASE "UniversityDB";

--Tạo Schema
CREATE SCHEMA university;

--Tạo bảng
CREATE TABLE university.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE university.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0)
);

--Tạo bảng Enrollments
CREATE TABLE university.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES university.Students(student_id),
    course_id INT REFERENCES university.Courses(course_id),
    enroll_date DATE DEFAULT CURRENT_DATE
);

--Xem danh sách database
SELECT datname FROM pg_database;

--Xem danh sách schema
SELECT schema_name FROM information_schema.schemata;

--Xem cấu trúc bảng
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university'
AND table_name IN ('students', 'courses', 'enrollments')
ORDER BY table_name, ordinal_position;