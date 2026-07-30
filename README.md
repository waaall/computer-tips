# computer-tips

个人计算机、操作系统、开发板、服务器与常用工具的实践笔记。

> 本目录收录 40 篇知识笔记；`README.md` 与仓库维护用 skill 不计入知识条目。

## 快速导航

### 操作系统与硬件

- [Linux tips](Linux-tips.md)
- [Windows tips](Windows-tips.md)
- [Mac tips](Mac-tips.md)
- [NVIDIA 进阶](Nvidia进阶.md)
- [折腾服务器](折腾服务器.md)

### Unix / Linux 专题

- [磁盘问题](Unix-tips.assets/磁盘问题.md)
- [RAID 进阶笔记](Unix-tips.assets/Raid进阶笔记.md)
- [libc](Unix-tips.assets/libc.md)
- [Linux GUI 图形栈技术](Unix-tips.assets/Linux-GUI图形栈技术.md)
- [NVIDIA 驱动更新冲突日志](Unix-tips.assets/Nvidia驱动更新冲突日志.md)
- [Mermaid 画图](Unix-tips.assets/mermaid画图.md)

### 服务器专题

- [Dell PowerEdge T640 RAID 日志](折腾服务器.assets/dell-PowerEdge-T640-raid-log.md)
- [Dell 服务器风扇问题](折腾服务器.assets/dell服务器风扇问题.md)

### 开发板

- [树莓派安装 Ubuntu Server](computer杂谈/树莓派安装Ubuntu%20server.md)
- [Raspberry Pi 从 SSD 启动](折腾开发版/RaspberryPi-SSD启动.md)
- [Tinker Board 学习记录](折腾开发版/learn-tinker-board.md)

### 计算机杂谈

- [Apps 开发模式](computer杂谈/Apps开发模式.md)
- [mac 日常瞎搞](computer杂谈/mac日常瞎搞.md)
- [QQ / TIM 默认浏览器](computer杂谈/qqORtim默认浏览器.md)
- [Whisper 语音转文字](computer杂谈/whisper%20语音转文字.md)
- [关于“中断过程切换上下文”的浅思](computer杂谈/关于“中断过程切换上下文”的浅思.md)
- [关于接口那些事](computer杂谈/关于接口那些事.md)
- [关于视频](computer杂谈/关于视频.md)
- [如何成为钢铁侠](computer杂谈/如何成为钢铁侠.md)
- [手机中的科学](computer杂谈/手机中的科学.md)
- [文献整理](computer杂谈/文献整理.md)
- [智能家居新玩法之互动 AR](computer杂谈/智能家居新玩法之互动AR.md)
- [浅谈网络](computer杂谈/浅谈网络.md)
- [系统是怎么运行我的代码的](computer杂谈/系统是怎么运行我的代码的.md)
- [计算机底层设计](computer杂谈/计算机底层设计.md)

### 网络工具

- [小飞机总述](小飞机/小飞机总述.md)
- [SS、SSR、V2Ray、Trojan、Xray](小飞机/小飞机介绍/SS、SSR、V2ray、Trojan、Xray.md)
- [Shadowsocks 的前世今生](小飞机/小飞机介绍/Shadowsocks%20的前世今生.md)
- [V2Ray 客户端](小飞机/小飞机介绍/V2Ray客户端.md)
- [Shadowrocket 规则](小飞机/小飞机设置/Shadowrocket规则.md)
- [Xray 教程](小飞机/小飞机设置/Xray教程.md)
- [Clash Verge 规则](小飞机/小飞机设置/clash-verge规则.md)
- [v2rayA 设置](小飞机/小飞机设置/v2rayA设置.md)

### 配置文件

- [配置文件说明](cofig-files/conf-README.md)
- [Claude 项目偏好示例](cofig-files/CLAUDE.md)

## 仓库约定

- `*.assets/` 保存正文引用的图片、附件和专题补充笔记。
- `cofig-files/` 是历史沿用的目录名，里面的配置带有个人环境假设，使用前请检查路径和版本。
- 本机私有设置不进入版本控制；新增附件后应确保至少有一篇 Markdown 引用它。

## 内容检查

本地运行：

```bash
python scripts/check_markdown_links.py
```

该脚本检查 Markdown 本地链接、空链接、`(null)` 链接和越出仓库的路径。GitHub Actions 会在 push 和 pull request 时自动执行同一检查；外部网站可用性不在检查范围内。

## 许可证

本仓库当前未设置开源许可证。除非具体文件另有说明，仓库内容不授予复制、修改或再发布许可；如需复用，请先联系作者。
