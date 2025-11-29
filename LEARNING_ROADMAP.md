# Vue 2 项目实战学习路线图 (Learning Roadmap)

这不仅仅是一个简单的增删改查项目，它是一个完美的 Vue 2 练兵场。为了让你边学边做，我为你整理了以下“闯关任务”。

这个路线图旨在帮助你将 Vue 2 的知识点（Knowledge Points）转化为实际的代码功能（Features）。

## 阶段一：基础巩固 (当前阶段)

- [x] **环境搭建**: Vue CLI, Webpack, 目录结构。
- [x] **基础路由**: Vue Router 配置, `router-view`, `router-link` (菜单)。
- [x] **UI 组件**: Element UI 的基本引入和使用。
- [x] **基础指令**: `v-model` (表单), `v-for` (列表), `v-if/v-show` (弹窗控制), `@click` (事件)。

---

## 阶段二：深入响应式与逻辑 (Reactivity & Logic)

**目标**: 掌握 Vue 2 独特的 Options API 核心。

### 任务 1: 列表搜索 (Computed)

- **功能**: 在学生列表上方加一个搜索框，输入姓名，表格自动过滤显示匹配的学生。
- **知识点**: `computed` (计算属性)。
- **为什么**: 学习如何基于现有数据派生出新数据，且利用缓存特性。

### 任务 2: 数据监听 (Watchers)

- **功能**: 当搜索框内容变化时，在控制台打印 "正在搜索: [关键词]..."，并模拟 500ms 延迟。
- **知识点**: `watch` (侦听器), 异步操作。
- **为什么**: 学习如何响应数据的变化执行副作用 (Side Effects)。

### 任务 3: 数据格式化 (Filters)

- **功能**: 给学生数据增加一个 `enrollmentDate` (入学日期) 字段 (时间戳)，在表格中显示为 `YYYY-MM-DD` 格式。
- **知识点**: `filters` (过滤器 - Vue 2 特有特性)。
- **为什么**: 学习文本格式化的最佳实践。

---

## 阶段三：组件化思维 (Component Composition)

**目标**: 告别“面条代码”，学会拆分组件。

### 任务 4: 弹窗表单拆分 (Props & Events)

- **功能**: 目前 `StudentList.vue` 代码太长了。请将 `<el-dialog>` 及其内部的表单拆分到一个新组件 `StudentForm.vue` 中。
- **知识点**:
  - 父传子: `props` (传递编辑时的初始数据)。
  - 子传父: `this.$emit` (通知父组件“保存成功”或“关闭弹窗”)。
  - `.sync` 修饰符 (可选，进阶): 优雅地控制弹窗显示隐藏。

### 任务 4.5: 表单验证 (Form Validation)

- **功能**: 在 `StudentForm` 中添加校验规则：姓名不能为空，年龄必须在 1-100 之间。
- **知识点**: Element UI `rules`, `this.$refs.form.validate()`, 正则表达式。
- **为什么**: 脏数据是系统的噩梦，前端必须把好第一道关。

### 任务 5: 封装通用插槽 (Slots)

- **功能**: 创建一个 `PageContainer.vue` 组件，包含统一的标题样式和面包屑导航，将页面内容放入插槽。
- **知识点**: `slot` (默认插槽), `named slot` (具名插槽)。

---

## 阶段四：进阶与网络 (Advanced & Network)

**目标**: 模拟真实开发场景。

### 任务 6: 模拟后端交互 (Axios & Lifecycle)

- **功能**: 安装 `axios`，使用 `public/mock/data.json` 或 Mock API (如 json-server) 替换写死的 `tableData`。
- **知识点**:
  - `created` vs `mounted` 生命周期钩子 (在哪里发请求？)。
  - `axios` 封装 (拦截器，统一错误处理)。

### 任务 7: 自定义指令 (Directives)

- **功能**: 打开新增弹窗时，自动让“姓名”输入框获得焦点。
- **知识点**: `Vue.directive` (自定义指令), DOM 操作。

### 任务 8: 混入 (Mixins - Vue 2 Legacy Pattern)

- **功能**: 如果有多个页面都有“分页”逻辑，提取一个 `paginationMixin.js`。
- **知识点**: `mixins` (代码复用)。_注：这是 Vue 2 常见模式，Vue 3 中已被 Composition API 取代，但维护老项目必学。_

---

## 阶段五：系统安全与全局状态 (Security & State)

**目标**: 像架构师一样思考，解决“全局”问题。

### 任务 9: 路由守卫 (Permission Control)

- **功能**: 实现“只有登录后才能访问学生列表”。如果未登录访问 `/student`，强制跳转到 `/login`。
- **知识点**: `router.beforeEach`, `localStorage` (存储 Token)。

### 任务 10: 引入 Vuex (Global State)

- **功能**: 将“当前登录用户名”存入 Vuex，并在页面顶部的 `Header` 组件中读取显示。
- **知识点**: `store`, `state`, `mutations`。
- **为什么**: 学习如何管理跨组件的共享状态，避免 Props 层层传递 (Prop Drilling)。

### 任务 11: 生产环境构建 (Build & Deploy)

- **功能**: 运行 `npm run build`，解决路径 404 问题，尝试部署到 GitHub Pages 或本地 Nginx。
- **知识点**: `vue.config.js` (`publicPath`), 生产环境优化。

---

## 建议学习顺序

建议按照 **任务 1 -> 任务 4 -> 任务 4.5 -> 任务 6 -> 任务 9** 的顺序进行，这是一条从“基础”到“工程化”的完整路径。
