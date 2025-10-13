<template>
  <div class="user-center">
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="nav-left">
        <router-link to="/" class="nav-item">首页</router-link>
        <router-link to="/bookshelf" class="nav-item">我的书架</router-link>
        <router-link to="/author-center" class="nav-item">作者中心</router-link>
        <router-link to="/user-center" class="nav-item active"
          >个人中心</router-link
        >
      </div>
      <div class="nav-right">
        <!-- 头像 -->
        <img
          :src="
            userInfo.avatar ||
            'https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg'
          "
          alt="avatar"
          class="avatar"
          @click="toggleMenu"
        />
        <!-- 下拉菜单 -->
        <div v-if="menuVisible" class="dropdown-menu">
          <div class="menu-item" @click="goToUserCenter">个人中心</div>
          <div class="menu-item" @click="goToShelf">我的书架</div>
          <div class="menu-item" @click="goToAuthorCenter">作者中心</div>
          <div class="menu-item menu-divider"></div>
          <div class="menu-item" @click="logout">退出登录</div>
        </div>
      </div>
    </header>

    <!-- 主体内容 -->
    <div class="main-content">
      <!-- 用户信息卡片 -->
      <div class="user-info-card">
        <div class="user-info-header">
          <img
            :src="
              userInfo.avatar ||
              'https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg'
            "
            alt="用户头像"
            class="user-avatar"
          />
          <div class="user-info-details">
            <h2 class="user-nickname">{{ userInfo.nickname || "读者" }}</h2>
            <p class="user-phone">📱 {{ userInfo.phone }}</p>
            <p class="user-email" v-if="userInfo.email">
              📧 {{ userInfo.email }}
            </p>
          </div>
          <button class="edit-btn" @click="showEditProfile = true">
            ✏️ 编辑资料
          </button>
        </div>

        <!-- 统计数据 -->
        <div class="user-stats">
          <div class="stat-item">
            <div class="stat-value">{{ myBooks.length }}</div>
            <div class="stat-label">书架书籍</div>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <div class="stat-value">{{ myFavorites.length }}</div>
            <div class="stat-label">收藏作品</div>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <div class="stat-value">{{ readingHistory.length }}</div>
            <div class="stat-label">阅读历史</div>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <div class="stat-value">{{ myNotes.length }}</div>
            <div class="stat-label">笔记数量</div>
          </div>
        </div>
      </div>

      <!-- 标签页导航 -->
      <div class="tabs-container">
        <div class="tabs-nav">
          <button
            v-for="tab in tabs"
            :key="tab.id"
            @click="activeTab = tab.id"
            :class="['tab-btn', { active: activeTab === tab.id }]"
          >
            {{ tab.name }}
          </button>
        </div>

        <!-- 我的书架 -->
        <div v-show="activeTab === 'bookshelf'" class="tab-content">
          <div class="books-grid">
            <div
              v-for="book in myBooks"
              :key="book.id"
              class="book-card-item"
              @click="goToBook(book.id)"
            >
              <div class="book-cover-wrapper">
                <img
                  :src="book.cover"
                  :alt="book.title"
                  class="book-cover-img"
                />
                <div class="reading-progress">阅读至 {{ book.progress }}%</div>
              </div>
              <h3 class="book-title-text">{{ book.title }}</h3>
              <p class="book-author-text">{{ book.author }}</p>
            </div>
          </div>
          <div v-if="myBooks.length === 0" class="empty-state">
            <div class="empty-icon">📚</div>
            <p class="empty-text">书架空空如也，快去添加书籍吧~</p>
            <button class="goto-btn" @click="$router.push('/')">
              去首页逛逛
            </button>
          </div>
        </div>

        <!-- 我的收藏 -->
        <div v-show="activeTab === 'favorites'" class="tab-content">
          <div class="favorites-list">
            <div
              v-for="work in myFavorites"
              :key="work.id"
              class="favorite-card"
              @click="goToWork(work.id)"
            >
              <img :src="work.cover" :alt="work.title" class="favorite-cover" />
              <div class="favorite-info">
                <h3 class="favorite-title">{{ work.title }}</h3>
                <p class="favorite-author">作者: {{ work.authorName }}</p>
                <div class="favorite-stats">
                  <span class="stat-badge">💚 {{ work.likeCount }}</span>
                  <span class="stat-badge">⭐ {{ work.collectCount }}</span>
                  <span class="stat-badge">👁 {{ work.viewCount }}</span>
                </div>
              </div>
              <button
                class="uncollect-btn"
                @click.stop="uncollectWork(work.id)"
              >
                取消收藏
              </button>
            </div>
          </div>
          <div v-if="myFavorites.length === 0" class="empty-state">
            <div class="empty-icon">⭐</div>
            <p class="empty-text">还没有收藏任何作品</p>
            <button class="goto-btn" @click="$router.push('/')">
              去发现好书
            </button>
          </div>
        </div>

        <!-- 阅读历史 -->
        <div v-show="activeTab === 'history'" class="tab-content">
          <div class="history-list">
            <div
              v-for="record in readingHistory"
              :key="record.id"
              class="history-item"
              @click="goToBook(record.bookId)"
            >
              <img
                :src="record.cover"
                :alt="record.title"
                class="history-cover"
              />
              <div class="history-info">
                <h4 class="history-title">{{ record.title }}</h4>
                <p class="history-chapter">阅读至: {{ record.lastChapter }}</p>
                <p class="history-time">🕒 {{ record.lastReadTime }}</p>
              </div>
              <button
                class="continue-btn"
                @click.stop="goToBook(record.bookId)"
              >
                继续阅读
              </button>
            </div>
          </div>
          <div v-if="readingHistory.length === 0" class="empty-state">
            <div class="empty-icon">📖</div>
            <p class="empty-text">暂无阅读历史</p>
            <button class="goto-btn" @click="$router.push('/')">
              开始阅读
            </button>
          </div>
        </div>

        <!-- 我的笔记 -->
        <div v-show="activeTab === 'notes'" class="tab-content">
          <div class="notes-list">
            <div v-for="note in myNotes" :key="note.id" class="note-card">
              <div class="note-header">
                <h4 class="note-book-title">
                  {{ note.bookTitle }} - {{ note.chapterTitle }}
                </h4>
                <span class="note-time">{{ note.createTime }}</span>
              </div>
              <p class="note-content">{{ note.content }}</p>
              <div class="note-actions">
                <button class="note-action-btn edit">✏️ 编辑</button>
                <button
                  class="note-action-btn delete"
                  @click="deleteNote(note.id)"
                >
                  🗑️ 删除
                </button>
              </div>
            </div>
          </div>
          <div v-if="myNotes.length === 0" class="empty-state">
            <div class="empty-icon">📝</div>
            <p class="empty-text">还没有任何笔记</p>
            <button class="goto-btn" @click="$router.push('/')">
              去阅读并记笔记
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- 编辑资料弹窗 -->
    <div
      v-if="showEditProfile"
      class="modal-overlay"
      @click.self="showEditProfile = false"
    >
      <div class="modal-content">
        <h3 class="modal-title">✏️ 编辑个人资料</h3>
        <form @submit.prevent="saveProfile" class="edit-form">
          <div class="form-group">
            <label class="form-label">昵称</label>
            <input
              v-model="editForm.nickname"
              type="text"
              class="form-input"
              placeholder="请输入昵称"
            />
          </div>
          <div class="form-group">
            <label class="form-label">邮箱</label>
            <input
              v-model="editForm.email"
              type="email"
              class="form-input"
              placeholder="请输入邮箱"
            />
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">保存</button>
            <button
              type="button"
              @click="showEditProfile = false"
              class="btn btn-secondary"
            >
              取消
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "UserCenter",
  data() {
    return {
      activeTab: "bookshelf",
      showEditProfile: false,
      menuVisible: false,
      userInfo: {
        nickname: "读者小明",
        phone: "138****8888",
        email: "reader@example.com",
        avatar: "https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg",
      },
      editForm: {
        nickname: "",
        email: "",
      },
      tabs: [
        { id: "bookshelf", name: "📚 我的书架" },
        { id: "favorites", name: "⭐ 我的收藏" },
        { id: "history", name: "📖 阅读历史" },
        { id: "notes", name: "📝 我的笔记" },
      ],
      myBooks: [
        {
          id: 1,
          title: "斗破苍穹",
          author: "天蚕土豆",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          progress: 75,
        },
        {
          id: 2,
          title: "凡人修仙传",
          author: "忘语",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          progress: 50,
        },
      ],
      myFavorites: [
        {
          id: 1,
          title: "诡秘之主",
          authorName: "爱潜水的乌贼",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          likeCount: 12580,
          collectCount: 8960,
          viewCount: 456789,
        },
      ],
      readingHistory: [
        {
          id: 1,
          bookId: 1,
          title: "斗破苍穹",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          lastChapter: "第250章 三年之约",
          lastReadTime: "2小时前",
        },
      ],
      myNotes: [
        {
          id: 1,
          bookTitle: "斗破苍穹",
          chapterTitle: "第一章 陨落的天才",
          content: "三十年河东，三十年河西，莫欺少年穷！",
          createTime: "2024-01-15 14:30",
        },
      ],
    };
  },
  mounted() {
    this.loadUserInfo();
    this.loadMyBooks();
  },
  methods: {
    toggleMenu() {
      this.menuVisible = !this.menuVisible;
    },
    goToUserCenter() {
      this.menuVisible = false;
    },
    goToShelf() {
      this.menuVisible = false;
      this.$router.push("/bookshelf");
    },
    goToAuthorCenter() {
      this.menuVisible = false;
      this.$router.push("/author-center");
    },
    logout() {
      this.menuVisible = false;
      localStorage.removeItem("token");
      this.$router.push("/login");
    },
    loadUserInfo() {
      // TODO: 从API加载用户信息
      this.editForm.nickname = this.userInfo.nickname;
      this.editForm.email = this.userInfo.email;
    },
    loadMyBooks() {
      // TODO: 从API加载用户书架
    },
    goToBook(bookId) {
      this.$router.push(`/reader/${bookId}`);
    },
    goToWork(workId) {
      // TODO: 跳转到作品详情页
      console.log("查看作品", workId);
    },
    uncollectWork(workId) {
      // TODO: 取消收藏作品
      console.log("取消收藏", workId);
    },
    deleteNote(noteId) {
      // TODO: 删除笔记
      console.log("删除笔记", noteId);
    },
    saveProfile() {
      // TODO: 保存用户资料
      this.userInfo.nickname = this.editForm.nickname;
      this.userInfo.email = this.editForm.email;
      this.showEditProfile = false;
      alert("保存成功！");
    },
  },
};
</script>

<style scoped>
/* 整体布局 */
.user-center {
  min-height: 100vh;
  background: #fafafa;
}

/* 顶部导航栏 */
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 40px;
  background: #fff;
  border-bottom: 1px solid #eee;
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-left {
  display: flex;
  gap: 24px;
}

.nav-item {
  color: #666;
  text-decoration: none;
  font-size: 14px;
  transition: color 0.2s;
}

.nav-item:hover {
  color: #1a73e8;
}

.nav-item.active {
  color: #1a73e8;
  font-weight: 600;
}

/* 头像和下拉菜单 */
.avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  cursor: pointer;
  border: 2px solid #eee;
  transition: border-color 0.2s;
}

.avatar:hover {
  border-color: #1a73e8;
}

.nav-right {
  position: relative;
}

.dropdown-menu {
  position: absolute;
  top: 48px;
  right: 0;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  width: 140px;
  z-index: 1000;
  overflow: hidden;
}

.menu-item {
  padding: 12px 16px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.menu-item:hover {
  background-color: #f5f5f5;
}

.menu-divider {
  height: 1px;
  background-color: #eee;
  margin: 4px 0;
  padding: 0;
  cursor: default;
}

.menu-divider:hover {
  background-color: #eee;
}

/* 主体内容 */
.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px;
}

/* 用户信息卡片 */
.user-info-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.user-info-header {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 24px;
  padding-bottom: 24px;
  border-bottom: 1px solid #f0f0f0;
}

.user-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #1a73e8;
}

.user-info-details {
  flex: 1;
}

.user-nickname {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin-bottom: 8px;
}

.user-phone,
.user-email {
  font-size: 14px;
  color: #666;
  margin: 4px 0;
}

.edit-btn {
  padding: 10px 20px;
  background: #1a73e8;
  color: #fff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.edit-btn:hover {
  background: #1669c1;
}

/* 统计数据 */
.user-stats {
  display: flex;
  justify-content: space-around;
  align-items: center;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #1a73e8;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 14px;
  color: #999;
}

.stat-divider {
  width: 1px;
  height: 40px;
  background: #eee;
}

/* 标签页容器 */
.tabs-container {
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.tabs-nav {
  display: flex;
  border-bottom: 2px solid #f0f0f0;
  padding: 0 24px;
}

.tab-btn {
  padding: 16px 24px;
  background: none;
  border: none;
  font-size: 15px;
  font-weight: 500;
  color: #666;
  cursor: pointer;
  transition: all 0.2s;
  border-bottom: 3px solid transparent;
  margin-bottom: -2px;
}

.tab-btn:hover {
  color: #1a73e8;
}

.tab-btn.active {
  color: #1a73e8;
  border-bottom-color: #1a73e8;
}

.tab-content {
  padding: 24px;
  min-height: 400px;
}

/* 书籍网格 */
.books-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
  gap: 20px;
}

.book-card-item {
  cursor: pointer;
  transition: transform 0.2s;
}

.book-card-item:hover {
  transform: translateY(-4px);
}

.book-cover-wrapper {
  position: relative;
  aspect-ratio: 3/4;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.book-cover-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
}

.book-card-item:hover .book-cover-img {
  transform: scale(1.05);
}

.reading-progress {
  position: absolute;
  bottom: 8px;
  right: 8px;
  background: rgba(0, 0, 0, 0.7);
  color: #fff;
  font-size: 12px;
  padding: 4px 8px;
  border-radius: 4px;
}

.book-title-text {
  font-size: 14px;
  font-weight: 500;
  color: #333;
  margin-bottom: 4px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.book-author-text {
  font-size: 12px;
  color: #999;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 收藏列表 */
.favorites-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
  gap: 16px;
}

.favorite-card {
  display: flex;
  gap: 16px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  position: relative;
}

.favorite-card:hover {
  background: #f0f0f0;
  transform: translateX(4px);
}

.favorite-cover {
  width: 80px;
  height: 110px;
  object-fit: cover;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.favorite-info {
  flex: 1;
}

.favorite-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 8px;
}

.favorite-author {
  font-size: 14px;
  color: #666;
  margin-bottom: 12px;
}

.favorite-stats {
  display: flex;
  gap: 12px;
}

.stat-badge {
  font-size: 12px;
  color: #999;
}

.uncollect-btn {
  position: absolute;
  top: 16px;
  right: 16px;
  padding: 6px 12px;
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 12px;
  color: #666;
  cursor: pointer;
  transition: all 0.2s;
}

.uncollect-btn:hover {
  border-color: #ff4d4f;
  color: #ff4d4f;
}

/* 历史记录列表 */
.history-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.history-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.history-item:hover {
  background: #f0f0f0;
}

.history-cover {
  width: 60px;
  height: 80px;
  object-fit: cover;
  border-radius: 6px;
}

.history-info {
  flex: 1;
}

.history-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 6px;
}

.history-chapter {
  font-size: 14px;
  color: #666;
  margin-bottom: 4px;
}

.history-time {
  font-size: 12px;
  color: #999;
}

.continue-btn {
  padding: 8px 16px;
  background: #1a73e8;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.continue-btn:hover {
  background: #1669c1;
}

/* 笔记列表 */
.notes-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.note-card {
  padding: 20px;
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  transition: all 0.2s;
}

.note-card:hover {
  border-color: #1a73e8;
  box-shadow: 0 4px 12px rgba(26, 115, 232, 0.1);
}

.note-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.note-book-title {
  font-size: 15px;
  font-weight: 600;
  color: #333;
}

.note-time {
  font-size: 12px;
  color: #999;
}

.note-content {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 12px;
}

.note-actions {
  display: flex;
  gap: 8px;
}

.note-action-btn {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s;
}

.note-action-btn.edit {
  background: #e8f4ff;
  color: #1a73e8;
}

.note-action-btn.edit:hover {
  background: #d0e8ff;
}

.note-action-btn.delete {
  background: #ffebeb;
  color: #ff4d4f;
}

.note-action-btn.delete:hover {
  background: #ffd4d4;
}

/* 空状态 */
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
}

.empty-icon {
  font-size: 64px;
  margin-bottom: 16px;
  opacity: 0.5;
}

.empty-text {
  font-size: 16px;
  color: #999;
  margin-bottom: 24px;
}

.goto-btn {
  padding: 10px 24px;
  background: #1a73e8;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.goto-btn:hover {
  background: #1669c1;
}

/* 弹窗 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: #fff;
  border-radius: 12px;
  padding: 32px;
  width: 90%;
  max-width: 500px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
}

.modal-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
  margin-bottom: 24px;
}

.edit-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.form-label {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

.form-input {
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: #1a73e8;
}

.form-actions {
  display: flex;
  gap: 12px;
  margin-top: 8px;
}

.btn {
  flex: 1;
  padding: 12px;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-primary {
  background: #1a73e8;
  color: #fff;
}

.btn-primary:hover {
  background: #1669c1;
}

.btn-secondary {
  background: #f0f0f0;
  color: #666;
}

.btn-secondary:hover {
  background: #e0e0e0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .header {
    padding: 12px 20px;
  }

  .main-content {
    padding: 16px;
  }

  .user-info-header {
    flex-direction: column;
    text-align: center;
  }

  .user-stats {
    flex-wrap: wrap;
  }

  .tabs-nav {
    overflow-x: auto;
  }

  .books-grid {
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    gap: 16px;
  }

  .favorites-list {
    grid-template-columns: 1fr;
  }
}
</style>
