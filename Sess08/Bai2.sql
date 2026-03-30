-- 1.Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:
-- a.Kiểm tra xem sản phẩm có đủ hàng không
-- b.Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
CREATE PROCEDURE check_stock(p_id INT, p_qty INT)
LANGUAGE plpgsql
AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT quantity INTO current_stock
    FROM inventory
    WHERE product_id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sản phẩm với ID % không tồn tại trong hệ thống', p_id;
    END IF;

    IF current_stock < p_qty THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho (Hiện có: %, Cần: %)', current_stock, p_qty;
    ELSE
        RAISE NOTICE 'Đủ hàng. Sản phẩm ID % hiện còn % món.', p_id, current_stock;
    END IF;
END;
$$;

-- 2.Gọi Procedure với các trường hợp:
-- a.Một sản phẩm có đủ hàng
CALL check_stock(1, 2);
-- b.Một sản phẩm không đủ hàng
CALL check_stock(1, 50);