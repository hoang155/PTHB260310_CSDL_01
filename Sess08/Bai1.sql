-- 1.Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC)
-- a.Tham số order_id_input: mã đơn hàng cần tính
-- b.Tham số total: tổng giá trị đơn hàng
-- 2.Trong Procedure:
-- a.Viết câu lệnh tính tổng tiền theo order_id
CREATE PROCEDURE calculate_order_total(
    IN order_id_input INT, 
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(quantity * unit_price) 
    INTO total
    FROM order_detail
    WHERE order_id = order_id_input;
    
    IF total IS NULL THEN
        total := 0;
    END IF;
END;
$$;

-- 3.Gọi Procedure để kiểm tra hoạt động với một order_id cụ thể
CALL calculate_order_total(1, 0);