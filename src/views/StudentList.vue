<template>
  <div class="student-list">
    <div class="actions">
      <el-input
        placeholder="请输入搜索内容"
        prefix-icon="el-icon-search"
        clearable
        class="search-input"
        v-model="searchKeyword"
      ></el-input>
      <el-button type="primary" @click="handleAdd">新增学生</el-button>
    </div>

    <el-table
      :data="filteredTableData"
      style="width: 100%; margin-top: 20px"
      border
    >
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="name" label="姓名" width="120"></el-table-column>
      <el-table-column prop="age" label="年龄" width="80"></el-table-column>
      <el-table-column prop="class" label="班级"></el-table-column>
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDelete(scope.row)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="dialogTitle" :visible.sync="dialogVisible">
      <el-form :model="form" label-width="80px">
        <el-form-item label="姓名">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model.number="form.age" type="number"></el-input>
        </el-form-item>
        <el-form-item label="班级">
          <el-input v-model="form.class"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="handleSave">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'StudentList',
  data() {
    return {
      tableData: [
        { id: 1, name: '张三', age: 18, class: '三年二班' },
        { id: 2, name: '李四', age: 19, class: '三年二班' },
        { id: 3, name: '王五', age: 18, class: '三年一班' }
      ],
      dialogVisible: false,
      isEdit: false,
      form: {
        id: null,
        name: '',
        age: '',
        class: ''
      },
      searchKeyword: ''
    }
  },
  computed: {
    dialogTitle() {
      return this.isEdit ? '编辑学生' : '新增学生'
    },
    // 通过搜索关键词过滤后的表格数据
    filteredTableData() {
      if (!this.searchKeyword) return this.tableData
      const keyword = this.searchKeyword.toLowerCase()
      return this.tableData.filter((item) =>
        // 通过 Object.values(item) 获取对象的所有值，然后连接成一个字符串
        Object.values(item).join('').toLowerCase().includes(keyword)
      )
    }
  },
  methods: {
    handleAdd() {
      // TODO: 重置表单，打开弹窗
      this.isEdit = false
      this.form = { id: null, name: '', age: '', class: '' }
      this.dialogVisible = true
    },
    handleEdit(row) {
      // TODO: 回显数据，打开弹窗
      this.isEdit = true
      // 使用展开运算符复制对象，避免直接引用修改
      this.form = { ...row }
      this.dialogVisible = true
    },
    handleDelete(row) {
      // TODO: 调用删除接口，刷新列表
      this.$confirm('确认删除该学生吗?', '提示', {
        type: 'warning'
      })
        .then(() => {
          console.log('Deleting:', row)
          this.$message.success('删除成功')
          // 模拟删除
          this.tableData = this.tableData.filter((item) => item.id !== row.id)
        })
        .catch(() => {})
    },
    handleSave() {
      // TODO: 调用保存/更新接口，关闭弹窗，刷新列表
      console.log('Saving:', this.form)
      if (this.isEdit) {
        // 模拟更新
        const index = this.tableData.findIndex(
          (item) => item.id === this.form.id
        )
        if (index !== -1) {
          // Vue 2 数组更新注意事项：splice 是响应式的
          this.tableData.splice(index, 1, { ...this.form })
        }
      } else {
        // 模拟新增
        // 学习点：模拟数据库自增 ID
        const maxId =
          this.tableData.length > 0
            ? Math.max(...this.tableData.map((item) => item.id))
            : 0
        this.form.id = maxId + 1
        this.tableData.push({ ...this.form })
      }
      this.dialogVisible = false
      this.$message.success('保存成功 (模拟)')
    }
  }
}
</script>

<style scoped>
.actions {
  margin-bottom: 20px;
}
.search-input {
  width: 200px;
  margin-right: 10px;
}
</style>
