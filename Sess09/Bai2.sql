-- 1.Tạo Hash Index trên cột email
CREATE INDEX idx_users_email_hash ON Users USING HASH (email);

-- 2.Viết truy vấn SELECT * FROM Users WHERE email = 'example@example.com'; và kiểm tra kế hoạch thực hiện bằng EXPLAIN
EXPLAIN ANALYZE 
SELECT * FROM Users WHERE email = 'example@example.com';