-- iNovel 统一数据库初始化脚本 (修复版)
-- 解决语法错误、外键约束和重复数据问题

-- 删除已存在的数据库并重新创建
DROP DATABASE IF EXISTS `inovel`;
CREATE DATABASE `inovel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `inovel`;
-- Ensure the connection and client use utf8mb4 to avoid encoding/garbage characters when executing this script
SET NAMES utf8mb4;
SET character_set_connection = 'utf8mb4';

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
  `visibility` VARCHAR(20) DEFAULT 'public' COMMENT '可见性(public/private/pending)',
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
-- 5. 笔记/批注表
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
  INDEX idx_user_id (user_id),
  INDEX idx_book_id (book_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='笔记/批注表';

-- ============================================
-- 作品相关表 (整合自原iNovel)
-- ============================================

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

-- 为User表添加作者相关字段
ALTER TABLE user ADD COLUMN is_author TINYINT DEFAULT 0 COMMENT '是否为作者: 0-否, 1-是';
ALTER TABLE user ADD COLUMN author_intro TEXT COMMENT '作者简介';
ALTER TABLE user ADD COLUMN author_level TINYINT DEFAULT 1 COMMENT '作者等级';

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

-- ============================================
-- 视图和触发器
-- ============================================

-- 视图:热门书籍排行
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

-- 触发器:更新书籍浏览次数
DELIMITER $$
CREATE TRIGGER `update_book_views`
AFTER INSERT ON `user_shelf`
FOR EACH ROW
BEGIN
  UPDATE book SET views = views + 1 WHERE id = NEW.book_id;
END$$
DELIMITER ;

-- ============================================
-- 插入测试用户数据
-- ============================================
INSERT INTO `user` (`phone`, `password`, `nickname`, `avatar`, `email`, `gender`, `status`) VALUES
('13800138000', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '测试用户', '/images/default-avatar.png', 'test@example.com', 1, 1), -- 密码: password
('13800138001', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '书虫小明', '/images/default-avatar.png', 'ming@example.com', 1, 1), -- 密码: password
('13800138002', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '文学爱好者', '/images/default-avatar.png', 'literature@example.com', 2, 1); -- 密码: password

-- ============================================
-- 插入测试书籍数据 (书城书籍)
-- ============================================
INSERT INTO `book` (`title`, `author`, `cover`, `category`, `description`, `file_path`, `file_type`, `file_size`, `total_chapters`, `total_words`, `views`, `upload_user_id`) VALUES
-- 古典文学
('红楼梦', '曹雪芹', '/images/books/hongloumeng.jpg', '古典文学', '中国古典小说巅峰之作，描绘了贾、史、王、薛四大家族的兴衰，以及贾宝玉、林黛玉等人的爱情悲剧。', '/books/hongloumeng.txt', 'txt', 2048576, 120, 800000, 1250, 1),

('西游记', '吴承恩', '/images/books/xiyouji.jpg', '古典文学', '讲述了唐僧师徒四人西天取经的故事，充满奇幻冒险和深刻哲理。', '/books/xiyouji.txt', 'txt', 1536000, 100, 650000, 980, 1),

('水浒传', '施耐庵', '/images/books/shuihuzhuan.jpg', '古典文学', '描写了北宋末年以宋江为首的108位好汉在梁山聚义的故事。', '/books/shuihuzhuan.txt', 'txt', 1843200, 120, 720000, 856, 1),

('三国演义', '罗贯中', '/images/books/sanguoyanyi.jpg', '古典文学', '以三国时期的历史为背景，描写了魏、蜀、吴三国之间的政治、军事斗争。', '/books/sanguoyanyi.txt', 'txt', 2097152, 120, 780000, 1100, 1),

-- 现代文学
('活着', '余华', '/images/books/huozhe.jpg', '现代文学', '讲述了福贵一生的坎坷经历，展现了生命的坚韧与无奈。', '/books/huozhe.txt', 'txt', 512000, 8, 85000, 756, 2),

('兄弟', '余华', '/images/books/xiongdi.jpg', '现代文学', '通过李光头和宋钢两个家庭的故事，展现了中国近现代历史变迁。', '/books/xiongdi.txt', 'txt', 1024000, 25, 280000, 634, 2),

('许三观卖血记', '余华', '/images/books/xusanguan.jpg', '现代文学', '讲述了许三观为养家糊口四次卖血的故事，展现了底层人民的生存状态。', '/books/xusanguan.txt', 'txt', 384000, 12, 120000, 523, 2),

-- 当代文学
('百年孤独', '加西亚·马尔克斯', '/images/books/bainian.jpg', '当代文学', '魔幻现实主义代表作，讲述了布恩迪亚家族七代人的传奇故事。', '/books/bainian.txt', 'txt', 768000, 20, 180000, 892, 3),

('追风筝的人', '卡勒德·胡赛尼', '/images/books/zhuifengzheng.jpg', '当代文学', '讲述了阿富汗少年阿米尔与仆人哈桑之间的故事，探讨了背叛、救赎与友谊。', '/books/zhuifengzheng.txt', 'txt', 640000, 25, 150000, 745, 3),

('挪威的森林', '村上春树', '/images/books/nuowei.jpg', '当代文学', '讲述了渡边与直子和绿子的爱情故事，探讨了青春、爱情与死亡。', '/books/nuowei.txt', 'txt', 896000, 15, 200000, 967, 3),

-- 科幻小说
('三体', '刘慈欣', '/images/books/santi.jpg', '科幻', '中国科幻小说巅峰之作，讲述了人类文明与三体文明的生死较量。', '/books/santi.txt', 'txt', 1280000, 30, 350000, 1200, 1),

('球状闪电', '刘慈欣', '/images/books/qiuzhuang.jpg', '科幻', '讲述了少年陈苗在雷暴中发现球状闪电的奇异现象，从而展开的科学探索。', '/books/qiuzhuang.txt', 'txt', 768000, 18, 180000, 834, 1),

('流浪地球', '刘慈欣', '/images/books/liulangdiqiu.jpg', '科幻', '人类为了躲避太阳的毁灭性爆发，不得不推动地球离开太阳系。', '/books/liulangdiqiu.txt', 'txt', 384000, 8, 80000, 756, 1),

-- 武侠小说
('射雕英雄传', '金庸', '/images/books/shediao.jpg', '武侠', '讲述了郭靖、黄蓉等人的江湖故事，展现了侠义精神和民族大义。', '/books/shediao.txt', 'txt', 1536000, 40, 400000, 945, 2),

('神雕侠侣', '金庸', '/images/books/shendiao.jpg', '武侠', '杨过与小龙女的爱情故事，探讨了爱情、责任与江湖恩怨。', '/books/shendiao.txt', 'txt', 1280000, 40, 380000, 823, 2),

('倚天屠龙记', '金庸', '/images/books/yitian.jpg', '武侠', '张无忌在江湖动荡中的成长故事，涉及武林各大门派和朝廷斗争。', '/books/yitian.txt', 'txt', 1792000, 45, 450000, 912, 2),

-- 历史小说
('明朝那些事儿', '当年明月', '/images/books/mingchao.jpg', '历史', '以讲故事的方式讲述明朝历史，从朱元璋到崇祯帝的兴衰历程。', '/books/mingchao.txt', 'txt', 2048000, 50, 500000, 1100, 3),

('曾国藩', '唐浩明', '/images/books/zengguofan.jpg', '历史', '通过曾国藩的人生经历，展现了晚清的历史变迁和人物命运。', '/books/zengguofan.txt', 'txt', 1024000, 25, 250000, 678, 3),

-- 青春文学
('匆匆那年', '九夜茴', '/images/books/congcong.jpg', '青春', '讲述了方茴、陈寻和林嘉茉三个年轻人之间的爱情故事。', '/books/congcong.txt', 'txt', 512000, 12, 100000, 567, 1),

('致我们终将逝去的青春', '辛夷坞', '/images/books/zhiyouth.jpg', '青春', '讲述了郑微等大学生的青春岁月和成长经历。', '/books/zhiyouth.txt', 'txt', 768000, 18, 160000, 634, 1),

-- 悬疑推理
('白夜行', '东野圭吾', '/images/books/baiyexing.jpg', '悬疑', '讲述了雪穂与亮司的黑暗童年，以及他们长大后的命运纠葛。', '/books/baiyexing.txt', 'txt', 896000, 20, 200000, 789, 2),

('解忧杂货店', '东野圭吾', '/images/books/jieyou.jpg', '悬疑', '通过一间废弃的杂货店，讲述了几个年轻人通过信件寻求建议的故事。', '/books/jieyou.txt', 'txt', 640000, 15, 140000, 856, 2),

-- 散文随笔
('看见', '柴静', '/images/books/kanjian.jpg', '散文', '柴静以记者的身份记录的见闻与思考，展现了社会各阶层的面貌。', '/books/kanjian.txt', 'txt', 1024000, 25, 220000, 723, 3),

('我们仨', '杨绛', '/images/books/womensan.jpg', '散文', '杨绛回忆录，讲述了她与丈夫钱钟书、女儿钱瑗的生活点滴。', '/books/womensan.txt', 'txt', 384000, 10, 60000, 634, 3);

-- ============================================
-- 插入测试章节内容 (为部分热门书籍添加章节)
-- ============================================

-- 为《活着》添加章节内容
INSERT INTO `book_content` (`book_id`, `chapter_order`, `title`, `content`, `word_count`) VALUES
(5, 1, '第一章', '<p>徐福贵出生的时候，家里的日子已经很不好过了。</p><p>福贵的父亲是村里唯一的铁匠，母亲靠着给人家缝缝补补维持生家。福贵生下来不久，父亲就得了重病，临死前拉着母亲的手说："我死了以后，你就带着福贵嫁人吧，别守着我了。"</p><p>母亲没有听父亲的话，她一个人把福贵拉扯大。福贵从小就很懂事，帮着母亲干活，村里人都说福贵是个好孩子。</p>', 156),
(5, 2, '第二章', '<p>福贵十五岁那年，母亲也病倒了。临死前，母亲对福贵说："孩子，娘对不起你，没能让你过上好日子。"</p><p>福贵哭着说："娘，你别这么说，你已经很好了。"</p><p>母亲去世后，福贵一个人生活。他继承了父亲的铁匠铺子，开始了独自谋生的日子。</p>', 134);

-- 为《三体》添加章节内容
INSERT INTO `book_content` (`book_id`, `chapter_order`, `title`, `content`, `word_count`) VALUES
(11, 1, '序章', '<p>中国科学院高能物理研究所，地下三十米深处。</p><p>汪淼抬头看看表，凌晨三点四十五分。他已经在这里工作了整整一夜。</p><p>汪淼是纳米材料科学家，这次被请来参与一个绝密项目。项目代号"红岸"，据说与外星文明有关。</p><p>"汪博士，你相信外星人存在吗？"一位军官问他。</p><p>汪淼笑了笑："科学上讲，宇宙这么大，应该存在其他文明。但我没想到会这么快遇到他们。"</p>', 178),
(11, 2, '第一部 科学边界', '<p>汪淼回到家时，天已经亮了。他躺在床上，却怎么也睡不着。</p><p>昨天晚上发生的事情像梦一样不真实。那些科学家、军官，还有那个叫"红岸"的项目。</p><p>汪淼打开电脑，搜索"红岸"这个词。网上什么都没有，这让他更加不安。</p><p>电话铃响了，是研究所的同事打来的："汪博士，你今天还来上班吗？"</p><p>"来，当然来。"汪淼回答。</p>', 145);

-- 为《百年孤独》添加章节内容
INSERT INTO `book_content` (`book_id`, `chapter_order`, `title`, `content`, `word_count`) VALUES
(8, 1, '第一章', '<p>多年以后，面对行刑队，奥雷里亚诺·布恩迪亚上校将会回想起，他父亲带他去见识冰块的那个遥远的下午。</p><p>那时，马孔多是一个二十户人家的村庄，坐落在加勒比海沿岸一个狭长的半岛上。</p><p>村庄四周是茂密的丛林和泥泞的沼泽地。吉卜赛人经常来这里，用他们神奇的发明换取村民们的食物和牲畜。</p><p>奥雷里亚诺的父亲，何塞·阿尔卡蒂奥·布恩迪亚，是村庄的创建者。他是个充满幻想的人，总是梦想着发现新大陆。</p>', 167),
(8, 2, '第二章', '<p>吉卜赛人梅尔加德斯的到来，改变了马孔多的命运。</p><p>梅尔加德斯带来了许多神奇的东西：放大镜、望远镜、磁铁，还有一顶帐篷，里面陈列着他的发明。</p><p>最神奇的是，他带来了冰块。那是村民们第一次见到冰块，他们用手触摸着这个来自另一个世界的奇迹。</p><p>"这是科学的力量，"梅尔加德斯说，"它能改变世界。"</p><p>从那天起，马孔多开始了它的传奇历程。</p>', 142);

-- 为《红楼梦》添加章节内容
INSERT INTO `book_content` (`book_id`, `chapter_order`, `title`, `content`, `word_count`) VALUES
(1, 1, '第一回 甄士隐梦幻识通灵 贾雨村风尘怀闺秀', '<p>此开卷第一回也。作者自云：曾历过一番梦幻之后，故将真事隐去，而借"通灵"之说，撰此《石头记》一书也。故曰"甄士隐"云云。</p><p>按那石上书云：当日地陷东南，这东南一隅有处曰姑苏，有城曰阊门者，最是红尘中一二等富贵风流之地。</p><p>此情不关风和雨，奈何天涯海角人犹在。空对着，山中高士晶莹雪；终不忘，世外仙姝寂寞林。</p><p>接连着，空空道人访道求仙，从这大荒山无稽崖青埂峰下经过，忽见一块大石，上面字迹分明。</p>', 189),
(1, 2, '第二回 贾夫人仙逝扬州城 冷子兴演说荣国府', '<p>诗云：一局输赢料不真，香消玉殒总伤情。欲知目下兴衰兆，须问旁观冷眼人。</p><p>却说封肃因听见公差传唤，忙出来陪笑启问。那些人只嚷："快请出甄爷来!"</p><p>封肃忙陪笑道："小人姓封，并不姓甄。只有当日小婿姓甄，今已出家一二年了，不知可是问他。"</p><p>那些公人道："我们也不知什么\'真\' \'假\'，既是恁说，我们只认得本地方人。还烦老丈领我们到那庙里去问就是了。"</p>', 156);

-- 为《西游记》添加章节内容
INSERT INTO `book_content` (`book_id`, `chapter_order`, `title`, `content`, `word_count`) VALUES
(2, 1, '第一回 灵根育孕源流出 心性修持大道生', '<p>诗曰：混沌未分天地乱，茫茫渺渺无人见。自从盘古破鸿蒙，开辟从兹清浊辨。</p><p>覆载群生仰至仁，发明万物皆成善。欲知造化会元功，须看西游释厄传。</p><p>盖闻天地之数，有十二万九千六百年为一元。将一元分为十二会，乃子、丑、寅、卯、辰、巳、午、未、申、酉、戌、亥之十二支也。每会该一万八百岁。</p><p>且不言他国外国，只说中国，自盘古开天辟地以后，天不满西北，地不满东南。</p>', 178),
(2, 2, '第二回 悟彻菩提真妙理 断魔归本合元神', '<p>话说那猴王得了老君的宝贝，回到花果山，众猴前来迎接。猴王道："小的们，我去了一向，如何？</p><p>众猴道："大王去了一向，想是有些手段，得了宝贝。"</p><p>猴王笑道："我今番去，得了三件宝贝，乃是金刚琢、西瓜铁、芭蕉扇。"</p><p>众猴听了，一个个欢喜跳跃。猴王道："我今要立一杆旗，名为\'齐天大圣\'，你们都要听我号令。"</p><p>众猴道："愿听大王号令。"</p>', 145);

-- ============================================
-- 插入测试作品数据 (作者中心作品)
-- ============================================
INSERT INTO works (title, cover, category, description, author_id, author_name, status, word_count, view_count, like_count, collect_count)
VALUES
('诡秘之主', '/images/books/1.jpg', '玄幻', '蒸汽与机械的浪潮中，谁能触及非凡？', 1, '爱潜水的乌贼', 2, 4563200, 128956, 8562, 3265),
('凡人修仙传', '/images/books/2.jpg', '仙侠', '一个普通山村少年，偶然进入当地江湖小门派...', 2, '忘语', 2, 5823000, 95632, 7421, 2896),
('择天记', '/images/books/3.jpg', '玄幻', '太始元年，有神石自天降，分散落于世界各处...', 3, '猫腻', 2, 3956000, 76521, 5896, 2156);

-- 更新用户为作者身份
UPDATE user SET is_author = 1 WHERE id IN (1, 2, 3);

-- ============================================
-- 初始化完成提示
-- ============================================
SELECT '数据库初始化完成！共创建了所有表结构和测试数据。' AS message;