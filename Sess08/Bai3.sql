-- 1.Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
-- a.Nhận emp_id của nhân viên
-- b.Cập nhật lương theo quy tắc trên
-- c.Trả về p_new_salary (lương mới) sau khi cập nhật
CREATE PROCEDURE adjust_salary(
    p_emp_id INT, 
    OUT p_new_salary NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_salary NUMERIC;
    v_level INT;
BEGIN
    SELECT salary, job_level INTO v_current_salary, v_level
    FROM employees
    WHERE emp_id = p_emp_id;

    IF v_current_salary IS NULL THEN
        RAISE EXCEPTION 'Nhân viên có ID % không tồn tại', p_emp_id;
    END IF;

    IF v_level = 1 THEN
        p_new_salary := v_current_salary * 1.05;
    ELSEIF v_level = 2 THEN
        p_new_salary := v_current_salary * 1.10;
    ELSEIF v_level = 3 THEN
        p_new_salary := v_current_salary * 1.15;
    ELSE
        p_new_salary := v_current_salary;
    END IF;

    UPDATE employees
    SET salary = p_new_salary
    WHERE emp_id = p_emp_id;

    RAISE NOTICE 'Đã cập nhật lương cho nhân viên %. Lương mới: %', p_emp_id, p_new_salary;
END;
$$;