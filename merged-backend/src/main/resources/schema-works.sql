-- 作品表 (整合自原iNovel的ebookinfo)
CREATE TABLE IF NOT EXISTS works (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '作品ID',
    title VARCHAR(200) NOT NULL COMMENT '作品标题',
    cover VARCHAR(500) COMMENT '封面图片路径',
    category VARCHAR(50) COMMENT '作品分类',
    description TEXT COMMENT '作品简介',
    author_id BIGINT NOT NULL COMMENT '作者ID',
    author_name VARCHAR(100) NOT NULL COMMENT '作者名称',
    status TINYINT DEFAULT 0 COMMENT '状态: 0-草稿, 1-连载中, 2-已完结',
    word_count INT DEFAULT 0 COMMENT '字数统计',
    view_count INT DEFAULT 0 COMMENT '浏览量',
    like_count INT DEFAULT 0 COMMENT '点赞数',
    collect_count INT DEFAULT 0 COMMENT '收藏数',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_author_id (author_id),
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_update_time (update_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='作品表';

-- 章节表 (整合自原iNovel的chapterinfo)
CREATE TABLE IF NOT EXISTS chapters (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '章节ID',
    work_id BIGINT NOT NULL COMMENT '所属作品ID',
    chapter_num INT NOT NULL COMMENT '章节序号',
    title VARCHAR(200) COMMENT '章节标题',
    content LONGTEXT NOT NULL COMMENT '章节内容',
    word_count INT DEFAULT 0 COMMENT '字数',
    view_count INT DEFAULT 0 COMMENT '浏览量',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_work_id (work_id),
    INDEX idx_chapter_num (work_id, chapter_num),
    FOREIGN KEY (work_id) REFERENCES works(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='章节表';

-- 为User表添加作者相关字段(如果需要)
ALTER TABLE user ADD COLUMN IF NOT EXISTS is_author TINYINT DEFAULT 0 COMMENT '是否为作者: 0-否, 1-是';
ALTER TABLE user ADD COLUMN IF NOT EXISTS author_intro TEXT COMMENT '作者简介';
ALTER TABLE user ADD COLUMN IF NOT EXISTS author_level TINYINT DEFAULT 1 COMMENT '作者等级';

-- 粉丝关系表
CREATE TABLE IF NOT EXISTS author_fans (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    author_id BIGINT NOT NULL COMMENT '作者ID',
    fan_id BIGINT NOT NULL COMMENT '粉丝ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '关注时间',
    UNIQUE KEY uk_author_fan (author_id, fan_id),
    INDEX idx_author_id (author_id),
    INDEX idx_fan_id (fan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='作者粉丝关系表';

-- 用户收藏作品表
CREATE TABLE IF NOT EXISTS user_work_collect (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    work_id BIGINT NOT NULL COMMENT '作品ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    UNIQUE KEY uk_user_work (user_id, work_id),
    INDEX idx_user_id (user_id),
    INDEX idx_work_id (work_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户收藏作品表';

-- 用户点赞作品表
CREATE TABLE IF NOT EXISTS user_work_like (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    work_id BIGINT NOT NULL COMMENT '作品ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
    UNIQUE KEY uk_user_work (user_id, work_id),
    INDEX idx_user_id (user_id),
    INDEX idx_work_id (work_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户点赞作品表';

-- 插入测试数据
INSERT INTO works (title, cover, category, description, author_id, author_name, status, word_count, view_count, like_count, collect_count)
VALUES 
('诡秘之主', '/images/books/1.jpg', '玄幻', '蒸汽与机械的浪潮中，谁能触及非凡？', 1, '爱潜水的乌贼', 2, 4563200, 128956, 8562, 3265),
('凡人修仙传', '/images/books/2.jpg', '仙侠', '一个普通山村少年，偶然进入当地江湖小门派...', 2, '忘语', 2, 5823000, 95632, 7421, 2896),
('择天记', '/images/books/3.jpg', '玄幻', '太始元年，有神石自天而降，分散落于世界各处...', 3, '猫腻', 2, 3956000, 76521, 5896, 2156);
