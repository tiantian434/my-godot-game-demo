# Godot 完整游戏 Demo

## 项目简介
使用 Godot 4.6 + GDScript **独立跟随网络视频教程**完成的**可完整运行**的2D像素/俯视角类型动作游戏Demo。
教程内容本身规范完整，我把整个项目从头到尾全部实现达到了**全游戏循环**（主菜单 → 关卡 → 结束界面）

## 核心工程体系
- **游戏管理系统**：场景切换 + 事件总线/Signal系统
- **角色状态机系统**：角色基类 + 各状态单独脚本 + 主状态机脚本 + debug模式
- **UI管理系统**: UI显示/切换 + 按键转换 + shader/theme文件
  
## 自主Debug & 优化（我独立完成的部分）
- 解决隔墙检测问题(使用RayCast2D射线检测)
- 解决area2D_entered信号状态触发问题(get_overlapping_areas函数定期检测玩家碰撞箱)
- 增加游戏结束画面和回到主界面按钮

## 技术栈
- Godot 4.x + GDScript
- Scene Tree、Signal系统、AnimationPlayer、TileMap 等
- 通过完整项目深入理解了Godot引擎架构与事件驱动机制
- 
## 如何运行(windows)
1. 下载仓库
2. 双击IRIS.exe
3. 直接运行

演示视频：https://pan.quark.cn/s/c745a435e26b
