-- 1.Tạo Transaction đặt vé thành công
-- a.Bắt đầu transaction bằng BEGIN;
-- b.Giảm số ghế của chuyến bay 'VN123' đi 1
-- c.Thêm bản ghi đặt vé của khách hàng 'Nguyen Van A'
-- d.Kết thúc bằng COMMIT;
BEGIN;

UPDATE flights 
SET available_seats = available_seats - 1 
WHERE flight_name = 'VN123';

INSERT INTO bookings (flight_id, customer_name) 
VALUES (1, 'Nguyen Van A');

COMMIT;
-- e.Kiểm tra lại dữ liệu bảng flights và bookings
SELECT * FROM flights;
SELECT * FROM bookings;

-- 2.Mô phỏng lỗi và Rollback
-- a.Thực hiện lại các bước trên nhưng nhập sai flight_id trong bảng bookings
-- b.Gọi ROLLBACK; để hủy toàn bộ thay đổi
-- c.Kiểm tra lại dữ liệu và chứng minh rằng số ghế không thay đổ
BEGIN;

UPDATE flights 
SET available_seats = available_seats - 1 
WHERE flight_name = 'VN456';

INSERT INTO bookings (flight_id, customer_name) 
VALUES (999, 'Khách hàng lỗi');

ROLLBACK;

SELECT * FROM flights WHERE flight_name = 'VN456';
SELECT * FROM bookings;