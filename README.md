# 色彩消除大挑战 (Color Crush Challenge)

一款休闲益智类游戏，玩家通过匹配相同颜色的方块来消除并获得分数。

## 游戏特色

- 🎯 简单易学，老少皆宜
- 🌈 丰富多彩的游戏体验
- 🏆 全球排行榜竞争
- 👥 好友挑战模式
- 🎮 100+精心设计的关卡

## 技术栈

- **游戏引擎**: Godot 3.5.2
- **编程语言**: GDScript
- **目标平台**: Android, iOS, Web

## 本地开发

### 环境要求

- Godot Engine 3.5.2 或更高版本
- GDScript 基础知识

### 开发设置

1. 克隆仓库：
   ```bash
   git clone https://github.com/davard123/color-crush-challenge.git
   ```

2. 在 Godot 编辑器中打开 `project.godot` 文件

3. 运行项目进行测试

### 项目结构

```
├── scenes/           # 游戏场景
│   ├── main_menu/    # 主菜单场景
│   ├── game/         # 游戏主场景
│   ├── level_select/ # 关卡选择场景
│   └── settings/     # 设置场景
├── scripts/          # 游戏逻辑脚本
│   ├── core/         # 核心游戏逻辑
│   ├── ui/           # 用户界面逻辑
│   └── managers/     # 管理器脚本
├── assets/           # 游戏资源
│   ├── sprites/      # 图像资源
│   ├── audio/        # 音频资源
│   └── fonts/        # 字体资源
├── levels/           # 关卡数据
├── export_presets.cfg # 导出配置
└── project.godot     # Godot项目文件
```

## 构建与部署

### Web版本

使用以下命令构建Web版本：

```bash
# 确保已安装Godot引擎
godot --export "HTML5" ./export/index.html --no-window
```

### Android版本

1. 在Godot编辑器中打开项目
2. 转到"项目" → "导出"
3. 选择"Android"导出模板
4. 配置必要设置（证书、签名等）
5. 点击"导出项目"

### iOS版本

1. 在Godot编辑器中打开项目
2. 转到"项目" → "导出"
3. 选择"iOS"导出模板
4. 配置必要设置（证书、Bundle ID等）
5. 点击"导出项目"

## 游戏机制

### 核心玩法

- 交换相邻方块位置
- 匹配3个或以上相同颜色方块来消除
- 达成关卡目标获得高分

### 特殊方块

- **火箭**: 消除一整行或列的所有方块
- **炸弹**: 消除周围3x3区域的所有方块
- **彩虹球**: 可以与任何颜色匹配

### 障碍物

- **冰层**: 需要多次消除才能打破
- **锁**: 需要匹配特定颜色才能打开
- **石头**: 需要特殊方块才能清除

## 商业化

游戏采用免费增值模式：
- 通过广告获得收入
- 提供去除广告的内购选项
- 提供游戏内增强道具

## 贡献

欢迎贡献代码！请遵循以下步骤：

1. Fork 仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 联系方式

项目链接: [https://github.com/davard123/color-crush-challenge](https://github.com/davard123/color-crush-challenge)

## 构建状态

![Godot Build](https://github.com/davard123/color-crush-challenge/actions/workflows/godot_build.yml/badge.svg)

此项目已配置 GitHub Actions，当推送到 main 分支时会自动构建 Web 版本并部署到 GitHub Pages。