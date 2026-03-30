-- 1.Viết Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC) để:
-- a.Lấy price và discount_percent của sản phẩm
-- b.Tính giá sau giảm:
--  p_final_price = price - (price * discount_percent / 100)
-- c.Nếu phần trăm giảm giá > 50, thì giới hạn chỉ còn 50%
-- 2.Cập nhật lại cột price trong bảng products thành giá sau giảm
CREATE PROCEDURE calculate_discount(
    p_id INT, 
    OUT p_final_price NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_original_price NUMERIC;
    v_discount INT;
BEGIN
    SELECT price, discount_percent INTO v_original_price, v_discount
    FROM products
    WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sản phẩm ID % không tồn tại', p_id;
    END IF;

    IF v_discount > 50 THEN
        v_discount := 50;
        RAISE NOTICE 'Sản phẩm % có mức giảm quá cao, đã giới hạn về 50%%.', p_id;
    END IF;
	
    p_final_price := v_original_price - (v_original_price * v_discount / 100.0);
    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;
END;
$$;