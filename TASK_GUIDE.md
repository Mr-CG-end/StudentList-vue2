# 学习任务引导 - StudentList 改进

> **学习目标**：通过自己动手实现功能，掌握 Vue 2 的核心概念：`computed`、`watch` 和表单验证。

---

## 任务 1：添加搜索功能 (使用 Computed)

### 🎯 目标

在学生列表上方添加一个搜索框，输入姓名或班级，表格自动过滤显示匹配的学生。

### 📝 任务步骤

#### 第 1 步：添加搜索框 UI

在 `<div class="actions">` 里，"新增学生"按钮的**前面**加一个输入框。

**提示**：

- 使用 Element UI 的 `<el-input>` 组件
- 需要设置 `placeholder`（占位符）
- 可以加上 `prefix-icon="el-icon-search"` 图标
- 别忘了 `clearable` 属性（可以一键清空）

#### 第 2 步：添加数据绑定

在 `data()` 中新增一个变量来存储搜索关键词。

**提示**：

- 变量名建议叫 `searchKeyword`
- 初始值应该是空字符串 `''`
- 使用 `v-model` 将输入框和这个变量绑定

#### 第 3 步：编写计算属性

在 `computed` 中新增一个计算属性，根据 `searchKeyword` 过滤 `tableData`。

**提示**：

- 计算属性名建议叫 `filteredTableData`
- 如果 `searchKeyword` 为空，直接返回 `tableData`
- 如果不为空，使用 `filter()` 方法过滤数组
- 过滤条件：姓名或班级包含关键词（不区分大小写）
- 使用 `toLowerCase()` 转小写后再比较
- 使用 `includes()` 判断是否包含

**关键代码结构**（填空）：

```javascript
computed: {
  dialogTitle() { /* 已有代码 */ },
  filteredTableData() {
    // 1. 如果搜索词为空，返回 ______
    // 2. 否则，过滤 tableData，条件是：
    //    item.name 或 item.class 包含关键词
    return this.tableData.filter(item => {
      // 你的过滤逻辑
    })
  }
}
```

#### 第 4 步：修改表格绑定

把 `<el-table :data="tableData">` 改成绑定到新的计算属性。

**提示**：

- 修改 `:data="______"`

---

## 任务 2：添加监听器 (使用 Watch)

### 🎯 目标

当搜索框内容变化时，在控制台打印 `"正在搜索: [关键词]..."`。

### 📝 任务步骤

#### 第 1 步：添加 watch 选项

在 `export default` 中，`computed` 和 `methods` 之间添加 `watch` 选项。

#### 第 2 步：监听 searchKeyword

编写一个侦听器来监听 `searchKeyword` 的变化。

**提示**：

- 侦听器的名字必须和 `data` 中的变量名一致
- 侦听器是一个函数，接收两个参数：`newVal`（新值）和 `oldVal`（旧值）
- 在函数里使用 `console.log()` 打印搜索信息

**关键代码结构**（填空）：

```javascript
watch: {
  searchKeyword(newVal, oldVal) {
    // 打印 "正在搜索: xxx..."
    console.log(______)
  }
}
```

**扩展思考**：真实项目中，这里通常会做什么？（防抖、发送 API 请求）

---

## 任务 3：添加表单验证 (使用 Element UI Rules)

### 🎯 目标

点击"确定"保存时，如果表单有空值或不合法的值，显示错误提示，阻止提交。

### 📝 任务步骤

#### 第 1 步：定义验证规则

在 `data()` 中新增一个 `rules` 对象。

**提示**：

- `rules` 是一个对象，key 是表单字段名（如 `name`、`age`、`class`）
- 每个字段的 value 是一个数组，里面包含多个验证规则
- 每个规则是一个对象，包含：
  - `required: true` - 必填
  - `message: '提示信息'` - 错误提示
  - `trigger: 'blur'` - 触发时机（失焦时）
  - `type: 'number'` - 类型（如果是数字）
  - `min` 和 `max` - 最小值/最大值

**示例规则结构**：

```javascript
rules: {
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
  ],
  age: [
    // 你的规则：必填、必须是数字、范围 6-100
  ],
  class: [
    // 你的规则：必填
  ]
}
```

#### 第 2 步：绑定规则到表单

修改 `<el-dialog>` 里的 `<el-form>` 标签。

**提示**：

- 添加 `:rules="rules"` 属性
- 添加 `ref="form"` 属性（用于后面调用验证方法）
- 给每个 `<el-form-item>` 添加 `prop` 属性，值是字段名（如 `prop="name"`）

**示例**：

```vue
<el-form :model="form" :rules="rules" ref="form" label-width="80px">
  <el-form-item label="姓名" prop="name">
    <!-- input -->
  </el-form-item>
</el-form>
```

#### 第 3 步：修改 handleSave 方法

在保存之前，先调用表单验证。

**提示**：

- 使用 `this.$refs.form.validate()` 方法
- 该方法接收一个回调函数 `(valid) => {}`
- `valid` 为 `true` 表示验证通过，可以执行保存逻辑
- `valid` 为 `false` 表示有错误，`return false` 阻止提交

**关键代码结构**（填空）：

```javascript
handleSave() {
  // 使用 this.$refs.form.validate() 验证表单
  this.$refs.form.validate((valid) => {
    if (valid) {
      // 原有的保存逻辑（不要删除）
      console.log('Saving:', this.form)
      // ...
    } else {
      console.log('表单验证失败！')
      return false
    }
  })
}
```

#### 第 4 步：清除验证状态（可选，进阶）

当打开弹窗时（`handleAdd` 和 `handleEdit`），清除上次的验证错误提示。

**提示**：

- 使用 `this.$refs.form.clearValidate()`
- 需要放在 `this.$nextTick()` 里执行（等 DOM 更新完成）

**示例**：

```javascript
handleAdd() {
  this.isEdit = false
  this.form = { id: null, name: '', age: '', class: '' }
  this.dialogVisible = true
  // 清除验证
  this.$nextTick(() => {
    if (this.$refs.form) {
      this.$refs.form.clearValidate()
    }
  })
}
```

---

## 📚 参考资料

- **Computed 计算属性**：官方文档 → https://v2.cn.vuejs.org/v2/guide/computed.html
- **Watchers 侦听器**：官方文档 → https://v2.cn.vuejs.org/v2/guide/computed.html#侦听器
- **Element UI 表单验证**：官方文档 → https://element.eleme.cn/#/zh-CN/component/form

---

## ✅ 自检清单

完成后，请自己测试以下场景：

- [ ] 在搜索框输入"张"，表格只显示"张三"
- [ ] 清空搜索框，所有学生重新显示
- [ ] 打开控制台 (F12)，在搜索框打字，看到 `"正在搜索: ..."`
- [ ] 点击"新增学生"，不填任何内容，点"确定"，看到红色错误提示
- [ ] 在年龄框输入非数字或超出范围的数字，看到错误提示
- [ ] 填写正确的数据，点"确定"，弹窗关闭，学生被添加

---

**遇到问题随时问我！我会引导您思考，而不是直接给答案。加油！🚀**
