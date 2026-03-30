-- 1.Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date
CREATE PROCEDURE calculate_total_sales(
    IN start_date DATE, 
    IN end_date DATE, 
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(amount) 
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;

    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;

-- 2.Gọi Procedure với các ngày mẫu và hiển thị kết quả
CALL calculate_total_sales('2024-01-01', '2024-01-31', NULL);