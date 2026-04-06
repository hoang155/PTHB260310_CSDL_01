-- 1.Viết Transaction thực hiện toàn bộ quy trình đặt hàng cho khách "Nguyen Van A" gồm:
-- a.Mua 2 sản phẩm:
-- i.product_id = 1, quantity = 2
-- ii.product_id = 2, quantity = 1
-- b.Nếu một trong hai sản phẩm không đủ hàng, toàn bộ giao dịch phải bị ROLLBACK
-- c.Nếu thành công, COMMIT và cập nhật chính xác số lượng tồn kho
DO $$
DECLARE
    v_order_id INT;
    v_price_1 NUMERIC(10,2);
    v_price_2 NUMERIC(10,2);
    v_total_amount NUMERIC(10,2) := 0;
BEGIN
    SELECT price INTO v_price_1 FROM products WHERE product_id = 1 FOR UPDATE;
    SELECT price INTO v_price_2 FROM products WHERE product_id = 2 FOR UPDATE;

    UPDATE products SET stock = stock - 2 WHERE product_id = 1;
    UPDATE products SET stock = stock - 1 WHERE product_id = 2;

    v_total_amount := (v_price_1 * 2) + (v_price_2 * 1);

    INSERT INTO orders (customer_name, total_amount) 
    VALUES ('Nguyen Van A', v_total_amount) 
    RETURNING order_id INTO v_order_id;

    INSERT INTO order_items (order_id, product_id, quantity, subtotal)
    VALUES 
        (v_order_id, 1, 2, v_price_1 * 2),
        (v_order_id, 2, 1, v_price_2 * 1);

    RAISE NOTICE 'Đã tạo đơn hàng thành công với ID: %, Tổng tiền: %', v_order_id, v_total_amount;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Giao dịch thất bại, hệ thống thực hiện Rollback. Lỗi: %', SQLERRM;
    ROLLBACK;
END $$;

-- 2.Mô phỏng lỗi:
-- a.Giảm tồn kho của một sản phẩm xuống 0, sau đó chạy Transaction đặt hàng
-- b.Kiểm tra kết quả khi có và không có Transaction
UPDATE products SET stock = stock - 2 WHERE product_id = 1; 

UPDATE products SET stock = stock - 1 WHERE product_id = 2;

DO $$
DECLARE
    v_order_id INT;
    v_price_1 NUMERIC;
    v_price_2 NUMERIC;
BEGIN
    SELECT price INTO v_price_1 FROM products WHERE product_id = 1;
    SELECT price INTO v_price_2 FROM products WHERE product_id = 2;

    UPDATE products SET stock = stock - 2 WHERE product_id = 1;

    UPDATE products SET stock = stock - 1 WHERE product_id = 2;

    INSERT INTO orders (customer_name, total_amount) VALUES ('Nguyen Van A', 0) RETURNING order_id INTO v_order_id;
    
EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Phát hiện lỗi: %. Đang thực hiện ROLLBACK toàn bộ!', SQLERRM;
END $$;