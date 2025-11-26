#!/usr/bin/env sh

# 发生错误时终止
set -e

# 构建项目
echo "🔨 开始构建项目..."
npm run build

# 进入构建输出目录
cd dist

# 初始化 git 仓库(如果需要)
echo "📦 准备部署到 GitHub Pages..."
git init
git add -A
git commit -m 'deploy'

# 推送到 GitHub Pages 分支
# 请将 <USERNAME> 替换为你的 GitHub 用户名
echo "🚀 推送到 gh-pages 分支..."
git push -f git@github.com:Mr-CG-end/StudentList-vue2.git master:gh-pages

cd -

echo "✅ 部署完成!"
echo "📌 请访问: https://Mr-CG-end.github.io/StudentList-vue2/"
