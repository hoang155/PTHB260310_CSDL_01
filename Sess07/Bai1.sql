-- 1.Tạo các chỉ mục phù hợp để tối ưu truy vấn sau:
CREATE INDEX idx_book_genre ON book(genre);

-- 2.So sánh thời gian truy vấn trước và sau khi tạo Index (dùng EXPLAIN ANALYZE)
EXPLAIN ANALYZE SELECT * FROM book WHERE genre = 'Fantasy';

-- 3.Thử nghiệm các loại chỉ mục khác nhau:
-- a.B-tree cho genre
-- b.GIN cho title hoặc description (phục vụ tìm kiếm full-text)
CREATE INDEX idx_book_description_gin ON book USING GIN (to_tsvector('english', description));

-- 4.Tạo một Clustered Index (sử dụng lệnh CLUSTER) trên bảng book theo cột genre và kiểm tra sự khác biệt trong hiệu suất
CLUSTER book USING idx_book_genre;

CLUSTER book;
-- 5.Viết báo cáo ngắn (5-7 dòng) giải thích:
-- a.Loại chỉ mục nào hiệu quả nhất cho từng loại truy vấn?
-- Loại chỉ mục hiệu quả: B-tree là "vua" cho các phép so sánh bằng (=) hoặc dải (BETWEEN).
-- GIN với pg_trgm hoặc tsvector là lựa chọn tối ưu nhất cho truy vấn tìm kiếm văn bản phức tạp (LIKE, ILIKE).
-- Clustered Index giúp tăng tốc đột biến khi bạn thường xuyên lọc dữ liệu theo nhóm.

-- b.Khi nào Hash index không được khuyến khích trong PostgreSQL?
-- Mặc dù nhanh cho phép so sánh bằng,
-- nhưng Hash Index trong PostgreSQL không được khuyến khích vì nó không hỗ trợ so sánh dải (như >),
-- không thể sắp xếp dữ liệu, dẫn đến nguy cơ mất dữ liệu khi hệ thống gặp sự cố.