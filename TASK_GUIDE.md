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

## 任务 3：添加数据格式化 (使用 Filters)

### 🎯 目标

给学生数据增加一个"入学日期"字段，在表格中显示为人类可读的格式（如 `2023-09-01`），而不是时间戳。

### 📝 任务步骤

#### 第 1 步：修改模拟数据

在 `data()` 中的 `tableData` 里，给每个学生增加一个 `enrollmentDate` 字段。

**提示**：

- 时间戳格式：`1693526400000` (毫秒级)
- 可以用在线工具生成：https://tool.lu/timestamp/
- 或者使用 `new Date('2023-09-01').getTime()`

**示例数据**：

```javascript
tableData: [
  {
    id: 1,
    name: '张三',
    age: 18,
    class: '高一(1)班',
    enrollmentDate: 1693526400000
  },
  {
    id: 2,
    name: '李四',
    age: 17,
    class: '高一(2)班',
    enrollmentDate: 1693526400000
  },
  {
    id: 3,
    name: '王五',
    age: 18,
    class: '高一(1)班',
    enrollmentDate: 1693526400000
  }
]
```

#### 第 2 步：定义过滤器

在 `export default` 中，添加 `filters` 选项（与 `data`、`computed`、`methods` 同级）。

**提示**：

- 过滤器名建议叫 `formatDate`
- 接收一个参数 `timestamp`（时间戳）
- 如果时间戳不存在，返回 `'-'`
- 使用 `new Date(timestamp)` 创建日期对象
- 使用 `toLocaleDateString('zh-CN')` 格式化日期

**关键代码结构**（填空）：

```javascript
filters: {
  formatDate(timestamp) {
    if (!timestamp) return '-'
    const date = new Date(timestamp)
    // 方法 1：使用 toLocaleDateString (推荐)
    return date.toLocaleDateString('zh-CN')

    // 方法 2：手动拼接 YYYY-MM-DD (进阶)
    // const year = date.getFullYear()
    // const month = String(date.getMonth() + 1).padStart(2, '0')
    // const day = String(date.getDate()).padStart(2, '0')
    // return `${year}-${month}-${day}`
  }
}
```

#### 第 3 步：在表格中使用过滤器

在 `<el-table>` 中新增一列显示入学日期。

**提示**：

- 添加一个新的 `<el-table-column>`
- `label` 设为 `"入学日期"`
- `prop` 设为 `"enrollmentDate"`
- 使用**插槽语法** `slot-scope="scope"` (Vue 2 + Element UI)
- 在插槽中使用**管道符** `|` 调用过滤器

**示例代码**：

```vue
<el-table-column label="入学日期" prop="enrollmentDate">
  <template slot-scope="scope">
    {{ scope.row.enrollmentDate | formatDate }}
  </template>
</el-table-column>
```

#### 第 4 步：扩展 - 在表单中添加日期选择器（可选）

如果想在新增/编辑时也能选择入学日期：

**提示**：

- 在 `form` 数据中增加 `enrollmentDate: null`
- 在 `<el-dialog>` 的表单中添加 `<el-date-picker>`
- 设置 `type="date"` 和 `value-format="timestamp"`
- 使用 `v-model="form.enrollmentDate"`

**示例**：

```vue
<el-form-item label="入学日期">
  <el-date-picker
    v-model="form.enrollmentDate"
    type="date"
    placeholder="选择日期"
    value-format="timestamp">
  </el-date-picker>
</el-form-item>
```

---

## 任务 4：组件拆分 (使用 Props & Events)

### 🎯 目标

将 `StudentList.vue` 中的弹窗表单拆分成一个独立组件 `StudentForm.vue`，学习父子组件通信。

### 📝 任务步骤

#### 第 1 步：创建新组件文件

在 `src/components/` 目录下新建 `StudentForm.vue` 文件。

**基础结构**：

```vue
<template>
  <el-dialog :title="title" :visible.sync="visible" width="500px">
    <!-- 这里放表单内容 -->
  </el-dialog>
</template>

<script>
export default {
  name: 'StudentForm',
  props: {},
  data() {
    return {}
  },
  methods: {}
}
</script>
```

#### 第 2 步：定义 Props (父传子)

子组件需要从父组件接收哪些数据？

**提示**：

- `visible` - 弹窗是否显示 (Boolean)
- `title` - 弹窗标题 (String)
- `formData` - 表单数据对象 (Object)

**关键代码**：

```javascript
props: {
  visible: {
    type: Boolean,
    default: false
  },
  title: {
    type: String,
    default: '学生信息'
  },
  formData: {
    type: Object,
    default: () => ({
      id: null,
      name: '',
      age: '',
      class: '',
      enrollmentDate: null
    })
  }
}
```

#### 第 3 步：从父组件复制表单代码

将 `StudentList.vue` 中的 `<el-form>` 完整复制到 `StudentForm.vue` 的 `<el-dialog>` 内。

**注意修改**：

- 把所有的 `this.form` 改为 `localForm`
- 在 `data()` 中定义 `localForm: {}`
- 使用 `watch` 监听 `formData` 的变化，同步到 `localForm`

**关键代码**：

```javascript
data() {
  return {
    localForm: {},
    rules: {
      // 复制验证规则
    }
  }
},
watch: {
  formData: {
    handler(newVal) {
      this.localForm = { ...newVal }
    },
    immediate: true,
    deep: true
  }
}
```

#### 第 4 步：定义 Events (子传父)

子组件需要通知父组件哪些事件？

**提示**：

- 点击"确定"按钮 → 触发 `save` 事件，传递表单数据
- 点击"取消"或关闭 → 触发 `close` 事件

**关键代码**：

```javascript
methods: {
  handleSave() {
    this.$refs.form.validate((valid) => {
      if (valid) {
        // 通知父组件保存
        this.$emit('save', this.localForm)
      } else {
        return false
      }
    })
  },
  handleClose() {
    // 通知父组件关闭
    this.$emit('close')
  }
}
```

**弹窗按钮修改**：

```vue
<span slot="footer">
  <el-button @click="handleClose">取 消</el-button>
  <el-button type="primary" @click="handleSave">确 定</el-button>
</span>
```

#### 第 5 步：在父组件中使用子组件

在 `StudentList.vue` 中引入并使用 `StudentForm`。

**第 5.1 步 - 导入组件**：

```javascript
import StudentForm from '@/components/StudentForm.vue'

export default {
  name: 'StudentList',
  components: {
    StudentForm
  }
}
```

**第 5.2 步 - 替换弹窗部分**：

把原来的 `<el-dialog>` 全部删除，替换为：

```vue
<student-form
  :visible="dialogVisible"
  :title="dialogTitle"
  :form-data="form"
  @save="handleFormSave"
  @close="handleFormClose"
>
</student-form>
```

**第 5.3 步 - 修改父组件方法**：

```javascript
methods: {
  handleFormSave(formData) {
    // 原来 handleSave 里的逻辑
    console.log('保存数据:', formData)
    if (formData.id) {
      // 编辑逻辑
      const index = this.tableData.findIndex(item => item.id === formData.id)
      if (index !== -1) {
        this.$set(this.tableData, index, { ...formData })
      }
    } else {
      // 新增逻辑
      formData.id = Date.now()
      this.tableData.push({ ...formData })
    }
    this.$message.success('保存成功！')
    this.dialogVisible = false
  },
  handleFormClose() {
    this.dialogVisible = false
  }
}
```

#### 第 6 步：使用 .sync 修饰符（进阶优化）

让子组件也能直接控制弹窗显示状态。

**父组件修改**：

```vue
<student-form :visible.sync="dialogVisible" <!-- 其他 props -->
</student-form>
```

**子组件修改 - 关闭弹窗**：

```javascript
handleClose() {
  this.$emit('update:visible', false)
}
```

**或者直接用计算属性**：

```javascript
computed: {
  dialogVisible: {
    get() {
      return this.visible
    },
    set(val) {
      this.$emit('update:visible', val)
    }
  }
}
```

然后模板中直接使用：

```vue
<el-dialog :visible.sync="dialogVisible">
```

---

## 任务 4.5：添加表单验证 (使用 Element UI Rules)

### 🎯 目标

点击"确定"保存时，如果表单有空值或不合法的值，显示错误提示，阻止提交。

### � 任务步骤

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
- **Filters 过滤器**：官方文档 → https://v2.cn.vuejs.org/v2/guide/filters.html
- **Props & Events 组件通信**：官方文档 → https://v2.cn.vuejs.org/v2/guide/components.html
- **Element UI 表单验证**：官方文档 → https://element.eleme.cn/#/zh-CN/component/form
- **Element UI DatePicker**：官方文档 → https://element.eleme.cn/#/zh-CN/component/date-picker

---

## ✅ 自检清单

完成后，请自己测试以下场景：

### 任务 1-2 基础功能测试

- [ ] 在搜索框输入"张"，表格只显示"张三"
- [ ] 清空搜索框，所有学生重新显示
- [ ] 打开控制台 (F12)，在搜索框打字，看到 `"正在搜索: ..."`

### 任务 3 数据格式化测试

- [ ] 表格中新增"入学日期"列，显示格式为 `2023/9/1` 或 `2023-09-01`
- [ ] 新增学生时可以选择入学日期（如果实现了日期选择器）
- [ ] 没有日期的学生显示 `-`

### 任务 4 组件拆分测试

- [ ] 弹窗功能正常，样式和之前一致
- [ ] 新增学生功能正常
- [ ] 编辑学生功能正常，能正确显示原数据
- [ ] 在 Vue DevTools 中能看到 `StudentForm` 组件
- [ ] 父组件代码行数明显减少，逻辑更清晰

### 任务 4.5 表单验证测试

- [ ] 点击"新增学生"，不填任何内容，点"确定"，看到红色错误提示
- [ ] 在年龄框输入非数字或超出范围的数字，看到错误提示
- [ ] 填写正确的数据，点"确定"，弹窗关闭，学生被添加

---

**遇到问题随时问我！我会引导您思考，而不是直接给答案。加油！🚀**
