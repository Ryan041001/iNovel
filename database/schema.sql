-- iNovel 统一数据库初始化脚本
-- 删除已存在的数据库并重新创建
DROP DATABASE IF EXISTS `inovel`;
CREATE DATABASE `inovel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `inovel`;

-- ============================================
-- 1. 用户表
-- ============================================
CREATE TABLE `user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '用户ID',
  `phone` VARCHAR(20) UNIQUE NOT NULL COMMENT '手机号',
  `password` VARCHAR(255) NOT NULL COMMENT '密码(BCrypt加密)',
  `nickname` VARCHAR(50) DEFAULT '读者' COMMENT '昵称',
  `avatar` VARCHAR(255) DEFAULT '/images/default-avatar.png' COMMENT '头像URL',
  `email` VARCHAR(100) COMMENT '邮箱',
  `gender` TINYINT DEFAULT 0 COMMENT '性别(0-未知,1-男,2-女)',
  `status` TINYINT DEFAULT 1 COMMENT '状态(1-正常,0-禁用)',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_phone (phone),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ============================================
-- 2. 书籍表
-- ============================================
CREATE TABLE `book` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '书籍ID',
  `title` VARCHAR(255) NOT NULL COMMENT '书名',
  `author` VARCHAR(100) DEFAULT '佚名' COMMENT '作者',
  `cover` VARCHAR(500) DEFAULT '/images/default-cover.png' COMMENT '封面图URL',
  `category` VARCHAR(50) DEFAULT '其他' COMMENT '分类',
  `description` TEXT COMMENT '简介',
  `file_path` VARCHAR(500) NOT NULL COMMENT '文件路径',
  `file_type` VARCHAR(20) NOT NULL COMMENT '文件类型(txt/epub/pdf)',
  `file_size` BIGINT DEFAULT 0 COMMENT '文件大小(字节)',
  `total_chapters` INT DEFAULT 0 COMMENT '总章节数',
  `total_words` BIGINT DEFAULT 0 COMMENT '总字数',
  `status` TINYINT DEFAULT 1 COMMENT '状态(1-正常,0-下架)',
  `views` BIGINT DEFAULT 0 COMMENT '浏览次数',
  `upload_user_id` BIGINT COMMENT '上传者ID',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  INDEX idx_category (category),
  INDEX idx_title (title),
  INDEX idx_author (author),
  INDEX idx_status (status),
  INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='书籍表';

-- ============================================
-- 3. 章节内容表
-- ============================================
CREATE TABLE `book_content` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '章节ID',
  `book_id` BIGINT NOT NULL COMMENT '书籍ID',
  `chapter_order` INT NOT NULL COMMENT '章节序号(从1开始)',
  `title` VARCHAR(255) DEFAULT '未命名章节' COMMENT '章节标题',
  `content` LONGTEXT COMMENT '章节内容(HTML格式)',
  `word_count` INT DEFAULT 0 COMMENT '字数',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
  UNIQUE KEY uk_book_chapter (book_id, chapter_order),
  INDEX idx_book_id (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='章节内容表';

-- ============================================
-- 4. 用户书架表
-- ============================================
CREATE TABLE `user_shelf` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '书架ID',
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `book_id` BIGINT NOT NULL COMMENT '书籍ID',
  `last_chapter` INT DEFAULT 1 COMMENT '最后阅读章节序号',
  `reading_progress` DECIMAL(5,2) DEFAULT 0.00 COMMENT '阅读进度(百分比)',
  `is_favorite` TINYINT DEFAULT 0 COMMENT '是否收藏(1-是,0-否)',
  `add_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `last_read_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '最后阅读时间',
  FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
  UNIQUE KEY uk_user_book (user_id, book_id),
  INDEX idx_user_id (user_id),
  INDEX idx_last_read_time (last_read_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户书架表';

-- ============================================
-- 5. 阅读笔记/批注表
-- ============================================
CREATE TABLE `annotation` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '批注ID',
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `book_id` BIGINT NOT NULL COMMENT '书籍ID',
  `chapter_id` BIGINT NOT NULL COMMENT '章节ID',
  `content` TEXT NOT NULL COMMENT '批注内容',
  `position` VARCHAR(100) COMMENT '批注位置(如:段落索引、字符位置等)',
  `color` VARCHAR(20) DEFAULT '#FFD700' COMMENT '高亮颜色',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
  FOREIGN KEY (chapter_id) REFERENCES book_content(id) ON DELETE CASCADE,
  INDEX idx_user_book (user_id, book_id),
  INDEX idx_chapter (chapter_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='阅读批注表';

-- ============================================
-- 6. 书籍分类表(可选,用于标准化分类)
-- ============================================
CREATE TABLE `category` (
  `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '分类ID',
  `name` VARCHAR(50) UNIQUE NOT NULL COMMENT '分类名称',
  `description` VARCHAR(200) COMMENT '分类描述',
  `sort_order` INT DEFAULT 0 COMMENT '排序',
  `status` TINYINT DEFAULT 1 COMMENT '状态(1-启用,0-禁用)',
  INDEX idx_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='书籍分类表';

-- ============================================
-- 初始化分类数据
-- ============================================
INSERT INTO `category` (`name`, `description`, `sort_order`) VALUES
('玄幻', '玄幻修真类小说', 1),
('武侠', '武侠江湖类小说', 2),
('仙侠', '仙侠修仙类小说', 3),
('科幻', '科幻未来类小说', 4),
('都市', '都市生活类小说', 5),
('历史', '历史架空类小说', 6),
('军事', '军事战争类小说', 7),
('悬疑', '悬疑推理类小说', 8),
('文学', '纯文学作品', 9),
('其他', '其他类型', 99);

-- ============================================
-- 初始化测试用户
-- ============================================
-- 密码: 123456 (BCrypt加密后的哈希值需要在应用层生成)
INSERT INTO `user` (`phone`, `password`, `nickname`, `email`) VALUES
('13800138000', '$2a$10$XYZ...', '测试用户', 'test@inovel.com');

-- ============================================
-- 视图:用户阅读统计
-- ============================================
CREATE VIEW `view_user_reading_stats` AS
SELECT 
  u.id AS user_id,
  u.nickname,
  COUNT(DISTINCT us.book_id) AS total_books,
  COALESCE(AVG(us.reading_progress), 0) AS avg_progress,
  COUNT(DISTINCT a.id) AS total_annotations,
  MAX(us.last_read_time) AS last_read_time
FROM user u
LEFT JOIN user_shelf us ON u.id = us.user_id
LEFT JOIN annotation a ON u.id = a.user_id
GROUP BY u.id, u.nickname;

-- ============================================
-- 视图:热门书籍排行
-- ============================================
CREATE VIEW `view_popular_books` AS
SELECT 
  b.id,
  b.title,
  b.author,
  b.cover,
  b.category,
  b.views,
  COUNT(DISTINCT us.user_id) AS reader_count,
  COUNT(DISTINCT a.id) AS annotation_count
FROM book b
LEFT JOIN user_shelf us ON b.id = us.book_id
LEFT JOIN annotation a ON b.id = a.book_id
WHERE b.status = 1
GROUP BY b.id, b.title, b.author, b.cover, b.category, b.views
ORDER BY b.views DESC, reader_count DESC;

-- ============================================
-- 触发器:更新书籍浏览次数
-- ============================================
DELIMITER $$
CREATE TRIGGER `update_book_views`
AFTER INSERT ON `user_shelf`
FOR EACH ROW
BEGIN
  UPDATE book SET views = views + 1 WHERE id = NEW.book_id;
END$$
DELIMITER ;
