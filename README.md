# iNovel - 统一在线阅读平台

## 📖 项目简介

`iNovel` 是一个功能完整的在线阅读平台，由原 `iNovel` (基于 Thymeleaf) 和 `iReader` (基于 Vue3) 两个项目合并而成。项目采用现代化的前后端分离架构，以 `iReader` 的技术栈为主体，整合了两个项目的核心功能，旨在提供一个功能丰富、体验流畅的在线阅读解决方案。

### 主要功能

- 📚 **书城系统**: 浏览、搜索、分类查询书籍。
- 👤 **用户系统**: 支持手机号注册、登录，并采用 JWT 进行无状态认证。
- 📖 **在线阅读**: 支持 `TXT`、`EPUB`、`PDF` 三种主流电子书格式的在线解析和阅读。
- 🗂️ **个人书架**: 用户可以收藏喜爱的书籍，并同步阅读进度。
- 📝 **阅读笔记**: 支持在阅读时添加高亮、书签和文字笔记，方便回顾和管理。
- 🌙 **个性化设置**: 提供夜间模式、字体大小调整等功能。

### 技术栈

| 分类       | 技术                   | 版本   |
| :--------- | :--------------------- | :----- |
| **后端**   | Spring Boot            | 3.5.6  |
|            | MyBatis                | 3.0.5  |
|            | Java                   | 17     |
|            | MySQL                  | 8.0    |
|            | JWT (jjwt)             | 0.11.5 |
| **前端**   | Vue                    | 3.5.21 |
|            | Element Plus           | 2.11.4 |
|            | Vite                   | 7.1.7  |
|            | Axios                  | 1.12.2 |
| **核心库** | epublib, PDFBox, Jsoup | -      |

---

## 🚀 快速开始

### 1. 环境准备

- JDK 17+
- Maven 3.6+
- Node.js 16+
- MySQL 8.0+

### 2. 初始化数据库

使用 MySQL 命令行或 Navicat 等工具执行 `database/schema.sql` 文件，以创建数据库 `inovel` 及所有表结构和初始数据。

```bash
# 登录 MySQL
mysql -u root -p

# 执行脚本
source d:/A_ZJGSU/CODE/school/SoftwareEngineering/iNovel/database/schema.sql;
```

_请将脚本路径替换为你的实际路径。_

### 3. 修改配置

编辑后端配置文件 `merged-backend/src/main/resources/application.yml`，修改数据库连接信息。

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/inovel?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8
    username: root
    password: 你的密码 # <--- 修改为你的MySQL密码
```

### 4. 启动项目

```bash
# 终端 1: 启动后端
cd merged-backend
mvn spring-boot:run

# 终端 2: 启动前端
cd merged-frontend
npm install
npm run dev
```

### 5. 访问应用

- **前端访问地址**: `http://localhost:5173`
- **后端 API 地址**: `http://localhost:8080`

---

## 📁 项目结构

```
iNovel/
│
├── 📄 README_consolidated.md            # 本文档
│
├── 💾 database/                          # 数据库脚本
│   └── schema.sql                        # 完整的表结构和数据
│
├── 🏗️ merged-backend/                   # 统一后端项目 (Spring Boot)
│   ├── pom.xml                          # Maven配置
│   ├── src/main/
│   │   ├── java/com/inovel/
│   │   │   ├── controller/              # 控制器层 (API入口)
│   │   │   ├── service/                 # 业务逻辑层
│   │   │   ├── mapper/                  # 数据访问层 (MyBatis)
│   │   │   ├── entity/                  # 实体类
│   │   │   ├── config/                  # 配置类 (CORS, JWT)
│   │   │   └── utils/                   # 工具类 (文件解析, JWT)
│   │   └── resources/
│   │       ├── application.yml          # 核心配置文件
│   │       └── mapper/                  # MyBatis XML
│   └── uploads/                         # 用户上传的书籍目录
│
├── 🎨 merged-frontend/                  # 统一前端项目 (Vue3)
│   ├── package.json                     # NPM配置
│   ├── vite.config.js                   # Vite配置
│   └── src/
│       ├── views/                       # 页面组件
│       ├── router/                      # 路由配置
│       ├── components/                  # 通用组件
│       └── main.js                      # 应用入口
│
├── 📜 iNovel/ (原项目备份)
└── 📜 iReader/ (原项目备份)
```

---

## � 功能来源

本项目由原 `iNovel` (基于 Thymeleaf) 和 `iReader` (基于 Vue3) 两个项目合并而成，以 `iReader` 的技术栈为主体，整合了两个项目的核心功能。具体来源如下：

- **书城系统**: 主要基于原 `iNovel` 项目，整合了书籍浏览、搜索和分类功能。
- **用户系统**: 基于原 `iReader` 项目，使用 JWT 进行无状态认证。
- **在线阅读**: 基于原 `iReader` 项目，支持 TXT、EPUB、PDF 三种格式的解析和阅读。
- **个人书架**: 基于原 `iReader` 项目，支持收藏书籍和同步阅读进度。
- **阅读笔记**: 基于原 `iReader` 项目，支持高亮、书签和文字笔记。
- **个性化设置**: 基于原 `iReader` 项目，包括夜间模式和字体调整。
- **技术栈**: 以 `iReader` 的前后端分离架构为主体，后端使用 Spring Boot + MyBatis，前端使用 Vue3 + Element Plus。
- **数据库**: 重新设计，整合了两个项目的数据模型。

---

## �🔌 API 接口速查

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

## 🛠️ 开发与部署

### 后端开发

- **添加新接口**: 在 `controller` -> `service` -> `mapper` 层次结构中添加代码。
- **运行测试**: `mvn test`
- **打包**: `mvn clean package`

### 前端开发

- **开发模式**: `npm run dev`
- **生产构建**: `npm run build` (生成 `dist` 目录)

### 生产部署

1.  **部署后端**:
    ```bash
    java -jar merged-backend/target/inovel-backend-1.0.0.jar
    ```
2.  **部署前端**: 将 `merged-frontend/dist` 目录下的静态文件部署到 Nginx 或其他 Web 服务器。

---

## 📜 项目合并历程

本项目是在我的协助下，将 `iNovel` 和 `iReader` 两个独立项目合并的成果。

- **合并目标**: 统一技术栈，整合功能，构建一个现代化的全功能阅读平台。
- **核心决策**:
  - 采用 `iReader` 的**前后端分离**架构。
  - 后端统一使用 **Spring Boot + MyBatis**。
  - 前端统一使用 **Vue3 + Element Plus**。
  - 数据库进行重新设计，以兼容并包两个项目的数据模型。
- **主要工作**:
  1.  **规划与设计**: 制定了详细的合并计划、技术选型和数据库 Schema。
  2.  **基础架构搭建**: 创建了 `merged-backend` 和 `merged-frontend` 的项目骨架，并配置了核心依赖。
  3.  **代码迁移与整合**: 编写了自动化脚本，用于从 `iReader` 复制核心业务代码。
  4.  **编译与调试**: 解决了迁移过程中遇到的类名不匹配、实体字段缺失等多轮编译错误。
  5.  **文档整合**: 将所有过程文档、修复说明和项目介绍合并成本文档。


---

**Happy Reading! 📚**
