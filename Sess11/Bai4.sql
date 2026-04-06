-- 1.Viết Transaction thực hiện rút tiền
-- a.Bắt đầu BEGIN;
-- b.Kiểm tra balance của tài khoản
-- c.Nếu đủ, trừ số dư và ghi vào bảng transactions
-- d.Nếu bất kỳ bước nào thất bại → ROLLBACK;
-- e.Nếu thành công → COMMIT;
DO $$
DECLARE
    v_account_id INT := 1;
    v_withdraw_amount NUMERIC := 200.00; 
    v_current_balance NUMERIC;
BEGIN
    SELECT balance INTO v_current_balance 
    FROM accounts 
    WHERE account_id = v_account_id 
    FOR UPDATE;

    IF v_current_balance >= v_withdraw_amount THEN
        
        UPDATE accounts 
        SET balance = balance - v_withdraw_amount 
        WHERE account_id = v_account_id;

        INSERT INTO transactions (account_id, amount, trans_type)
        VALUES (v_account_id, v_withdraw_amount, 'WITHDRAW');

        RAISE NOTICE 'Rút tiền thành công. Số dư mới: %', (v_current_balance - v_withdraw_amount);
    ELSE
        RAISE EXCEPTION 'Số dư không đủ để thực hiện giao dịch!';
    END IF;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Giao dịch thất bại. Lỗi: %. Hệ thống thực hiện ROLLBACK.', SQLERRM;
    ROLLBACK;
END $$;

-- 2.Mô phỏng lỗi
-- a.Cố ý chèn lỗi trong bước ghi log (ví dụ nhập sai account_id trong bảng transactions)
-- b.Quan sát và chứng minh rằng sau khi ROLLBACK, số dư vẫn không thay đổi
BEGIN;

UPDATE accounts SET balance = balance - 200.00 WHERE account_id = 1;

INSERT INTO transactions (account_id, amount, trans_type)
VALUES (999, 200.00, 'WITHDRAW'); 

ROLLBACK;

SELECT * FROM accounts WHERE account_id = 1;

-- 3.Kiểm tra tính toàn vẹn dữ liệu
-- a.Chạy Transaction nhiều lần, đảm bảo rằng mỗi bản ghi trong transactions tương ứng đúng với một thay đổi balance
-- Kiểm tra tổng số tiền đã rút trong bảng Log so với số dư khởi tạo
SELECT 
    a.customer_name,
    a.balance AS current_balance,
    (SELECT SUM(amount) FROM transactions WHERE account_id = a.account_id AND trans_type = 'WITHDRAW') AS total_withdrawn
FROM accounts a;