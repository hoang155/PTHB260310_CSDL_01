-- 1.Tạo Procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC) để tăng giá tất cả sản phẩm trong một category_id theo phần trăm
-- 2.Sử dụng biến để tính giá mới cho từng sản phẩm trong vòng lặp
CREATE PROCEDURE update_product_price(
    p_category_id INT, 
    p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    r_product RECORD;
    v_new_price NUMERIC;
BEGIN
    FOR r_product IN 
        SELECT product_id, price 
        FROM Products 
        WHERE category_id = p_category_id
    LOOP
        v_new_price := r_product.price * (1 + p_increase_percent / 100);

        UPDATE Products 
        SET price = v_new_price 
        WHERE product_id = r_product.product_id;

        RAISE NOTICE 'Sản phẩm ID % đã được tăng lên giá mới: %', r_product.product_id, v_new_price;
    END LOOP;
    
    RAISE NOTICE 'Đã hoàn tất cập nhật cho danh mục %', p_category_id;
END;
$$;

-- 3.Thử gọi Procedure với các tham số mẫu và kiểm tra kết quả trong bảng Products
SELECT * FROM Products WHERE category_id = 1;

CALL update_product_price(1, 10);

SELECT * FROM Products WHERE category_id = 1;