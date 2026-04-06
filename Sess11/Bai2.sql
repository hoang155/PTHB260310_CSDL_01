-- 1.Thực hiện giao dịch chuyển tiền hợp lệ
-- a.Dùng BEGIN; để bắt đầu transaction
-- b.Cập nhật giảm số dư của A, tăng số dư của B
-- c.Dùng COMMIT; để hoàn tất
-- d.Kiểm tra số dư mới của cả hai tài khoản
BEGIN;

UPDATE accounts 
SET balance = balance - 100.00 
WHERE owner_name = 'A';

UPDATE accounts 
SET balance = balance + 100.00 
WHERE owner_name = 'B';

COMMIT;

SELECT * FROM accounts;

-- 2.Thử mô phỏng lỗi và Rollback
-- a.Lặp lại quy trình trên, nhưng cố ý nhập sai account_id của người nhận
-- b.Gọi ROLLBACK; khi xảy ra lỗi
-- c.Kiểm tra lại số dư, đảm bảo không có thay đổi
BEGIN;

UPDATE accounts 
SET balance = balance - 100.00 
WHERE owner_name = 'A';

UPDATE accounts 
SET balance = balance + 100.00 
WHERE account_id = 999; 

ROLLBACK;

SELECT * FROM accounts;