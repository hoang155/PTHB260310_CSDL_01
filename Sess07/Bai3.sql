-- 1.Tối ưu hóa truy vấn tìm kiếm bài đăng công khai theo từ khóa:
-- a.Tạo Expression Index sử dụng LOWER(content) để tăng tốc tìm kiếm
CREATE INDEX idx_post_content ON post (content);
-- b.So sánh hiệu suất trước và sau khi tạo chỉ mục
EXPLAIN ANALYZE 
SELECT * FROM post 
WHERE is_public = TRUE AND content LIKE '%du lịch%';

-- 2.Tối ưu hóa truy vấn lọc bài đăng theo thẻ (tags):
-- a.Tạo GIN Index cho cột tags
CREATE INDEX idx_post_tags_gin ON post USING GIN (tags);
-- b.Phân tích hiệu suất bằng EXPLAIN ANALYZE
EXPLAIN ANALYZE 
SELECT * FROM post WHERE tags @> ARRAY['travel'];

-- 3.Tối ưu hóa truy vấn tìm bài đăng mới trong 7 ngày gần nhất:
-- a.Tạo Partial Index cho bài viết công khai gần đây:
CREATE INDEX idx_post_recent_public 
ON post(created_at DESC) 
WHERE is_public = TRUE;
-- b.Kiểm tra hiệu suất với truy vấn:
EXPLAIN ANALYZE
SELECT * FROM post 
WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';

-- 4.Phân tích chỉ mục tổng hợp (Composite Index):
-- a.Tạo chỉ mục (user_id, created_at DESC)
CREATE INDEX idx_user_recent_posts 
ON post (user_id, created_at DESC);
-- b.Kiểm tra hiệu suất khi người dùng xem “bài đăng gần đây của bạn bè”
EXPLAIN ANALYZE
SELECT * FROM post 
WHERE user_id IN (10, 25, 30) 
ORDER BY created_at DESC 
LIMIT 10;