-- Tạo Database
CREATE DATABASE "SchoolDB";

-- Tạo bảng Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE
);

-- Tạo bảng Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3
);

-- Tạo bảng Enrollments với các ràng buộc
CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade CHAR(1),
    CONSTRAINT fk_student 
        FOREIGN KEY (student_id) 
        REFERENCES Students(student_id),
    CONSTRAINT fk_course 
        FOREIGN KEY (course_id) 
        REFERENCES Courses(course_id),
    CONSTRAINT chk_grade CHECK (grade IN ('A', 'B', 'C', 'D', 'F'))
);