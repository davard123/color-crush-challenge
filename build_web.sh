# 构建Godot项目为Web版本的脚本

echo "开始构建色彩消除大挑战Web版本..."

# 检查Godot是否已安装
if ! command -v godot &> /dev/null
then
    echo "错误: Godot引擎未安装"
    echo "请先安装Godot 3.5或更高版本"
    exit 1
fi

echo "Godot引擎已找到，版本:"
godot --version

# 创建导出目录
mkdir -p ./export

# 导出为HTML5版本
echo "正在导出HTML5版本..."
godot --export "HTML5" ./export/index.html --no-window

if [ $? -eq 0 ]; then
    echo "Web版本构建成功！"
    echo "文件位置: ./export/"
    echo "要预览游戏，请使用HTTP服务器运行，例如："
    echo "  python -m http.server 8000 或"
    echo "  npx serve ./export"
else
    echo "构建失败"
    exit 1
fi