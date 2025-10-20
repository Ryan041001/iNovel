# iNovel 书城图书添加指南

## 概述

本文档说明如何将 `merged-backend/src/main/resources/books` 文件夹中的图书文件添加到 iNovel 书城系统。

## 系统架构概览

iNovel 系统包含以下核心表：

- **user**：用户表
- **book**：书籍表（存储书籍的元数据）
- **book_content**：章节内容表（存储每章的内容）
- **user_shelf**：用户书架表（记录用户的阅读进度）

## 方法一：使用数据库脚本添加（推荐）

### 步骤 1：准备脚本

在 `database/` 文件夹中有两个重要的脚本：

- `init_database.sql`：初始化数据库结构
- `add_books.sql`：批量添加书籍（新创建）

### 步骤 2：执行初始化脚本（如果数据库尚未初始化）

```bash
mysql -h localhost -u root -p < database/init_database.sql
```

### 步骤 3：执行添加书籍脚本

```bash
mysql -h localhost -u root -p inovel < database/add_books.sql
```

**脚本的作用**：

- 创建管理员用户（ID=1）
- 将 `books` 文件夹中的 12 本书籍信息添加到 `book` 表
- 验证添加结果

## 方法二：编程方式添加（基于 Spring Boot API）

### 步骤 1：启动后端服务

```bash
cd merged-backend
mvn spring-boot:run
# 或
./mvnw spring-boot:run
```

### 步骤 2：使用 API 添加书籍

虽然当前 `BookController` 中没有添加图书的 API 端点，但可以添加以下端点：

```java
@PostMapping("/add")
public Response addBook(@RequestBody Book book) {
    bookService.addBook(book);
    return new Response(200, "书籍添加成功", book);
}
```

### 步骤 3：发送 POST 请求

```bash
curl -X POST http://localhost:8080/api/book/add \
  -H "Content-Type: application/json" \
  -d '{
    "title": "完美世界",
    "author": "辰东",
    "category": "网络文学",
    "description": "宏大的诸天万界设定",
    "filePath": "/resources/books/辰东-完美世界.txt",
    "fileType": "txt",
    "uploadUserId": 1,
    "status": 1,
    "visibility": "public"
  }'
```

## 方法三：手动向数据库插入数据

### 语法示例

```sql
USE inovel;

-- 先确保有一个上传者用户（如果没有，先创建）
INSERT INTO user (phone, password, nickname, status)
VALUES ('10000000000', '$2a$10$...加密密码...', '管理员', 1);

-- 添加一本书籍
INSERT INTO book (title, author, category, description, file_path, file_type, upload_user_id, status, visibility)
VALUES (
  '完美世界',
  '辰东',
  '网络文学',
  '宏大的诸天万界设定',
  '/resources/books/辰东-完美世界.txt',
  'txt',
  1,
  1,
  'public'
);
```

### book 表字段说明

| 字段           | 类型         | 说明                                    |
| -------------- | ------------ | --------------------------------------- |
| id             | BIGINT       | 书籍 ID（自增）                         |
| title          | VARCHAR(255) | 书名                                    |
| author         | VARCHAR(100) | 作者名                                  |
| cover          | VARCHAR(500) | 封面图 URL                              |
| category       | VARCHAR(50)  | 分类（如：网络文学、古典）              |
| description    | TEXT         | 书籍简介                                |
| file_path      | VARCHAR(500) | 文件路径（相对于 classpath 或文件系统） |
| file_type      | VARCHAR(20)  | 文件类型（txt/epub/pdf）                |
| visibility     | VARCHAR(20)  | 可见性（public/private/pending）        |
| upload_user_id | BIGINT       | 上传者用户 ID                           |
| status         | TINYINT      | 状态（1-正常，0-下架）                  |
| views          | BIGINT       | 浏览次数                                |
| create_time    | DATETIME     | 创建时间                                |
| update_time    | DATETIME     | 更新时间                                |

## 当前书籍列表

已通过 `add_books.sql` 添加的书籍：

| 序号 | 书名                    | 作者       | 文件类型 | 文件名                                    |
| ---- | ----------------------- | ---------- | -------- | ----------------------------------------- |
| 1    | 圣墟（校对版全本+番外） | 辰东       | txt      | 《圣墟》（校对版全本+番外）.txt           |
| 2    | 择天记                  | 猫腻       | txt      | 《择天记》作者：猫腻.txt                  |
| 3    | 诡秘之主                | 狐尾的笔   | txt      | 《诡秘之主》精校版全本.txt                |
| 4    | 雪中悍刀行              | 烽火戏诸侯 | epub     | 《雪中悍刀行》完结版大全集[全 20 册].epub |
| 5    | 元尊                    | 天蚕土豆   | epub     | 元尊.epub                                 |
| 6    | 元尊（文本版）          | 天蚕土豆   | txt      | 元尊.txt                                  |
| 7    | 剑来                    | 狐尾的笔   | txt      | 剑来.txt                                  |
| 8    | 大奉打更人              | 卖报小郎君 | txt      | 大奉打更人 by 卖报小郎君.txt              |
| 9    | 斗破苍穹                | 天蚕土豆   | txt      | 斗破苍穹\_.txt                            |
| 10   | 牧神记                  | 狐尾的笔   | txt      | 牧神记.txt                                |
| 11   | 完美世界                | 辰东       | txt      | 辰东-完美世界.txt                         |
| 12   | 遮天                    | 辰东       | txt      | 遮天.txt                                  |

## 验证添加结果

### 使用 SQL 查询验证

```sql
USE inovel;
SELECT id, title, author, category, file_type, status FROM book ORDER BY create_time DESC;

-- 统计总数
SELECT COUNT(*) as '书籍总数' FROM book;

-- 按分类统计
SELECT category, COUNT(*) as '数量' FROM book GROUP BY category;
```

### 使用前端验证

1. 启动前端应用（`merged-frontend`）
2. 访问书城首页
3. 查看书籍列表是否正常显示

### 使用 API 验证

```bash
curl http://localhost:8080/api/book/list
```

## 后续操作：添加章节内容

当前 `add_books.sql` 仅添加了书籍的元数据（标题、作者等），并未添加章节内容。

### 方法 1：使用文件解析器（自动）

系统有 `TxtParser` 和 `EpubParser` 工具类，当用户访问书籍时会自动解析文件并将章节内容保存到 `book_content` 表。

### 方法 2：手动创建初始化脚本

可以创建脚本逐个解析文件并插入章节数据：

```java
// 在后端启动时执行
@Component
public class BookInitializer implements ApplicationRunner {
    @Autowired
    private BookContentService bookContentService;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        // 初始化所有书籍的章节内容
        // 扫描 books 文件夹，解析文件，保存章节到数据库
    }
}
```

## 常见问题

### Q1: 文件路径应该怎么写？

A: `file_path` 字段应该是相对于项目资源目录或上传目录的路径。根据 `application.yml` 的配置，资源文件在 `classpath:/static/` 或 `file:uploads/` 下。本例中使用 `/resources/books/` 前缀。

### Q2: 如何修改已添加的书籍信息？

A: 使用 UPDATE 语句：

```sql
UPDATE book SET description = '新的简介' WHERE id = 1;
```

### Q3: 如何删除书籍？

A: 使用 DELETE 语句：

```sql
DELETE FROM book WHERE id = 1;
```

注意：如果有相关的章节内容和用户书架记录，会因外键约束自动级联删除。

### Q4: 我是否需要预先处理文件？

A: 不需要。系统会在用户首次访问书籍时自动解析 txt、epub 或 pdf 文件，提取章节内容并存储到数据库。

## 总结

将书籍添加到 iNovel 系统的推荐流程：

1. **初始化数据库**：执行 `init_database.sql`
2. **添加书籍元数据**：执行 `add_books.sql` 或手动插入数据
3. **启动后端服务**：运行 Spring Boot 应用
4. **验证结果**：访问 API 或前端页面

系统会在用户访问书籍时自动解析文件内容并保存到数据库。
