module.exports = {
  // 部署时的基础路径
  // 开发环境: /
  // 生产环境(GitHub Pages): /仓库名/
  publicPath:
    process.env.NODE_ENV === 'production' ? '/StudentList-vue2/' : '/',

  // 输出目录
  outputDir: 'dist',

  // 静态资源目录
  assetsDir: 'static',

  // 生产环境是否生成 sourceMap
  productionSourceMap: false,

  // 开发服务器配置
  devServer: {
    port: 8080,
    open: true
  }
}
