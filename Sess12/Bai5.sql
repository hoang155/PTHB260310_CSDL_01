-- 1.Tạo bảng employees:
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50)
);

-- 2.Tạo bảng employee_log:
CREATE TABLE employee_log (
    log_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    action_time TIMESTAMP DEFAULT NOW()
);

-- 3.Viết TRIGGER AFTER UPDATE để ghi log khi thông tin nhân viên thay đổi
CREATE FUNCTION log_employee_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Ghi nhận tên nhân viên vừa được cập nhật vào bảng log
    INSERT INTO employee_log (emp_name, action_time)
    VALUES (NEW.name, NOW());
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_update_employee
AFTER UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_update();

-- 4.Thực hiện UPDATE và kiểm tra bảng employee_log
UPDATE employees 
SET position = 'Developer' 
WHERE name = 'HoangPK';

SELECT * FROM employee_log;