-- 1.Tạo bảng accounts:
-- Tạo bảng tài khoản
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(50),
    balance NUMERIC(15, 2) CHECK (balance >= 0) -- Ràng buộc không cho số dư âm
);

-- 2.Thêm 2 bản ghi vào accounts với số dư ban đầu
INSERT INTO accounts (owner_name, balance) VALUES 
('HoangPK', 1000.00),
('Nguyen Van B', 500.00);

-- 3.Viết một transaction:
-- a.Kiểm tra số dư tài khoản gửi
-- b.Nếu đủ tiền, trừ số tiền từ tài khoản gửi, cộng vào tài khoản nhận và COMMIT
-- c.Nếu không đủ tiền, ROLLBACK
DO $$
DECLARE
    v_sender_id INT := 1;
    v_receiver_id INT := 2;
    v_amount NUMERIC := 400.00;
    v_sender_balance NUMERIC;
BEGIN
    SELECT balance INTO v_sender_balance 
    FROM accounts 
    WHERE account_id = v_sender_id 
    FOR UPDATE;

    IF v_sender_balance >= v_amount THEN
        UPDATE accounts SET balance = balance - v_amount WHERE account_id = v_sender_id;
        
        UPDATE accounts SET balance = balance + v_amount WHERE account_id = v_receiver_id;
        
        RAISE NOTICE 'Giao dịch thành công! Đã chuyển % từ ID % sang ID %', v_amount, v_sender_id, v_receiver_id;
    ELSE
        RAISE EXCEPTION 'Giao dịch thất bại: Tài khoản ID % không đủ số dư (Hiện có: %)', v_sender_id, v_sender_balance;
    END IF;

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Đã xảy ra lỗi: %. Toàn bộ thay đổi đã được hoàn tác.', SQLERRM;
END $$;

-- 4.Thực hành chuyển tiền hợp lệ và không hợp lệ, quan sát kết quả trên bảng accounts
DO $$
DECLARE
    v_amount NUMERIC := 200.00; 
BEGIN
    UPDATE accounts SET balance = balance - v_amount WHERE account_id = 1;

    UPDATE accounts SET balance = balance + v_amount WHERE account_id = 2;

    RAISE NOTICE 'Giao dịch HỢP LỆ thành công!';
END $$;

SELECT * FROM accounts;