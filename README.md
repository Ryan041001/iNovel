# iNovel - 统一在线阅读平台 📚

> 现代化的在线阅读平台，融合作品创作、阅读体验、数据分析于一体

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.6-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Vue.js](https://img.shields.io/badge/Vue.js-3.5.21-4FC08D.svg)](https://vuejs.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 📖 目录

- [项目简介](#-项目简介)
- [核心功能](#-核心功能)
- [技术栈](#-技术栈)
- [项目演进：重构、增量与迭代](#项目演进重构增量与迭代)
- [快速开始](#-快速开始)
- [项目结构](#-项目结构)
- [API 文档](#-api-文档)
- [部署指南](#-部署指南)
- [后续优化计划](#-后续优化计划)

---

## 📖 项目简介

`iNovel` 是一个功能完整的在线阅读平台，由原 `iNovel` (基于 Thymeleaf) 和 `iReader` (基于 Vue3) 两个项目合并而成。项目采用现代化的前后端分离架构，以 `iReader` 的技术栈为主体，整合了两个项目的核心功能，旨在提供一个功能丰富、体验流畅的在线阅读解决方案。

### 项目特色 ✨

- 🎨 **统一 UI 风格**: 采用简洁清爽的白色主题，确保所有页面风格一致
- � **前后端分离**: 前端 Vue3 + 后端 Spring Boot，职责清晰
- 📱 **响应式设计**: 完美适配桌面端和移动端
- 🔐 **JWT 认证**: 无状态认证，安全高效
- 📊 **数据可视化**: 作者数据统计、阅读趋势图表
- 🌙 **夜间模式**: 保护视力，提升阅读体验

---

## 🎯 核心功能

### 读者功能

- 📚 **书城系统**: 浏览、搜索、分类查询海量书籍
- 📖 **在线阅读**: 支持 `TXT`、`EPUB`、`PDF` 三种格式在线解析
- 🗂️ **个人书架**: 收藏喜爱的书籍，同步阅读进度
- 📝 **阅读笔记**: 支持高亮、书签、文字笔记
- ⭐ **收藏互动**: 点赞、收藏、评论作品
- 📊 **阅读历史**: 记录阅读轨迹，快速继续阅读
- 🌙 **个性化设置**: 夜间模式、字体大小、背景色调整

### 作者功能

- ✍️ **作品管理**: 创建、编辑、发布作品
- 📑 **章节管理**: 灵活的章节编辑和发布
- 📊 **数据统计**: 实时查看作品浏览、点赞、收藏数据
- 📈 **趋势分析**: 可视化图表展示阅读趋势
- 💬 **读者互动**: 查看读者评论，了解读者反馈
- 👥 **粉丝管理**: 查看粉丝数量和互动

### 管理功能

- 👤 **用户系统**: 手机号注册/登录，JWT 无状态认证
- 🔒 **权限控制**: 基于角色的访问控制
- 📊 **统计报表**: 多维度数据统计分析

---

## 🛠️ 技术栈

### 后端技术

| 技术        | 版本   | 说明                |
| :---------- | :----- | :------------------ |
| Spring Boot | 3.5.6  | 企业级应用开发框架  |
| MyBatis     | 3.0.5  | 持久层框架          |
| Java        | 17     | 编程语言            |
| MySQL       | 8.0    | 关系型数据库        |
| JWT (jjwt)  | 0.11.5 | JSON Web Token 认证 |
| Lombok      | -      | 简化 Java 代码      |
| epublib     | -      | EPUB 格式解析       |
| PDFBox      | -      | PDF 格式解析        |
| Jsoup       | -      | HTML 解析           |

### 前端技术

| 技术         | 版本   | 说明                   |
| :----------- | :----- | :--------------------- |
| Vue.js       | 3.5.21 | 渐进式 JavaScript 框架 |
| Vue Router   | 4.x    | 官方路由管理器         |
| Element Plus | 2.11.4 | Vue 3 UI 组件库        |
| Vite         | 7.1.7  | 下一代前端构建工具     |
| Axios        | 1.12.2 | HTTP 客户端            |
| Tailwind CSS | -      | 实用优先的 CSS 框架    |

---

## 🚀 快速开始

### 1. 环境准备

确保已安装以下软件：

- ☕ **JDK 17+**
- 📦 **Maven 3.6+**
- 🟢 **Node.js 16+**
- 🐬 **MySQL 8.0+**

### 2. 克隆项目

```bash
git clone https://github.com/your-username/iNovel.git
cd iNovel
```

### 3. 初始化数据库

执行数据库脚本创建表结构：

```bash
# 登录 MySQL
mysql -u root -p

# 创建数据库
CREATE DATABASE inovel DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 执行基础表结构脚本
USE inovel;
SOURCE database/schema.sql;

# 执行作品模块表结构脚本
SOURCE merged-backend/src/main/resources/schema-works.sql;
```

### 4. 配置后端

编辑 `merged-backend/src/main/resources/application.yml`：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/inovel?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
    username: root
    password: 你的MySQL密码 # 修改此处
```

### 5. 启动后端

```bash
cd merged-backend
mvn clean package
mvn spring-boot:run

# 或使用 IDE 直接运行 INovelApplication.java
```

后端将在 `http://localhost:8080` 启动

### 6. 启动前端

```bash
cd merged-frontend
npm install
npm run dev
```

前端将在 `http://localhost:5173` 启动

### 7. 访问应用

浏览器访问: `http://localhost:5173`

---

## 🔌 API 文档

### 作品管理 API

| 方法   | 路径                            | 说明               |
| ------ | ------------------------------- | ------------------ |
| GET    | `/api/work/{id}`                | 获取作品详情       |
| GET    | `/api/work/author/{authorId}`   | 获取作者的所有作品 |
| GET    | `/api/work/list`                | 获取作品列表       |
| GET    | `/api/work/category/{category}` | 按分类查询作品     |
| GET    | `/api/work/search`              | 搜索作品           |
| POST   | `/api/work`                     | 创建作品           |
| PUT    | `/api/work/{id}`                | 更新作品           |
| DELETE | `/api/work/{id}`                | 删除作品           |
| POST   | `/api/work/{id}/view`           | 增加浏览量         |
| POST   | `/api/work/{id}/like`           | 点赞作品           |
| POST   | `/api/work/{id}/collect`        | 收藏作品           |

### 章节管理 API

| 方法   | 路径                                              | 说明               |
| ------ | ------------------------------------------------- | ------------------ |
| GET    | `/api/chapter/work/{workId}`                      | 获取作品的所有章节 |
| GET    | `/api/chapter/work/{workId}/chapter/{chapterNum}` | 获取指定章节       |
| POST   | `/api/chapter`                                    | 创建章节           |
| PUT    | `/api/chapter/{id}`                               | 更新章节           |
| DELETE | `/api/chapter/{id}`                               | 删除章节           |
| POST   | `/api/chapter/{id}/view`                          | 增加章节浏览量     |

### 作者统计 API

| 方法 | 路径                           | 说明             |
| ---- | ------------------------------ | ---------------- |
| GET  | `/api/author/{authorId}/stats` | 获取作者统计数据 |

### 用户相关 API

| 方法 | 路径                 | 说明         |
| ---- | -------------------- | ------------ |
| POST | `/api/user/register` | 用户注册     |
| POST | `/api/user/login`    | 用户登录     |
| GET  | `/api/user/info`     | 获取用户信息 |

### 书籍相关 API

| 方法 | 路径                      | 说明         |
| ---- | ------------------------- | ------------ |
| GET  | `/api/book/list`          | 获取书籍列表 |
| GET  | `/api/book/{id}`          | 获取书籍详情 |
| POST | `/api/book/upload`        | 上传书籍     |
| GET  | `/api/book/{id}/chapters` | 获取书籍章节 |

---

## 🎨 前端页面导航

### 页面路由表

| 路由             | 组件              | 说明      | 权限   |
| ---------------- | ----------------- | --------- | ------ |
| `/`              | Home.vue          | 首页/书城 | 公开   |
| `/login`         | LoginRegister.vue | 登录注册  | 公开   |
| `/bookshelf`     | Bookshelf.vue     | 我的书架  | 需登录 |
| `/reader/:id`    | Reader.vue        | 阅读器    | 需登录 |
| `/user-center`   | UserCenter.vue    | 个人中心  | 需登录 |
| `/author-center` | AuthorCenter.vue  | 作者中心  | 需登录 |

### 页面间导航关系

```
首页 (Home)
  ├─→ 我的书架 (顶部链接)
  ├─→ 作者中心 (顶部链接)
  ├─→ 个人中心 (头像菜单)
  └─→ 阅读器 (点击书籍)

我的书架 (Bookshelf)
  ├─→ 首页 (顶部按钮)
  ├─→ 作者中心 (顶部按钮 + 头像菜单)
  ├─→ 个人中心 (头像菜单)
  └─→ 阅读器 (点击书籍)

阅读器 (Reader)
  ├─→ 首页 (顶部链接)
  ├─→ 我的书架 (顶部链接 + 头像菜单)
  ├─→ 作者中心 (顶部链接 + 头像菜单)
  └─→ 个人中心 (头像菜单)

个人中心 (UserCenter)
  ├─→ 首页 (顶部导航)
  ├─→ 我的书架 (顶部导航)
  ├─→ 作者中心 (顶部导航)
  └─→ 阅读器 (点击书籍)

作者中心 (AuthorCenter)
  ├─→ 首页 (顶部导航)
  ├─→ 我的书架 (顶部导航)
  └─→ 个人中心 (顶部导航)
```

### UI 风格统一说明

所有页面均采用统一的设计风格：

- **配色方案**: 简洁白色主题，蓝色 (#1a73e8) 为主色调
- **导航栏**: 统一的顶部导航 + 头像下拉菜单
- **卡片设计**: 圆角、阴影、悬停效果
- **按钮样式**: 主按钮蓝色，次按钮灰色，统一圆角
- **空状态**: emoji 图标 + 提示文字 + 操作按钮
- **响应式**: 完美适配桌面端和移动端

---

## 模块 API 详情

所有接口的基础路径为 `/api`。

### 用户模块 (`/user`)

| 方法   | 路径        | 描述                      |
| :----- | :---------- | :------------------------ |
| `POST` | `/register` | 用户注册                  |
| `POST` | `/login`    | 用户登录，返回 JWT        |
| `GET`  | `/info`     | 获取当前用户信息 (需认证) |

### 书籍模块 (`/book`)

| 方法  | 路径                                | 描述                            |
| :---- | :---------------------------------- | :------------------------------ |
| `GET` | `/list`                             | 获取书籍列表 (支持关键词、分类) |
| `GET` | `/detail/{id}`                      | 获取书籍详情                    |
| `GET` | `/content/{bookId}`                 | 获取书籍的章节列表              |
| `GET` | `/content/{bookId}/chapter/{order}` | 获取指定章节内容                |

### 书架模块 (`/bookshelf`)

| 方法     | 路径              | 描述                      |
| :------- | :---------------- | :------------------------ |
| `GET`    | `/list`           | 获取用户书架列表 (需认证) |
| `POST`   | `/add`            | 添加书籍到书架 (需认证)   |
| `DELETE` | `/remove`         | 从书架移除书籍 (需认证)   |
| `POST`   | `/uploadAndParse` | 上传并解析书籍 (需认证)   |

### 笔记模块 (`/annotations`)

| 方法     | 路径             | 描述                          |
| :------- | :--------------- | :---------------------------- |
| `POST`   | `/add`           | 添加笔记/高亮/书签 (需认证)   |
| `GET`    | `/book/{bookId}` | 获取某本书的所有笔记 (需认证) |
| `DELETE` | `/{id}`          | 删除指定笔记 (需认证)         |

---

---

## � 项目结构

```
iNovel/
├── 📄 README.md                         # 📚 项目总文档 (本文件)
│
├── 💾 database/                         # 数据库脚本
│   └── schema.sql                       # 基础表结构
│
├── 🏗️ merged-backend/                  # 后端 (Spring Boot)
│   ├── pom.xml                         # Maven 依赖配置
│   ├── src/main/
│   │   ├── java/com/inovel/
│   │   │   ├── 📁 controller/          # 控制器层
│   │   │   │   ├── UserController.java
│   │   │   │   ├── BookController.java
│   │   │   │   ├── WorkController.java        # 作品管理
│   │   │   │   ├── ChapterController.java     # 章节管理
│   │   │   │   └── AuthorController.java      # 作者统计
│   │   │   ├── 📁 service/             # 业务逻辑层
│   │   │   │   ├── impl/
│   │   │   │   ├── UserService.java
│   │   │   │   ├── WorkService.java
│   │   │   │   ├── ChapterService.java
│   │   │   │   └── AuthorStatsService.java
│   │   │   ├── 📁 mapper/              # 数据访问层
│   │   │   │   ├── UserMapper.java
│   │   │   │   ├── BookMapper.java
│   │   │   │   ├── WorkMapper.java
│   │   │   │   ├── ChapterMapper.java
│   │   │   │   └── AuthorStatsMapper.java
│   │   │   ├── 📁 entity/              # 实体类
│   │   │   │   ├── User.java
│   │   │   │   ├── Book.java
│   │   │   │   ├── Work.java                  # 作品实体
│   │   │   │   ├── Chapter.java              # 章节实体
│   │   │   │   └── AuthorStats.java          # 统计实体
│   │   │   ├── 📁 config/              # 配置类
│   │   │   │   ├── CorsConfig.java
│   │   │   │   └── JwtConfig.java
│   │   │   └── 📁 utils/               # 工具类
│   │   │       ├── JwtUtil.java
│   │   │       ├── EpubParser.java
│   │   │       └── PdfParser.java
│   │   └── resources/
│   │       ├── application.yml         # 主配置文件
│   │       ├── schema-works.sql        # 作品模块表结构
│   │       └── mapper/                 # MyBatis XML
│   │           ├── UserMapper.xml
│   │           ├── WorkMapper.xml
│   │           ├── ChapterMapper.xml
│   │           └── AuthorStatsMapper.xml
│   └── uploads/                        # 书籍上传目录
│
├── 🎨 merged-frontend/                 # 前端 (Vue3)
│   ├── package.json                    # NPM 依赖配置
│   ├── vite.config.js                  # Vite 配置
│   └── src/
│       ├── App.vue                     # 根组件
│       ├── main.js                     # 应用入口
│       ├── 📁 views/                   # 页面组件
│       │   ├── Home.vue                # 首页/书城
│       │   ├── LoginRegister.vue       # 登录注册
│       │   ├── Bookshelf.vue           # 我的书架
│       │   ├── Reader.vue              # 阅读器
│       │   ├── UserCenter.vue          # 📌 个人中心 (新)
│       │   └── AuthorCenter.vue        # 📌 作者中心 (新)
│       ├── 📁 router/                  # 路由配置
│       │   └── index.js
│       ├── 📁 components/              # 公共组件
│       └── 📁 assets/                  # 静态资源
│
├── 📜 iNovel/                          # 原项目备份
└── 📜 iReader/                         # 原项目备份
```

---

## 🚀 部署指南

### 手动部署

#### 后端部署

```bash
cd merged-backend

# 方式1: 使用 Maven 直接运行
mvn clean package
mvn spring-boot:run

# 方式2: 打包成 JAR
mvn clean package -DskipTests
java -jar target/inovel-backend-1.0.0.jar

# 方式3: 使用 IDE (IDEA/Eclipse)
# 直接运行 INovelApplication.java 的 main 方法
```

#### 前端部署

```bash
cd merged-frontend

# 开发模式
npm install
npm run dev

# 生产构建
npm run build
# 构建产物在 dist/ 目录，可部署到 Nginx
```

---

## 💡 开发文档

### 后端开发规范

#### 三层架构

```
Controller → Service → Mapper → Database
```

- **Controller**: 接收 HTTP 请求，调用 Service，返回 Result
- **Service**: 业务逻辑处理，事务管理
- **Mapper**: 数据库操作，SQL 语句

#### 统一响应格式

```java
public class Result<T> {
    private int code;      // 状态码: 200成功, 其他失败
    private String message; // 提示信息
    private T data;        // 响应数据
}
```

#### API 命名规范

- GET `/api/resource` - 获取列表
- GET `/api/resource/{id}` - 获取详情
- POST `/api/resource` - 创建资源
- PUT `/api/resource/{id}` - 更新资源
- DELETE `/api/resource/{id}` - 删除资源

### 前端开发规范

#### 组件命名

- 页面组件: PascalCase (如 `UserCenter.vue`)
- 通用组件: PascalCase (如 `BookCard.vue`)
- 文件名与组件名保持一致

#### 样式规范

- 使用 `scoped` 限定样式作用域
- 统一配色: 主色 `#1a73e8`, 背景 `#fafafa`
- 统一圆角: `border-radius: 6px / 8px / 12px`
- 统一阴影: `box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08)`

#### 路由配置

```javascript
{
  path: '/user-center',
  component: UserCenter,
  meta: {
    requiresAuth: true  // 需要登录
  }
}
```

### 数据库设计规范

- 主键: `id BIGINT PRIMARY KEY AUTO_INCREMENT`
- 时间戳: `create_time`, `update_time` (DATETIME)
- 软删除: `is_deleted` (TINYINT, 0 否 1 是)
- 表名: 小写下划线分隔 (如 `user_work_collect`)
- 字段名: 小写下划线分隔 (如 `author_id`)

---

## 🎯 后续优化计划

### P1 - 高优先级

- [ ] 完善用户权限系统 (读者/作者/管理员)
- [ ] 实现书籍评论和评分功能
- [ ] 添加搜索历史和推荐算法
- [ ] 优化移动端体验
- [ ] 性能优化 (懒加载、分页)

### P2 - 中优先级

- [ ] 添加作品分类管理
- [ ] 实现付费章节功能
- [ ] 添加消息通知系统
- [ ] 完善数据统计图表
- [ ] 添加单元测试

### P3 - 低优先级

- [ ] 支持更多电子书格式 (MOBI, AZW3)
- [ ] 添加社交分享功能
- [ ] 实现阅读排行榜
- [ ] 添加主题切换功能
- [ ] 国际化支持

---

## 📜 项目合并历程

本项目是由 `iNovel` (基于 Thymeleaf) 和 `iReader` (基于 Vue3) 两个独立项目合并的成果。

### 合并策略

- **合并目标**: 统一技术栈,整合功能,构建一个现代化的全功能阅读平台
- **核心决策**:
  - 采用 `iReader` 的**前后端分离**架构
  - 后端统一使用 **Spring Boot + MyBatis**
  - 前端统一使用 **Vue3 + Element Plus**
  - 数据库重新设计,兼容两个项目的数据模型

### 📘 iNovel 项目整合说明

#### 整合内容

从原 `iNovel` 项目(基于 Spring Boot + Thymeleaf)成功整合以下模块到 `merged` 项目:

#### ✅ 已整合模块

1. **作品管理模块** (Works Module)

   - 作品创建、编辑、删除、发布
   - 作品分类、标签管理
   - 作品搜索与筛选
   - 作品封面上传

2. **章节管理模块** (Chapters Module)

   - 章节创建、编辑、删除
   - 章节排序、批量操作
   - 章节内容富文本编辑
   - 章节浏览统计

3. **作者中心模块** (Author Center)

   - 作者个人信息管理
   - 作品列表与管理
   - 数据统计看板
   - 读者互动管理

4. **数据统计模块** (Statistics)
   - 作品浏览量、点赞数、收藏数统计
   - 作者粉丝数量统计
   - 阅读趋势图表展示
   - 多维度数据分析

#### 后端文件清单 (26 个文件)

**实体层 (Entity) - 3 个**

- ✅ `Work.java` - 作品实体类
- ✅ `Chapter.java` - 章节实体类
- ✅ `AuthorStats.java` - 作者统计实体类

**数据访问层 (Mapper) - 6 个**

- ✅ `WorkMapper.java` + `WorkMapper.xml`
- ✅ `ChapterMapper.java` + `ChapterMapper.xml`
- ✅ `AuthorStatsMapper.java` + `AuthorStatsMapper.xml`

**业务逻辑层 (Service) - 6 个**

- ✅ `WorkService.java` + `WorkServiceImpl.java`
- ✅ `ChapterService.java` + `ChapterServiceImpl.java`
- ✅ `AuthorStatsService.java` + `AuthorStatsServiceImpl.java`

**控制器层 (Controller) - 4 个**

- ✅ `WorkController.java` - 11 个 API 端点
- ✅ `ChapterController.java` - 6 个 API 端点
- ✅ `AuthorController.java` - 作者统计 API
- ✅ `PageController.java` - 页面路由

**数据库 (Database) - 1 个**

- ✅ `schema-works.sql` - 5 张新表结构

#### 前端文件清单 (2 个文件)

- ✅ `AuthorCenter.vue` - 作者中心页面 (统一白色风格)
- ✅ `router/index.js` - 路由配置更新

#### 数据库表结构 (5 张表)

1. **works** - 作品表

   - 核心字段: id, title, cover, category, description, authorId, status, wordCount, viewCount, likeCount, collectCount
   - 索引: authorId, category, status

2. **chapters** - 章节表

   - 核心字段: id, workId, chapterNum, title, content, wordCount, viewCount
   - 索引: workId, chapterNum

3. **author_fans** - 作者粉丝关系表

   - 核心字段: id, authorId, fanUserId, createTime
   - 索引: authorId, fanUserId
   - 唯一约束: (authorId, fanUserId)

4. **user_work_collect** - 用户收藏作品表

   - 核心字段: id, userId, workId, createTime
   - 索引: userId, workId
   - 唯一约束: (userId, workId)

5. **user_work_like** - 用户点赞作品表
   - 核心字段: id, userId, workId, createTime
   - 索引: userId, workId
   - 唯一约束: (userId, workId)

#### 整合要点

1. **架构转换**: 将 Thymeleaf 模板引擎改为 RESTful API + Vue 前端
2. **认证机制**: 集成 JWT 认证,替换原 Session 认证
3. **数据模型**: 保留核心业务逻辑,重新设计表结构以适配新架构
4. **API 设计**: 遵循 RESTful 规范,统一响应格式
5. **前端适配**: 使用 Vue3 Composition API 重构,统一 UI 风格

---

### 📗 iReader 项目整合说明

#### 整合内容

从原 `iReader` 项目(基于 Vue3 + Spring Boot)成功整合以下模块到 `merged` 项目:

#### ✅ 已整合模块

1. **用户系统模块** (User System)

   - 用户注册与登录
   - JWT 认证与鉴权
   - 用户信息管理
   - 密码加密与验证

2. **书籍管理模块** (Book Management)

   - 书籍上传 (支持 TXT/EPUB/PDF)
   - 书籍解析与存储
   - 书籍列表与详情
   - 分类与搜索功能

3. **书架模块** (Bookshelf)

   - 个人书架管理
   - 阅读进度同步
   - 书籍添加与移除
   - 最近阅读记录

4. **阅读器模块** (Reader)

   - 在线阅读功能
   - 章节导航
   - 阅读进度记录
   - 个性化设置 (字体、背景)

5. **笔记模块** (Annotations)

   - 文字高亮
   - 阅读笔记
   - 书签管理
   - 笔记同步

6. **个人中心模块** (User Center)
   - 用户信息展示
   - 阅读统计
   - 收藏列表
   - 历史记录

#### 后端文件清单 (约 18 个文件)

**实体层 (Entity) - 5 个**

- ✅ `User.java` - 用户实体类
- ✅ `Book.java` - 书籍实体类
- ✅ `Bookshelf.java` - 书架实体类
- ✅ `Annotation.java` - 笔记实体类
- ✅ `ReadHistory.java` - 阅读历史实体类

**数据访问层 (Mapper) - 5 个**

- ✅ `UserMapper.java` + `UserMapper.xml`
- ✅ `BookMapper.java` + `BookMapper.xml`
- ✅ `BookshelfMapper.java` + `BookshelfMapper.xml`
- ✅ `AnnotationMapper.java` + `AnnotationMapper.xml`
- ✅ `ReadHistoryMapper.java` + `ReadHistoryMapper.xml`

**业务逻辑层 (Service) - 5 个**

- ✅ `UserService.java` + `UserServiceImpl.java`
- ✅ `BookService.java` + `BookServiceImpl.java`
- ✅ `BookshelfService.java` + `BookshelfServiceImpl.java`
- ✅ `AnnotationService.java` + `AnnotationServiceImpl.java`
- ✅ `ReadHistoryService.java` + `ReadHistoryServiceImpl.java`

**控制器层 (Controller) - 4 个**

- ✅ `UserController.java` - 用户注册/登录/信息查询
- ✅ `BookController.java` - 书籍上传/列表/详情/搜索
- ✅ `BookshelfController.java` - 书架管理
- ✅ `AnnotationController.java` - 笔记管理

**工具类 (Utils) - 3 个**

- ✅ `JwtUtil.java` - JWT 令牌工具
- ✅ `EpubParser.java` - EPUB 格式解析
- ✅ `PdfParser.java` - PDF 格式解析

**配置类 (Config) - 2 个**

- ✅ `CorsConfig.java` - 跨域配置
- ✅ `JwtConfig.java` - JWT 配置

#### 前端文件清单 (4 个文件)

- ✅ `Home.vue` - 首页/书城 (简洁白色风格)
- ✅ `Bookshelf.vue` - 我的书架 (统一风格)
- ✅ `Reader.vue` - 阅读器页面
- ✅ `UserCenter.vue` - 个人中心 (统一白色风格)

#### 数据库表结构 (5 张表)

1. **users** - 用户表

   - 核心字段: id, phone, password, nickname, avatar, createTime
   - 索引: phone (唯一)

2. **books** - 书籍表

   - 核心字段: id, title, author, cover, category, format, filePath, uploadTime
   - 索引: category, uploadTime

3. **user_shelf** - 用户书架表

   - 核心字段: id, userId, bookId, progress, lastReadTime, addTime
   - 索引: userId, bookId
   - 唯一约束: (userId, bookId)

4. **annotations** - 笔记表

   - 核心字段: id, userId, bookId, chapterNum, type, content, position, createTime
   - 索引: userId, bookId
   - type 枚举: highlight(高亮), note(笔记), bookmark(书签)

5. **read_history** - 阅读历史表
   - 核心字段: id, userId, bookId, chapterNum, progress, readTime
   - 索引: userId, bookId, readTime

#### 整合要点

1. **前端架构**: 采用 Vue3 + Composition API + Vue Router 4
2. **UI 框架**: 使用 Element Plus 组件库,统一设计规范
3. **认证体系**: JWT 无状态认证,请求拦截器自动携带 Token
4. **文件解析**: 集成 epublib、PDFBox 支持多格式电子书解析
5. **样式统一**: 所有页面采用简洁白色主题,蓝色 (#1a73e8) 主色调
6. **响应式设计**: 适配桌面端和移动端,提供流畅的阅读体验

---

### 整合工作流程

1. **规划与设计**

   - 制定详细的合并计划
   - 技术选型与架构设计
   - 数据库表结构设计
   - API 接口规范制定

2. **基础架构搭建**

   - 创建 `merged-backend` 项目骨架
   - 创建 `merged-frontend` 项目骨架
   - 配置开发环境与依赖
   - 建立代码规范

3. **后端整合**

   - 迁移 iReader 基础模块 (用户、书籍、书架)
   - 迁移 iNovel 作品模块 (作品、章节、统计)
   - 统一 Service 层业务逻辑
   - 规范 Controller 层 API 设计
   - 整合数据库表结构

4. **前端整合**

   - 迁移 iReader 核心页面 (首页、书架、阅读器)
   - 开发 iNovel 功能页面 (个人中心、作者中心)
   - 统一 UI 风格为简洁白色主题
   - 规范组件命名与目录结构
   - 配置路由与导航

5. **功能联调**

   - 前后端接口联调
   - 用户认证流程测试
   - 书籍上传与解析测试
   - 作品管理功能测试
   - 数据统计功能测试

6. **优化与完善**

   - 性能优化 (懒加载、分页)
   - UI/UX 优化
   - 错误处理与提示
   - 代码重构与规范
   - 单元测试补充

7. **文档整理**
   - 编写 API 文档
   - 编写部署文档
   - 编写开发文档
   - 整合所有文档到 README

---

### 项目演进：重构、增量与迭代

项目的演进遵循“先重构，再增量，后迭代”的清晰路径，确保了技术架构的现代化和功能的持续丰富。

1.  **重构 (Refactoring): 奠定现代化基石**

    - **核心动作**: 对原 `iNovel` 项目（基于 Thymeleaf）进行彻底的技术栈重构。
    - **目标**: 统一到以 `iReader` 为代表的**前后端分离**架构。
    - **成果**:
      - 后端从“模板引擎”模式迁移到“RESTful API”模式。
      - 前端从多页面应用重构为基于 Vue3 的单页面应用 (SPA)。
      - 这为后续的功能整合与扩展提供了灵活、高效的现代化技术基础。

2.  **增量 (Incremental): 实现核心功能“1+1>2”**

    - **核心动作**: 在重构后的新架构上，增量添加了来自两个项目的核心功能。
    - **新增功能**:
      - **一站式平台**: 融合了 `iReader` 的**读者系统**（书城、书架、在线阅读）和 `iNovel` 的**作者系统**（作品管理、数据统计），实现了完整的“读+写”闭环。
      - **多格式支持**: 新增了对 `TXT`、`EPUB`、`PDF` 格式书籍的**上传、解析和在线阅读**功能，这是对原单一功能项目的巨大扩充。

3.  **迭代 (Iterative): 优化体验与稳定性**
    - **核心动作**: 对已合并和新增的功能进行持续的优化和完善。
    - **迭代内容**:
      - **Bug 修复**: 解决了大量因数据模型不一致导致的 `SQLSyntaxErrorException`，确保了核心流程的稳定性。
      - **UI/UX 优化**: 统一了所有前端页面的 UI 风格，并对导航和交互进行了优化，提升了用户体验。
      - **开发流程完善**: 通过补充文档、建立 PR Checklist 等方式，规范了开发流程，提高了团队协作效率和代码质量。

通过“重构-增量-迭代”的演进模式，项目成功地从两个独立的传统应用，转变为一个功能强大、技术现代、体验统一的综合性阅读平台。

---

<div align="center">

**⭐ 如果这个项目对你有帮助，请给个 Star ⭐**

**Happy Reading! 📚**

</div>
