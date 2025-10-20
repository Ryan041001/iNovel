-- iNovel batch book import script
-- Import books from merged-backend/src/main/resources/books folder
-- Note: This script assumes admin user ID is 1, create if not exists

USE `inovel`;

-- Ensure admin user exists
INSERT IGNORE INTO `user` (id, phone, password, nickname, status) 
VALUES (1, '10000000000', '$2a$10$SlzLZkrFo6c0yz0cJWG0vO3L7W5d8L7X7Z5Y9X8V8Z5Y9X8V8Z5Y9', '管理员', 1);

-- ============================================
-- Add book data
-- ============================================

-- 1. Shengxu
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('圣墟（校对版全本+番外）', '辰东', '网络文学', '一段被命名为圣墟的故事', '/resources/books/圣墟.txt', 'txt', 1, 1, 'public');

-- 2. Zhetianji
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('择天记', '猫腻', '网络文学', '一个关于选择的故事', '/resources/books/择天记.txt', 'txt', 1, 1, 'public');

-- 3. Guimizhu
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('诡秘之主', '狐尾的笔', '网络文学', '精校版全本小说', '/resources/books/诡秘之主.txt', 'txt', 1, 1, 'public');

-- 4. Xuezhanghandan
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('雪中悍刀行', '烽火戏诸侯', '网络文学', '完结版大全集（全20册）', '/resources/books/雪中悍刀行.epub', 'epub', 1, 1, 'public');

-- 5. Yuanzun (epub)
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('元尊', '天蚕土豆', '网络文学', '阅文集团知名网络文学作品', '/resources/books/yuanzun.epub', 'epub', 1, 1, 'public');

-- 6. Yuanzun (txt)
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('元尊（文本版）', '天蚕土豆', '网络文学', '元尊完整文本版', '/resources/books/yuanzun.txt', 'txt', 1, 1, 'public');

-- 7. Jianlai
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('剑来', '狐尾的笔', '网络文学', '一部充满诗意的剑客传奇', '/resources/books/jianlai.txt', 'txt', 1, 1, 'public');

-- 8. Dafeng Daguaren
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('大奉打更人', '卖报小郎君', '网络文学', '诡异的驱鬼故事', '/resources/books/dafeng.txt', 'txt', 1, 1, 'public');

-- 9. Doupo Cangqiong
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('斗破苍穹', '天蚕土豆', '网络文学', '一部经典的网络文学作品', '/resources/books/doupo.txt', 'txt', 1, 1, 'public');

-- 10. Mushen Ji
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('牧神记', '狐尾的笔', '网络文学', '跨越诸天万界的传奇故事', '/resources/books/mushen.txt', 'txt', 1, 1, 'public');

-- 11. Perfect World
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('完美世界', '辰东', '网络文学', '宏大的诸天万界设定', '/resources/books/wanmei.txt', 'txt', 1, 1, 'public');

-- 12. Zheitian
INSERT INTO `book` (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES ('遮天', '辰东', '网络文学', '一部充满想象的长篇巨著', '/resources/books/zhetian.txt', 'txt', 1, 1, 'public');

-- ============================================
-- Verify insertion results
-- ============================================
SELECT 'Books added successfully:' as '操作结果';
SELECT id, title, author, category, file_type FROM `book` WHERE upload_user_id = 1 ORDER BY create_time DESC;

-- Statistics
SELECT CONCAT('Total books added: ', COUNT(*), ' books') as '统计' FROM `book` WHERE upload_user_id = 1;
