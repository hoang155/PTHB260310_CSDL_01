-- 1.Tạo bảng employees_log với cấu trúc phù hợp
CREATE TABLE employees_log (
    log_id SERIAL PRIMARY KEY,
    employee_id INT,
    operation VARCHAR(10),
    old_data JSONB,
    new_data JSONB,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	Constraint foreign key (employee_id) REFERENCES employees(id)
);

-- 2.Viết Function Trigger bằng PL/pgSQL
CREATE FUNCTION log_employee_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO employees_log(employee_id, operation, new_data)
        VALUES (NEW.id, TG_OP, to_jsonb(NEW));
    
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO employees_log(employee_id, operation, old_data, new_data)
        VALUES (NEW.id, TG_OP, to_jsonb(OLD), to_jsonb(NEW));
    
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO employees_log(employee_id, operation, old_data)
        VALUES (OLD.id, TG_OP, to_jsonb(OLD));
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- 3.Tạo Trigger gắn với bảng employees
CREATE TRIGGER trg_employee_audit
AFTER INSERT OR UPDATE OR DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_changes();

-- 4.Thực hành: chèn, cập nhật và xóa dữ liệu nhân viên, kiểm tra log có chính xác không
INSERT INTO employees (name, position, salary) 
VALUES ('Trần Văn Audit', 'Developer', 2000);

UPDATE employees SET salary = 2500 WHERE name = 'Trần Văn Audit';

DELETE FROM employees WHERE name = 'Trần Văn Audit';

SELECT * FROM employees_log;