<template>
  <div class="author-center">
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="nav-left">
        <router-link to="/" class="nav-item">首页</router-link>
        <router-link to="/bookshelf" class="nav-item">我的书架</router-link>
        <router-link to="/author-center" class="nav-item active">作者中心</router-link>
        <router-link to="/user-center" class="nav-item">个人中心</router-link>
      </div>
      <div class="nav-right">
        <!-- 头像 -->
        <img
          src="https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg"
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
      <!-- 作者信息卡片 -->
      <div class="author-info-card">
        <div class="author-header">
          <div class="author-avatar-section">
            <img
              src="https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg"
              alt="作者头像"
              class="author-avatar"
            />
            <div class="author-details">
              <h2 class="author-name">✍️ 作者笔名</h2>
              <p class="author-intro">专注于玄幻、仙侠题材创作</p>
            </div>
          </div>
          <button class="settings-btn" @click="showSettings = true">
            ⚙️ 设置
          </button>
        </div>

        <!-- 数据统计 -->
        <div class="stats-grid">
          <div class="stat-card stat-blue">
            <div class="stat-icon">📚</div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.totalWorks }}</div>
              <div class="stat-label">总作品数</div>
            </div>
          </div>
          <div class="stat-card stat-green">
            <div class="stat-icon">✍️</div>
            <div class="stat-info">
              <div class="stat-value">{{ formatNumber(stats.totalWords) }}</div>
              <div class="stat-label">总字数</div>
            </div>
          </div>
          <div class="stat-card stat-purple">
            <div class="stat-icon">👁️</div>
            <div class="stat-info">
              <div class="stat-value">{{ formatNumber(stats.totalViews) }}</div>
              <div class="stat-label">总浏览量</div>
            </div>
          </div>
          <div class="stat-card stat-pink">
            <div class="stat-icon">❤️</div>
            <div class="stat-info">
              <div class="stat-value">{{ stats.totalFans }}</div>
              <div class="stat-label">粉丝数</div>
            </div>
          </div>
        </div>
      </div>

      <!-- 标签页 -->
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

        <!-- 我的作品 -->
        <div v-show="activeTab === 'works'" class="tab-content">
          <div class="content-header">
            <h3 class="content-title">📚 我的作品</h3>
            <button class="create-btn" @click="showCreateWork = true">
              ➕ 创建新作品
            </button>
          </div>

          <div class="works-grid">
            <div
              v-for="work in myWorks"
              :key="work.id"
              class="work-card"
              @click="viewWork(work)"
            >
              <img :src="work.cover" :alt="work.title" class="work-cover" />
              <div class="work-info">
                <div class="work-header">
                  <h4 class="work-title">{{ work.title }}</h4>
                  <span :class="['work-status', 'status-' + work.status]">
                    {{ getStatusText(work.status) }}
                  </span>
                </div>
                <div class="work-stats-row">
                  <div class="work-stat">
                    <span class="stat-label">字数</span>
                    <span class="stat-value">{{ formatNumber(work.wordCount) }}</span>
                  </div>
                  <div class="work-stat">
                    <span class="stat-label">浏览</span>
                    <span class="stat-value">{{ work.viewCount }}</span>
                  </div>
                  <div class="work-stat">
                    <span class="stat-label">收藏</span>
                    <span class="stat-value">{{ work.collectCount }}</span>
                  </div>
                </div>
                <div class="work-actions">
                  <button class="work-btn edit-btn" @click.stop="editWork(work)">
                    ✏️ 编辑
                  </button>
                  <button class="work-btn chapter-btn" @click.stop="manageChapters(work)">
                    📖 章节
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div v-if="myWorks.length === 0" class="empty-state">
            <div class="empty-icon">📚</div>
            <p class="empty-text">还没有发布任何作品</p>
            <button class="goto-btn" @click="showCreateWork = true">创建第一部作品</button>
          </div>
        </div>

        <!-- 数据分析 -->
        <div v-show="activeTab === 'analytics'" class="tab-content">
          <div class="content-header">
            <h3 class="content-title">📊 数据趋势</h3>
          </div>

          <div class="analytics-summary">
            <div class="summary-card blue">
              <div class="summary-label">今日浏览</div>
              <div class="summary-value">{{ stats.todayViews }}</div>
            </div>
            <div class="summary-card green">
              <div class="summary-label">本周浏览</div>
              <div class="summary-value">{{ stats.weekViews }}</div>
            </div>
            <div class="summary-card purple">
              <div class="summary-label">本月浏览</div>
              <div class="summary-value">{{ stats.monthViews }}</div>
            </div>
          </div>

          <div class="chart-container">
            <h4 class="chart-title">📈 作品浏览趋势</h4>
            <div class="chart-wrapper">
              <div class="chart-bars">
                <div
                  v-for="(data, index) in chartData"
                  :key="index"
                  class="chart-bar"
                  :style="{ height: (data.value / maxChartValue) * 100 + '%' }"
                  :title="`${data.label}: ${data.value}`"
                >
                  <div class="bar-value">{{ data.value }}</div>
                </div>
              </div>
              <div class="chart-labels">
                <span v-for="(data, index) in chartData" :key="index" class="chart-label">
                  {{ data.label }}
                </span>
              </div>
            </div>
          </div>
        </div>

        <!-- 读者互动 -->
        <div v-show="activeTab === 'interaction'" class="tab-content">
          <div class="content-header">
            <h3 class="content-title">💬 读者评论</h3>
          </div>

          <div class="comments-list">
            <div v-for="comment in comments" :key="comment.id" class="comment-card">
              <img :src="comment.userAvatar" alt="用户头像" class="comment-avatar" />
              <div class="comment-content">
                <div class="comment-header">
                  <span class="comment-user">{{ comment.userName }}</span>
                  <span class="comment-time">{{ comment.time }}</span>
                </div>
                <p class="comment-text">{{ comment.content }}</p>
                <div class="comment-work">
                  来自作品: 《{{ comment.workTitle }}》
                </div>
              </div>
            </div>
          </div>

          <div v-if="comments.length === 0" class="empty-state">
            <div class="empty-icon">💬</div>
            <p class="empty-text">暂无读者评论</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 创建作品弹窗 -->
    <div v-if="showCreateWork" class="modal-overlay" @click.self="showCreateWork = false">
      <div class="modal-content modal-large">
        <h3 class="modal-title">✨ 创建新作品</h3>
        <form @submit.prevent="createWork" class="create-form">
          <div class="form-group">
            <label class="form-label">作品标题 *</label>
            <input
              v-model="workForm.title"
              type="text"
              required
              class="form-input"
              placeholder="请输入作品标题"
            />
          </div>
          <div class="form-group">
            <label class="form-label">分类 *</label>
            <select v-model="workForm.category" required class="form-input">
              <option value="">请选择分类</option>
              <option value="玄幻">玄幻</option>
              <option value="仙侠">仙侠</option>
              <option value="都市">都市</option>
              <option value="历史">历史</option>
              <option value="科幻">科幻</option>
              <option value="武侠">武侠</option>
              <option value="言情">言情</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">作品简介</label>
            <textarea
              v-model="workForm.description"
              rows="5"
              class="form-input"
              placeholder="请输入作品简介，让读者更好地了解你的作品..."
            ></textarea>
          </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary">✨ 创建作品</button>
            <button type="button" @click="showCreateWork = false" class="btn btn-secondary">
              取消
            </button>
          </div>
        </form>
      </div>
    </div>

    <!-- 设置弹窗 -->
    <div v-if="showSettings" class="modal-overlay" @click.self="showSettings = false">
      <div class="modal-content">
        <h3 class="modal-title">⚙️ 作者设置</h3>
        <div class="settings-form">
          <div class="form-group">
            <label class="form-label">笔名</label>
            <input
              type="text"
              class="form-input"
              placeholder="请输入笔名"
            />
          </div>
          <div class="form-group">
            <label class="form-label">个人简介</label>
            <textarea
              rows="4"
              class="form-input"
              placeholder="向读者介绍一下自己吧..."
            ></textarea>
          </div>
          <div class="form-actions">
            <button class="btn btn-primary" @click="saveSettings">保存</button>
            <button class="btn btn-secondary" @click="showSettings = false">取消</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AuthorCenter",
  data() {
    return {
      activeTab: "works",
      showCreateWork: false,
      showSettings: false,
      menuVisible: false,
      stats: {
        totalWorks: 3,
        totalWords: 256789,
        totalViews: 1234567,
        totalLikes: 8900,
        totalCollects: 5600,
        totalFans: 1280,
        todayViews: 1250,
        weekViews: 8960,
        monthViews: 35420,
      },
      tabs: [
        { id: "works", name: "📚 我的作品" },
        { id: "analytics", name: "📊 数据分析" },
        { id: "interaction", name: "💬 读者互动" },
      ],
      myWorks: [
        {
          id: 1,
          title: "斗破苍穹",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          status: 1,
          wordCount: 120000,
          viewCount: 450000,
          collectCount: 2300,
        },
        {
          id: 2,
          title: "凡人修仙传",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          status: 1,
          wordCount: 85000,
          viewCount: 320000,
          collectCount: 1800,
        },
        {
          id: 3,
          title: "完美世界",
          cover: "https://img.picui.cn/free/2024/10/25/671b1fb1be388.jpg",
          status: 2,
          wordCount: 51789,
          viewCount: 464567,
          collectCount: 1500,
        },
      ],
      comments: [
        {
          id: 1,
          userName: "热心读者",
          userAvatar:
            "https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg",
          content: "写得太精彩了！作者大大加油更新啊！",
          workTitle: "斗破苍穹",
          time: "2小时前",
        },
        {
          id: 2,
          userName: "书迷一号",
          userAvatar:
            "https://img.remit.ee/api/file/BQACAgUAAyEGAASHRsPbAAEDINho4O3zb7IlJpv-ubh9RS5dt4IrgwAC8RsAAmykCFfh2rkqr_C9ATYE.jpg",
          content: "剧情设计非常巧妙，人物刻画也很到位！",
          workTitle: "凡人修仙传",
          time: "5小时前",
        },
      ],
      chartData: [],
      maxChartValue: 0,
      workForm: {
        title: "",
        category: "",
        description: "",
      },
    };
  },
  mounted() {
    this.loadAuthorStats();
    this.loadMyWorks();
    this.loadChartData();
    this.loadComments();
  },
  methods: {
    toggleMenu() {
      this.menuVisible = !this.menuVisible;
    },
    goToUserCenter() {
      this.menuVisible = false;
      this.$router.push("/user-center");
    },
    goToShelf() {
      this.menuVisible = false;
      this.$router.push("/bookshelf");
    },
    goToAuthorCenter() {
      this.menuVisible = false;
    },
    logout() {
      this.menuVisible = false;
      localStorage.removeItem("token");
      this.$router.push("/login");
    },
    loadAuthorStats() {
      // TODO: 从API加载作者统计数据
      // axios.get('/api/author/' + userId + '/stats')
    },
    loadMyWorks() {
      // TODO: 从API加载作者作品
      // axios.get('/api/work/author/' + userId)
    },
    loadComments() {
      // TODO: 从API加载读者评论
    },
    loadChartData() {
      // 模拟图表数据
      this.chartData = [
        { label: "周一", value: 1200 },
        { label: "周二", value: 1500 },
        { label: "周三", value: 1800 },
        { label: "周四", value: 2000 },
        { label: "周五", value: 1600 },
        { label: "周六", value: 1400 },
        { label: "周日", value: 1000 },
      ];
      this.maxChartValue = Math.max(...this.chartData.map((d) => d.value));
    },
    formatNumber(num) {
      if (num >= 10000) {
        return (num / 10000).toFixed(1) + "万";
      }
      return num;
    },
    getStatusText(status) {
      const statusMap = {
        0: "草稿",
        1: "连载中",
        2: "已完结",
      };
      return statusMap[status] || "未知";
    },
    createWork() {
      if (!this.workForm.title || !this.workForm.category) {
        alert("请填写必填项！");
        return;
      }
      // TODO: 调用API创建作品
      console.log("创建作品", this.workForm);
      this.showCreateWork = false;
      alert("作品创建成功！");
      this.workForm = { title: "", category: "", description: "" };
    },
    viewWork(work) {
      // TODO: 跳转到作品详情页
      console.log("查看作品", work);
    },
    editWork(work) {
      // TODO: 编辑作品
      console.log("编辑作品", work);
    },
    manageChapters(work) {
      // TODO: 章节管理
      console.log("章节管理", work);
    },
    saveSettings() {
      // TODO: 保存设置
      this.showSettings = false;
      alert("设置保存成功！");
    },
  },
};
</script>

<style scoped>
/* 整体布局 */
.author-center {
  min-height: 100vh;
  background: #fafafa;
}

/* 顶部导航栏 - 复用 UserCenter 样式 */
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

/* 作者信息卡片 */
.author-info-card {
  background: #fff;
  border-radius: 12px;
  padding: 24px;
  margin-bottom: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.author-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding-bottom: 24px;
  border-bottom: 1px solid #f0f0f0;
}

.author-avatar-section {
  display: flex;
  align-items: center;
  gap: 16px;
}

.author-avatar {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #1a73e8;
}

.author-details {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.author-name {
  font-size: 22px;
  font-weight: 600;
  color: #333;
}

.author-intro {
  font-size: 14px;
  color: #999;
}

.settings-btn {
  padding: 10px 20px;
  background: #f5f5f5;
  color: #666;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.settings-btn:hover {
  background: #e8e8e8;
  border-color: #1a73e8;
  color: #1a73e8;
}

/* 统计卡片网格 */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
}

.stat-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
  border-radius: 8px;
  transition: transform 0.2s, box-shadow 0.2s;
}

.stat-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
}

.stat-card.stat-blue {
  background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
}

.stat-card.stat-green {
  background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
}

.stat-card.stat-purple {
  background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%);
}

.stat-card.stat-pink {
  background: linear-gradient(135deg, #fce4ec 0%, #f8bbd0 100%);
}

.stat-icon {
  font-size: 36px;
}

.stat-info {
  flex: 1;
}

.stat-value {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 4px;
}

.stat-label {
  font-size: 13px;
  color: #666;
}

/* 标签页 */
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

/* 内容头部 */
.content-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.content-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
}

.create-btn {
  padding: 10px 20px;
  background: #1a73e8;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.create-btn:hover {
  background: #1669c1;
}

/* 作品网格 */
.works-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
}

.work-card {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.2s;
}

.work-card:hover {
  border-color: #1a73e8;
  box-shadow: 0 6px 16px rgba(26, 115, 232, 0.1);
  transform: translateY(-4px);
}

.work-cover {
  width: 100%;
  height: 160px;
  object-fit: cover;
}

.work-info {
  padding: 16px;
}

.work-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.work-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.work-status {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  white-space: nowrap;
  margin-left: 8px;
}

.work-status.status-0 {
  background: #f5f5f5;
  color: #999;
}

.work-status.status-1 {
  background: #e8f5e9;
  color: #4caf50;
}

.work-status.status-2 {
  background: #e3f2fd;
  color: #2196f3;
}

.work-stats-row {
  display: flex;
  gap: 16px;
  margin-bottom: 12px;
  padding: 12px;
  background: #f9f9f9;
  border-radius: 6px;
}

.work-stat {
  flex: 1;
  text-align: center;
}

.work-stat .stat-label {
  font-size: 12px;
  color: #999;
  display: block;
  margin-bottom: 4px;
}

.work-stat .stat-value {
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.work-actions {
  display: flex;
  gap: 8px;
}

.work-btn {
  flex: 1;
  padding: 8px;
  border: none;
  border-radius: 6px;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.2s;
}

.work-btn.edit-btn {
  background: #e8f4ff;
  color: #1a73e8;
}

.work-btn.edit-btn:hover {
  background: #1a73e8;
  color: #fff;
}

.work-btn.chapter-btn {
  background: #e8f5e9;
  color: #4caf50;
}

.work-btn.chapter-btn:hover {
  background: #4caf50;
  color: #fff;
}

/* 数据分析 */
.analytics-summary {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 24px;
}

.summary-card {
  padding: 20px;
  border-radius: 8px;
  text-align: center;
}

.summary-card.blue {
  background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
}

.summary-card.green {
  background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
}

.summary-card.purple {
  background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%);
}

.summary-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
}

.summary-value {
  font-size: 32px;
  font-weight: 700;
  color: #333;
}

/* 图表容器 */
.chart-container {
  background: #fff;
  border: 1px solid #e8e8e8;
  border-radius: 8px;
  padding: 24px;
}

.chart-title {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 20px;
}

.chart-wrapper {
  width: 100%;
}

.chart-bars {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  height: 200px;
  gap: 8px;
  padding: 0 20px;
  margin-bottom: 16px;
}

.chart-bar {
  flex: 1;
  background: linear-gradient(to top, #1a73e8, #64b5f6);
  border-radius: 4px 4px 0 0;
  min-height: 10px;
  position: relative;
  transition: all 0.3s;
  cursor: pointer;
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding-top: 8px;
}

.chart-bar:hover {
  background: linear-gradient(to top, #1669c1, #42a5f5);
  transform: translateY(-4px);
}

.bar-value {
  font-size: 12px;
  color: #fff;
  font-weight: 600;
}

.chart-labels {
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
}

.chart-label {
  flex: 1;
  text-align: center;
  font-size: 13px;
  color: #999;
}

/* 评论列表 */
.comments-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.comment-card {
  display: flex;
  gap: 16px;
  padding: 16px;
  background: #f9f9f9;
  border-radius: 8px;
  transition: all 0.2s;
}

.comment-card:hover {
  background: #f0f0f0;
}

.comment-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  object-fit: cover;
}

.comment-content {
  flex: 1;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.comment-user {
  font-size: 15px;
  font-weight: 600;
  color: #333;
}

.comment-time {
  font-size: 12px;
  color: #999;
}

.comment-text {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 8px;
}

.comment-work {
  font-size: 13px;
  color: #1a73e8;
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
  max-height: 90vh;
  overflow-y: auto;
}

.modal-large {
  max-width: 700px;
}

.modal-title {
  font-size: 20px;
  font-weight: 600;
  color: #333;
  margin-bottom: 24px;
}

.create-form,
.settings-form {
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

textarea.form-input {
  resize: vertical;
  min-height: 80px;
  font-family: inherit;
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
@media (max-width: 1024px) {
  .stats-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .works-grid {
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  }

  .analytics-summary {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .header {
    padding: 12px 20px;
  }

  .main-content {
    padding: 16px;
  }

  .author-header {
    flex-direction: column;
    text-align: center;
    gap: 16px;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .tabs-nav {
    overflow-x: auto;
  }

  .works-grid {
    grid-template-columns: 1fr;
  }

  .chart-bars {
    height: 150px;
  }
}
</style>
