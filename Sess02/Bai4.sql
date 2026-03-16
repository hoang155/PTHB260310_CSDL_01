-- Tạo Database
CREATE DATABASE ElearningDB;

-- Tạo Schema
CREATE SCHEMA elearning;

-- Tạo các bảng trong Schema elearning
-- Bảng Students
CREATE TABLE elearning.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Bảng Instructors
CREATE TABLE elearning.Instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Bảng Courses
CREATE TABLE elearning.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    CONSTRAINT fk_course_instructor 
        FOREIGN KEY (instructor_id) 
        REFERENCES elearning.Instructors(instructor_id)
);

-- Bảng Enrollments
CREATE TABLE elearning.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_enrollment_student 
        FOREIGN KEY (student_id) 
        REFERENCES elearning.Students(student_id),
    CONSTRAINT fk_enrollment_course 
        FOREIGN KEY (course_id) 
        REFERENCES elearning.Courses(course_id)
);

-- Bảng Assignments
CREATE TABLE elearning.Assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    due_date TIMESTAMP NOT NULL,
    CONSTRAINT fk_assignment_course 
        FOREIGN KEY (course_id) 
        REFERENCES elearning.Courses(course_id)
);

-- Bảng Submissions
CREATE TABLE elearning.Submissions (
    submission_id SERIAL PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submission_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    grade NUMERIC(5,2) CHECK (grade >= 0 AND grade <= 100),
    CONSTRAINT fk_submission_assignment 
        FOREIGN KEY (assignment_id) 
        REFERENCES elearning.Assignments(assignment_id),
    CONSTRAINT fk_submission_student 
        FOREIGN KEY (student_id) 
        REFERENCES elearning.Students(student_id)
);