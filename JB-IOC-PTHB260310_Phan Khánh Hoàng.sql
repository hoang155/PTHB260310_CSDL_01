--PHẦN 1: THAO TÁC VỚI DỮ LIỆU CÁC BẢNG
--1.Tạo bảng
CREATE TABLE Customer (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_full_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL UNIQUE,
    customer_phone VARCHAR(15) NOT NULL,
    customer_address VARCHAR(255) NOT NULL
);

CREATE TABLE Room (
    room_id VARCHAR(5) PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    room_price DECIMAL(10, 2) NOT NULL,
    room_status VARCHAR(20) NOT NULL,
    room_area INT NOT NULL
);

CREATE TABLE Booking (
    booking_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(5) NOT NULL,
    room_id VARCHAR(5) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_room FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

--2.Chèn dữ liệu
Insert Into Customer (customer_id,customer_full_name,customer_email,customer_phone,customer_address) Values
('C001','Nguyen Anh Tu','tu.nguyen@example.com',0912345678,'Hanoi, Vietnam'),
('C002','Tran Thi Mai','mai.tran@example.com',0923456789,'Ho Chi Minh, Vietnam'),
('C003','Le Minh Hoang','hoang.le@example.com',0934567890,'Danang, Vietnam'),
('C004','Pham Hoang Nam','nam.pham@example.com',0945678901,'Hue, Vietnam'),
('C005','Vu Minh Thu','thu.vu@example.com',0956789012,'Hai Phong, Vietnam');

Insert Into Room (room_id, room_type, room_price, room_status, room_area) Values
('R001', 'Single', 100.0, 'Available', 25),
('R002', 'Double', 150.0, 'Booked', 40),
('R003', 'Suite', 250.0, 'Available', 60),
('R004', 'Single', 120.0, 'Booked', 30),
('R005', 'Double', 160.0, 'Available', 35);

Insert Into Booking (customer_id,room_id,check_in_date,check_out_date,total_amount) Values
('C001','R001','2025-03-01','2025-03-05',400.0),
('C002','R002','2025-03-02','2025-03-06',600.0),
('C003','R003','2025-03-03','2025-03-07',1000.0),
('C004','R004','2025-03-04','2025-03-08',480.0),
('C005','R005','2025-03-05','2025-03-09',800.0);

Insert Into Payment (booking_id,payment_method,payment_date,payment_amount) Values
(1,'Cash','2025-03-05',400.0),
(2,'Credit Card','2025-03-06',600.0),
(3,'Bank Transfer','2025-03-07',1000.0),
(4,'Cash','2025-03-08',480.0),
(5,'Credit Card','2025-03-09',800.0);

--3.Cập nhật dữ liệu
UPDATE Booking
SET total_amount = r.room_price * (b.check_out_date - b.check_in_date)
FROM Booking b join Room r on b.room_id = r.room_id
Where r.room_status = 'Booked'
AND b.check_in_date < CURRENT_DATE;

--4.Xóa dữ liệu
DELETE FROM Payment
WHERE payment_method = 'Cash'
AND payment_amount < 500;

--PHẦN 2: TRUY VẤN DỮ LIỆU
--5.Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email,
--số điện thoại và địa chỉ được sắp xếp theo họ tên khách hàng tăng dần.
Select customer_id,customer_full_name,customer_email,customer_phone,customer_address
From Customer
ORDER BY customer_full_name asc;

--6.Lấy thông tin các phòng khách sạn gồm mã phòng, loại phòng,
--giá phòng và diện tích phòng, sắp xếp theo giá phòng giảm dần.
Select room_id,room_type,room_price,room_area
From Room
ORDER BY room_price desc;

--7.Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng,
--họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.
Select c.customer_id, c.customer_full_name, bk.room_id, bk.check_in_date, bk.check_out_date
From Customer c
JOIN Booking bk on c.customer_id = bk.customer_id;

--8.Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng,
--gồm mã khách hàng, họ tên khách hàng, phương thức thanh toán và số tiền thanh toán,
--sắp xếp theo số tiền thanh toán giảm dần.
Select c.customer_id, c.customer_full_name, p.payment_method, p.payment_amount
From Customer c
JOIN Booking bk on c.customer_id = bk.customer_id
JOIN Payment p on bk.booking_id = p.booking_id
ORDER BY p.payment_amount desc;

--9.Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong
--bảng Customer được sắp xếp theo tên khách hàng.
Select * from Customer
ORDER BY customer_full_name desc --giả sử sắp xếp giảm dần
LIMIT 3 OFFSET 1;

--10.Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có
--tổng số tiền thanh toán trên 1000, gồm mã khách hàng, họ tên khách hàng
Select c.customer_id, c.customer_full_name, COUNT(b.booking_id) AS total_rooms
From Customer c
JOIN Booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_id
HAVING COUNT(b.booking_id) >= 2 AND SUM(b.total_amount) > 1000;

--11.Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000
--và có ít nhất 3 khách hàng đặt, gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán.
Select r.room_id, r.room_type, r.room_price, SUM(bk.total_amount) AS total_revenue
From Room r
JOIN Booking bk on r.room_id = bk.room_id
GROUP BY r.room_id
HAVING SUM(b.total_amount) < 1000 and COUNT(bk.customer_id) >= 3;

--12.Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000
--gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
Select c.customer_id, c.customer_full_name, bk.room_id, SUM(bk.total_amount) AS total_spent
From Customer c
JOIN Booking bk on c.customer_id = bk.customer_id
GROUP BY c.customer_id, c.customer_full_name, bk.room_id
HAVING SUM(bk.total_amount) > 1000;

--13.Lấy danh sách các khách hàng (mã KH, Họ tên, Email, SĐT) có họ tên chứa chữ "Minh"
--hoặc địa chỉ (address) ở "Hanoi". Sắp xếp kết quả theo họ tên tăng dần.
Select customer_id, customer_full_name, customer_email, customer_phone
From Customer
WHERE customer_full_name LIKE '%Minh%' or customer_address LIKE '%Hanoi%'
ORDER BY customer_full_name asc;

--14.Lấy danh sách tất cả các phòng (Mã phòng, Loại phòng, Giá)
--sắp xếp theo giá phòng giảm dần. Hiển thị 5 phòng tiếp theo sau 5 phòng đầu tiên
--(tức là lấy kết quả của trang thứ 2, biết mỗi trang có 5 phòng).
Select room_id, room_type, room_price
From Room
ORDER BY room_price DESC
LIMIT 5 OFFSET 5;

--PHẦN 3: TẠO VIEW
--15.Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt,
--với điều kiện ngày nhận phòng nhỏ hơn ngày 2025-03-10. Cần hiển thị các thông tin sau:
--Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
Create VIEW view_room_booked as
Select r.room_id, r.room_type, c.customer_id, c.customer_full_name
From Room r
JOIN Booking bk on bk.room_id = r.room_id
JOIN Customer c on c.customer_id = bk.customer_id
WHERE bk.check_in_date < '2025-03-10';

--16.Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt,
--với điều kiện diện tích phòng lớn hơn 30 m². Cần hiển thị các thông tin sau:
--Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng
Create VIEW view_customer_book_room as
Select c.customer_id, c.customer_full_name, r.room_id, r.room_area
From Customer c
JOIN Booking bk on bk.customer_id = c.customer_id
JOIN Room r on r.room_id = bk.room_id
WHERE r.room_area >30;

--PHẦN 4: TẠO TRIGGER
--17.Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu
--mối khi chèn vào bảng Booking. Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì
--thông báo lỗi với nội dung “Ngày đặt phòng không thể sau ngày trả phòng được !”
--và hủy thao tác chèn dữ liệu vào bảng.
CREATE FUNCTION check_booking_dates()
RETURNS TRIGGER	
LANGUAGE plpgsql
AS $$ 
	BEGIN
	    IF NEW.check_in_date > NEW.check_out_date THEN
	        RAISE EXCEPTION 'Ngày đặt phòng không thể sau ngày trả phòng được !';
	    END IF;
	    RETURN NEW;
	END;
$$

CREATE TRIGGER check_insert_booking
BEFORE INSERT ON Booking
FOR EACH ROW
EXECUTE FUNCTION check_booking_dates();

--18.Hãy tạo một trigger có tên là update_room_status_on_booking để tự động
--cập nhật trạng thái phòng thành "Booked" khi một phòng được đặt
--(khi có bản ghi được INSERT vào bảng Booking).
CREATE FUNCTION update_room_status()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Room
    SET room_status = 'Booked'
    WHERE room_id = NEW.room_id;
    RETURN NEW;
END;
$$

CREATE TRIGGER update_room_status_on_booking
AFTER INSERT ON Booking
FOR EACH ROW
EXECUTE FUNCTION update_room_status();

--PHẦN 5: TẠO STORE PROCEDURE
--19.Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
CREATE PROCEDURE add_customer(
    p_id VARCHAR(5),
    p_full_name VARCHAR(100),
    p_email VARCHAR(100),
    p_phone VARCHAR(15),
    p_address VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Customer (customer_id, customer_full_name, customer_email, customer_phone, customer_address)
    VALUES (p_id, p_full_name, p_email, p_phone, p_address);
    RAISE NOTICE 'Khách hàng đã được thêm thành công!';
END;
$$;

--20.Hãy tạo một Stored Procedure có tên là add_payment để thực hiện việc thêm một thanh toán mới cho một lần đặt phòng.
CREATE PROCEDURE add_payment(
    p_booking_id INT,
    p_payment_method VARCHAR(50),
	p_payment_amount DECIMAL(10, 2),
    p_payment_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Payment (booking_id, payment_method, payment_date, payment_amount)
    VALUES (p_booking_id, p_method, p_date, p_amount);
    RAISE NOTICE 'Thanh toán cho đơn đặt phòng đã được ghi nhận.';
END;
$$;