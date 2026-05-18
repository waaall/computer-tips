
## 0. 总览：从下到上有哪些层？

```text
┌──────────────────────────────────────────────┐
│ 应用层 Application                            │
│ Firefox, VS Code, Terminal, Blender, Games    │
├──────────────────────────────────────────────┤
│ GUI Toolkit / 应用框架                         │
│ GTK, Qt, Electron, SDL, GLFW, wxWidgets       │
├──────────────────────────────────────────────┤
│ 桌面环境 / Shell / 窗口管理 / 合成器            │
│ GNOME Shell/Mutter, KDE Plasma/KWin,          │
│ XFCE, Cinnamon, Sway, Hyprland, Weston        │
├──────────────────────────────────────────────┤
│ 显示协议 / 显示服务器                          │
│ Wayland compositor 或 X.Org Server            │
│ XWayland 作为 X11 兼容层                       │
├──────────────────────────────────────────────┤
│ 用户态图形库 / 3D API / 缓冲区协商              │
│ Mesa, libGL, EGL, Vulkan loader, GBM, libdrm  │
├──────────────────────────────────────────────┤
│ 会话 / 登录 / 设备权限                         │
│ systemd-logind, PAM, D-Bus, udev              │
├──────────────────────────────────────────────┤
│ 内核图形与输入子系统                           │
│ DRM, KMS, GEM/TTM, evdev, hid, input          │
├──────────────────────────────────────────────┤
│ 硬件与内核驱动                                │
│ GPU: i915, amdgpu, nouveau, nvidia            │
│ Input: USB HID, Bluetooth HID, touchpad 等     │
└──────────────────────────────────────────────┘
```

最核心的分界线是：

|组件|属于哪一层|一句话解释|
|---|---|---|
|GDM3 / GDM|Display Manager，显示管理器 / 登录管理器层|负责图形登录、启动用户图形会话|
|LightDM|Display Manager 层|桌面无关的登录管理器，常配不同 greeter|
|GNOME|Desktop Environment，桌面环境层|包含 Shell、设置、文件管理器、会话服务等|
|GNOME Shell|Shell + Wayland compositor / X11 window manager 层|在 GNOME 中负责桌面界面、窗口合成、扩展|
|Mutter|Compositor / Window Manager 层|GNOME Shell 背后的窗口管理器和 Wayland 合成器|
|KDE Plasma|Desktop Environment 层|KDE 桌面环境|
|KWin|Compositor / Window Manager 层|KDE 的窗口管理器和 Wayland 合成器|
|X.Org / Xorg|Display Server 层|传统 X11 显示服务器|
|Wayland|Display Protocol，显示协议|协议本身；真正的服务器通常是 compositor|
|Weston|Wayland Compositor 层|Wayland 官方参考合成器|
|Mesa|用户态图形驱动 / OpenGL/Vulkan 实现层|实现 OpenGL、Vulkan、EGL、Gallium 等|
|DRM/KMS|Linux 内核图形子系统层|管 GPU 设备、显存、显示输出、模式设置|
|libinput|用户态输入处理库|给 compositor/Xorg 处理键盘、鼠标、触控板事件|
|evdev / input subsystem|内核输入子系统层|把硬件输入事件暴露给用户态|

Wayland 官方文档明确说：Wayland 是客户端和显示服务器通信的协议，而 Wayland server 通常称为 compositor；应用是 Wayland clients。Wayland 架构中，compositor 直接接管 KMS 和 evdev，输入事件从内核到 compositor，再到应用。 

---

# 1. 启动链路：从开机到桌面

典型 GNOME + Wayland 登录流程：

```text
systemd
  ↓
display-manager.service
  ↓
gdm / gdm3
  ↓
GDM greeter 登录界面
  ↓  用户输入密码
PAM 认证 + systemd-logind 注册 session
  ↓
选择 session：GNOME / GNOME on Xorg / KDE / XFCE ...
  ↓
启动用户会话：
  - Wayland: gnome-shell/mutter 作为 Wayland compositor
  - X11: Xorg + gnome-shell/mutter 作为 X11 window manager/compositor
  ↓
应用启动
  ↓
GTK/Qt/Electron/SDL
  ↓
Wayland protocol 或 X11 protocol
  ↓
compositor / Xorg
  ↓
Mesa / EGL / Vulkan / libdrm
  ↓
kernel DRM/KMS + GPU driver
  ↓
显示器
```

这里有几个关键点：

1. GDM/LightDM 不等于 GNOME/KDE/XFCE。  
    它们只是“登录入口”和“会话启动器”。你可以用 GDM 启动 KDE，也可以用 LightDM 启动 GNOME，只是各发行版通常有默认搭配。
2. GNOME 不只是一个窗口管理器。  
    GNOME 是桌面环境，里面有 GNOME Shell、Mutter、Settings、Files、Session Manager、Settings Daemon、Keyring 等一堆组件。
3. Wayland 下没有传统意义上单独的 display server + window manager 组合。  
    Wayland 世界里，compositor 本身就是 display server。GNOME 的 Mutter、KDE 的 KWin、Sway、Hyprland 都可以是 Wayland compositor。Wayland 官方文档也强调：“In Wayland the compositor is the display server”。 

---

# 2. Display Manager 层：GDM3、LightDM、SDDM 是什么？

## 2.1 Display Manager 的职责

Display Manager，显示管理器，也常被叫登录管理器，主要负责：

```text
启动图形登录界面
管理 seat / session
调用 PAM 做认证
让用户选择桌面会话
启动 Xorg 或 Wayland compositor
注册 systemd-logind session
处理自动登录、多用户切换、锁屏衔接等
```

GNOME 的文档和发行版资料通常把 GDM 描述为管理图形显示服务器并处理图形登录的程序。  
systemd 的文档则说明，现代 display manager 通常会和 systemd-logind 协作，以获得多 seat、session 跟踪、设备权限管理等能力。 

## 2.2 GDM / GDM3

GDM 是 GNOME Display Manager。Debian/Ubuntu 系里包名常见为 gdm3，本质上就是 GNOME 的显示管理器。

它属于：

```text
Display Manager / Login Manager 层
```

GDM 的典型特点：

|特性|说明|
|---|---|
|和 GNOME 集成深|登录界面本身通常也使用 GNOME Shell 技术|
|支持 Wayland / Xorg|可以启动 GNOME Wayland 或 GNOME on Xorg|
|和 systemd-logind 集成|管理 seat、session、用户切换|
|通常是 GNOME 默认 DM|Fedora、Ubuntu GNOME 等常见|

RHEL/Fedora 文档中可以看到 GDM 配置可控制 GNOME 使用 Wayland 或 Xorg，比如 `WaylandEnable=false` 会让 GDM 使用 Xorg 路径。 

## 2.3 LightDM

LightDM 也是 Display Manager，但设计目标更“桌面无关”。

它属于：

```text
Display Manager / Login Manager 层
```

LightDM 的结构更像：

```text
lightdm daemon
  ↓
greeter
  ↓
用户认证
  ↓
启动 session
```

greeter 是登录界面前端，比如：

|Greeter|常见场景|
|---|---|
|`lightdm-gtk-greeter`|XFCE、轻量桌面|
|`slick-greeter`|Linux Mint|
|`unity-greeter`|老 Ubuntu Unity|
|WebKit greeter|可高度定制的登录界面|

LightDM 文档和社区资料通常把 greeter 定义为提示用户输入凭据、选择会话的 GUI。 

## 2.4 SDDM

SDDM 是 Simple Desktop Display Manager，常见于 KDE Plasma。

属于：

```text
Display Manager / Login Manager 层
```

常见搭配：

|桌面环境|常见 Display Manager|
|---|---|
|GNOME|GDM / GDM3|
|KDE Plasma|SDDM|
|XFCE|LightDM|
|Cinnamon|LightDM / Slick Greeter|
|LXQt|SDDM / LightDM|
|i3/Sway|LightDM、GDM、SDDM、直接 startx 或 greetd|

## 2.5 greetd

现代轻量方案里还有 greetd。

它也是：

```text
Display Manager / Login Manager 层
```

常被 Wayland 窗口管理器用户使用，例如 Sway、Hyprland 场景。它可以配 `tuigreet`、`gtkgreet`、`regreet` 等登录界面。

---

# 3. Desktop Environment 层：GNOME 类似的有哪些？

## 3.1 Desktop Environment 是什么？

Desktop Environment，桌面环境，是一整套用户桌面体验，不只是“窗口边框”。

它通常包括：

```text
Shell / Panel / Dock
Window Manager / Compositor
Session Manager
Settings Daemon
File Manager
Settings App
Notification Daemon
Power Manager
Screensaver / Lock Screen
Clipboard / Portal / Keyring
Theme / Icon / Font stack
```

## 3.2 GNOME

GNOME 属于：

```text
Desktop Environment 层
```

核心组件大致是：

|组件|层级|作用|
|---|---|---|
|GNOME Shell|Shell + Compositor UI|顶栏、Overview、扩展、桌面交互|
|Mutter|Window Manager / Wayland Compositor|窗口管理、合成、显示输出|
|gnome-session|Session Manager|启动和管理 GNOME 会话|
|gnome-settings-daemon|后台设置服务|键盘、显示、电源、主题等|
|Nautilus / Files|应用层|文件管理器|
|GNOME Control Center|应用层|设置面板|
|GDM|Display Manager 层|登录管理器，不是 GNOME 桌面本体但同项目强相关|

在 Wayland GNOME 中：

```text
应用 → Wayland → Mutter/GNOME Shell → KMS/DRM → GPU
```

在 X11 GNOME 中：

```text
应用 → X11 → Xorg → Mutter/GNOME Shell 作为 WM/Compositor → DRM/KMS → GPU
```

## 3.3 KDE Plasma

KDE Plasma 属于：

```text
Desktop Environment 层
```

关键组件：

|组件|作用|
|---|---|
|Plasma Shell|桌面、面板、小组件|
|KWin|Window Manager + Wayland Compositor|
|KDE Frameworks|KDE 应用基础库|
|Dolphin|文件管理器|
|System Settings|设置中心|
|SDDM|常见登录管理器|

Wayland 下 KWin 类似 GNOME Mutter，是 display server + compositor。

## 3.4 XFCE

XFCE 属于：

```text
Desktop Environment 层
```

偏轻量，传统上 X11 生态更成熟。典型组件：

|组件|作用|
|---|---|
|xfwm4|Window Manager / Compositor|
|xfce4-panel|面板|
|Thunar|文件管理器|
|xfsettingsd|设置守护进程|
|LightDM|常见登录管理器|

## 3.5 Cinnamon

Linux Mint 主推的桌面环境。

|组件|作用|
|---|---|
|Cinnamon Shell|桌面 Shell|
|Muffin|Window Manager，源自 Mutter|
|Nemo|文件管理器|
|Slick Greeter / LightDM|常见登录管理器|

## 3.6 LXQt / MATE / Budgie

|桌面|特点|
|---|---|
|LXQt|Qt 技术栈，轻量|
|MATE|GNOME 2 风格延续|
|Budgie|现代桌面 Shell，常搭配 GNOME 技术|

## 3.7 不是完整桌面环境的东西

|类型|例子|说明|
|---|---|---|
|X11 Window Manager|i3, Openbox, Awesome, bspwm, Fluxbox|主要管窗口，不提供完整桌面服务|
|Wayland Compositor|Sway, Hyprland, river, Wayfire, Weston|在 Wayland 下既是 compositor 又是 display server|
|Shell|GNOME Shell, Plasma Shell|桌面交互层|
|Panel / Bar|waybar, polybar|状态栏，不是完整 DE|

---

# 4. 显示协议层：X11 vs Wayland

## 4.1 X11 / X.Org

X11 是传统显示协议，X.Org Server 是最常见实现。

X11 经典模型：

```text
应用
  ↓ Xlib / XCB / toolkit
X11 protocol
  ↓
Xorg Server
  ↓
Window Manager
  ↓
Compositor
  ↓
DRM/KMS / GPU
```

但这个图有点“历史负担”。在传统 X11 中：

|组件|作用|
|---|---|
|Xorg Server|接收应用绘图请求、管理输入输出|
|Window Manager|管窗口位置、焦点、装饰|
|Compositor|做透明、阴影、动画、合成|
|DDX driver|Xorg 内部硬件相关层|
|GLX|OpenGL 与 X11 集成|
|DRI|Direct Rendering Infrastructure，直接渲染基础设施|

X.Org 文档里有 DDX、DIX、X server、driver 等开发文档，DDX 是 Xorg server 内部硬件相关的一层。 

现代 Xorg 的 OpenGL 渲染通常不是“所有东西都由 X server 画”。应用可以通过 DRI/Mesa 直接渲染到 buffer，然后 Xorg/compositor 负责显示和合成。

## 4.2 Wayland

Wayland 是协议，不是单独进程名。Wayland 官方说它是应用和 display server 通信的语言；Wayland server 叫 compositor。 

Wayland 模型：

```text
应用
  ↓ GTK / Qt / SDL / EGL
Wayland protocol
  ↓
Wayland compositor
  ↓
DRM/KMS + libinput + Mesa
  ↓
GPU / display / input devices
```

Wayland 的设计思路是：

|X11 旧模型|Wayland 新模型|
|---|---|
|X server 是中心|Compositor 是中心|
|Window Manager 可单独替换|Compositor 通常包含 WM 逻辑|
|输入先到 X server|输入到 compositor，再分发给 client|
|绘制历史复杂|应用自己渲染 buffer，compositor 合成|
|安全边界较弱|默认更隔离，屏幕录制/全局输入需 portal/权限|

Wayland 协议本身不负责“画图”。应用把像素画进 buffer，交给 compositor。LWN 对现代 Linux 图形栈的解释也强调，Wayland surface 代表应用窗口，buffer 中包含可显示的像素数据。 

## 4.3 XWayland

XWayland 是兼容层：

```text
X11 应用
  ↓
XWayland
  ↓
Wayland compositor
  ↓
DRM/KMS
```

它让老 X11 应用跑在 Wayland 会话中。比如你在 GNOME Wayland 下打开一个还不支持 Wayland 的老应用，它可能实际跑在 XWayland 上。

---

# 5. Compositor / Window Manager 层

这是最容易混淆的一层。

## 5.1 X11 世界

X11 下通常分开：

```text
Xorg Server
Window Manager
Compositor
```

例子：

|类型|例子|
|---|---|
|Window Manager|i3, Openbox, Fluxbox, xfwm4|
|Compositor|picom, compton|
|WM + Compositor|Mutter, KWin, Compiz|

X11 下你可以：

```text
Xorg + i3 + picom
Xorg + Openbox + picom
Xorg + xfwm4
Xorg + Mutter
```

## 5.2 Wayland 世界

Wayland 下 compositor 是核心：

```text
Wayland compositor = display server + compositor + window manager
```

例子：

|Wayland Compositor|风格|
|---|---|
|Mutter|GNOME|
|KWin|KDE Plasma|
|Sway|i3 风格，wlroots|
|Hyprland|动态平铺，动画强|
|river|动态平铺|
|Wayfire|3D/特效风格|
|Weston|参考实现|
|labwc|Openbox 风格|
|cage|kiosk 单应用场景|

## 5.3 wlroots 是什么？

wlroots 是一个 Wayland compositor 开发库，不是桌面环境，也不是 display manager。

它给 Sway、river、Wayfire、labwc 等 compositor 提供底层能力：

```text
DRM/KMS backend
libinput backend
Wayland protocol implementation helpers
XWayland integration
output management
buffer handling
```

所以：

```text
Sway / Hyprland / river
  ↓ 使用
wlroots
  ↓ 使用
libinput / DRM / GBM / EGL / Wayland protocols
```

注意：Hyprland 早期使用 wlroots，后来维护自己的 Aquamarine 等相关组件，具体实现随版本变化较快，查具体版本源码更靠谱。

---

# 6. 用户态图形驱动层：Mesa、EGL、OpenGL、Vulkan、GBM、libdrm

这层是图形栈的“齿轮箱”。

## 6.1 Mesa 是什么？

Mesa 是开源图形库集合，提供 OpenGL、OpenGL ES、EGL、Vulkan 驱动等实现。Mesa 官网列出了 Intel ANV、Iris、AMD RADV、Panfrost、Zink、VirGL、Venus 等驱动或 layered drivers。 

Mesa 大致包括：

|组件|作用|
|---|---|
|OpenGL 实现|`libGL`, `libGLES`|
|EGL|连接渲染 API 和窗口系统|
|Vulkan drivers|RADV, ANV, Turnip, Venus 等|
|Gallium3D|Mesa 内部驱动框架|
|GBM|Generic Buffer Management，常用于 Wayland/KMS buffer|
|shader compiler|NIR、ACO、LLVMpipe 等相关|
|software rasterizer|llvmpipe, softpipe|

## 6.2 OpenGL 路径

Wayland 下一个 GTK/Qt OpenGL 应用可能是：

```text
App
  ↓
GTK/Qt
  ↓
EGL
  ↓
Mesa OpenGL driver
  ↓
DRM render node / GPU kernel driver
  ↓
生成 buffer
  ↓
Wayland compositor
  ↓
KMS scanout 或合成
```

X11 下可能是：

```text
App
  ↓
GLX / EGL
  ↓
Mesa
  ↓
DRI
  ↓
Xorg / compositor
  ↓
DRM/KMS
```

## 6.3 Vulkan 路径

Vulkan 更显式：

```text
App / Game Engine
  ↓
Vulkan loader
  ↓
ICD: RADV / ANV / NVIDIA / AMDVLK ...
  ↓
GPU kernel driver
  ↓
swapchain image
  ↓
Wayland/X11 WSI
  ↓
compositor / Xorg
```

## 6.4 libdrm

`libdrm` 是用户态访问内核 DRM API 的库。Compositor、Mesa、Xorg 等都会在不同路径上间接或直接使用它。

## 6.5 GBM vs EGLStreams

Wayland compositor 需要和 GPU 驱动交换 buffer。常见机制：

|机制|说明|
|---|---|
|GBM|Mesa/DRM 生态常用，AMD/Intel 开源驱动主流|
|EGLStreams|NVIDIA 曾长期主推的路径|
|DMA-BUF|跨设备/跨进程共享 buffer 的关键机制|

现在 NVIDIA Wayland 支持已经比早年成熟许多，但具体体验仍受驱动版本、发行版、compositor 支持影响。

---

# 7. 内核图形层：DRM、KMS、GEM/TTM、fbdev

## 7.1 DRM

DRM 是 Direct Rendering Manager，不是数字版权管理那个 DRM，在 Linux 图形栈里它是内核 GPU 子系统。

Linux kernel DRM 文档说明 DRM tree 涵盖输出配置、mode setting、vblank、内存管理等功能。 

DRM 负责：

```text
GPU 设备抽象
权限与 master 管理
buffer / 显存管理
command submission
同步 fence
显示输出对象
```

常见设备节点：

```bash
/dev/dri/card0       # primary node，显示控制等
/dev/dri/renderD128  # render node，给 3D 渲染用，通常不需要 DRM master
```

## 7.2 KMS

KMS 是 Kernel Mode Setting。

它负责：

```text
设置分辨率
刷新率
显示模式
显示器输出
CRTC / encoder / connector / plane
page flip
vblank
```

Wayland compositor 通常直接使用 KMS 控制显示输出。

## 7.3 GEM / TTM

显存和 buffer 管理：

|组件|作用|
|---|---|
|GEM|Graphics Execution Manager，Intel 起源，很多 DRM 驱动使用|
|TTM|Translation Table Maps，显存管理框架，常见于 AMD/Nouveau 等|
|DMA-BUF|跨驱动/进程共享 buffer|
|PRIME|多 GPU buffer sharing / offload 相关|

## 7.4 fbdev

老的 framebuffer 接口：

```text
/dev/fb0
```

现代桌面 GUI 主要走 DRM/KMS，但启动早期、简单嵌入式、兼容场景仍可能见到 fbdev。

---

# 8. 显卡驱动属于哪一层？

显卡驱动其实分两半：

```text
用户态驱动 + 内核态驱动
```

## 8.1 开源 AMD 路径

```text
应用
  ↓
Mesa: RADV / RadeonSI
  ↓
libdrm_amdgpu
  ↓
kernel: amdgpu
  ↓
AMD GPU
```

|层|组件|
|---|---|
|Vulkan 用户态驱动|RADV / AMDVLK|
|OpenGL 用户态驱动|RadeonSI|
|内核驱动|amdgpu|
|固件|linux-firmware 中的 AMD firmware|

## 8.2 开源 Intel 路径

```text
应用
  ↓
Mesa: ANV / Iris
  ↓
kernel: i915 或 xe
  ↓
Intel GPU
```

|层|组件|
|---|---|
|Vulkan 用户态驱动|ANV|
|OpenGL 用户态驱动|Iris / Crocus|
|内核驱动|i915，较新硬件也有 xe|
|显示|DRM/KMS|

Mesa 官网说明 ANV 是 Intel Gen7+ 的 Vulkan 驱动，Iris 是 Intel Gen8+ 的新一代 Linux OpenGL 驱动。 

## 8.3 NVIDIA 路径

NVIDIA 比较特殊：

|类型|组件|
|---|---|
|专有用户态驱动|NVIDIA OpenGL/Vulkan/EGL libraries|
|专有/开放内核模块|`nvidia`, `nvidia_drm`, `nvidia_modeset`|
|开源 Nouveau|Mesa Nouveau/NVK + kernel nouveau|
|Wayland 关键|GBM/EGL、explicit sync、KMS 支持等|

NVIDIA 不是主要走 Mesa 的 OpenGL/Vulkan 驱动，除非你用 nouveau/NVK 这类开源路线。

## 8.4 软件渲染

没有 GPU 加速时：

```text
应用
  ↓
Mesa llvmpipe / softpipe
  ↓
CPU 渲染
  ↓
compositor / Xorg
```

`llvmpipe` 常用于虚拟机、CI、fallback 场景。

---

# 9. 输入驱动和接口驱动属于哪一层？

你提到“接口驱动”，这里可以拆成输入设备接口、总线接口、显示接口。

## 9.1 输入硬件到应用

```text
键盘 / 鼠标 / 触控板 / 触摸屏
  ↓
USB / Bluetooth / I2C / PS/2
  ↓
kernel driver: hid, usbhid, i2c-hid, atkbd...
  ↓
Linux input subsystem
  ↓
evdev: /dev/input/eventX
  ↓
libinput
  ↓
Wayland compositor 或 Xorg input driver
  ↓
应用
```

`libinput` 官方文档说明它是为 display server 等程序处理输入设备的库，提供设备检测、事件处理、触摸板指针事件、加速度等抽象。 

  

所以：

|组件|层级|
|---|---|
|USB HID / Bluetooth HID / I2C HID|内核硬件驱动层|
|input subsystem|内核输入子系统|
|evdev|内核到用户态事件接口|
|libinput|用户态输入抽象库|
|xf86-input-libinput|Xorg 输入驱动|
|compositor 内部 input handling|Wayland compositor 层|

## 9.2 显示接口

显示接口如 HDMI、DisplayPort、eDP、LVDS、USB-C DP Alt Mode，通常由 GPU 内核驱动通过 DRM/KMS 暴露。

```text
显示器
  ↓
HDMI / DP / eDP
  ↓
GPU display engine
  ↓
kernel GPU driver
  ↓
DRM connector / encoder / CRTC / plane
  ↓
KMS
  ↓
compositor
```

常见命令：

```bash
cat /sys/class/drm/card0-*/status
modetest
drm_info
```

---

# 10. systemd-logind、PAM、D-Bus、udev 在 GUI 里干嘛？

这些不是“画图”的组件，但现代桌面离不开它们。

## 10.1 systemd-logind

属于：

```text
会话 / seat / 设备权限管理层
```

它负责：

```text
用户登录 session
seat 管理
active session 切换
电源键/合盖/休眠
设备访问权限
多用户切换
```

systemd 官方文档说 `systemd-logind` 是管理用户登录的系统服务；session 通常通过 `pam_systemd` 注册。 

Display Manager 会和 logind 配合。例如 systemd 的 display manager 编写文档提到 logind 带来自动 multi-seat、session process tracking 等能力。 

## 10.2 PAM

PAM 属于认证层：

```text
Display Manager
  ↓
PAM
  ↓
密码 / 指纹 / smartcard / LDAP / Kerberos / systemd-homed
```

GDM、LightDM、SDDM 都会通过 PAM 做用户认证。

## 10.3 D-Bus

D-Bus 是进程间通信总线。

桌面里大量服务靠它沟通：

```text
Settings
Notifications
NetworkManager
Bluetooth
Power management
Portals
Secret Service
Screensaver / lock
```

## 10.4 udev

udev 管设备发现和权限规则：

```text
新插入鼠标
  ↓
kernel event
  ↓
udev
  ↓
创建设备节点 /dev/input/eventX
  ↓
logind / compositor / libinput 看到设备
```

---

# 11. GUI Toolkit 层：GTK、Qt、Electron、SDL

应用通常不直接调用 Wayland/X11，而是通过 toolkit。

## 11.1 GTK

GNOME 生态主力。

```text
GTK app
  ↓
GDK backend
  ↓
Wayland backend 或 X11 backend
  ↓
compositor / Xorg
```

常见应用：

```text
GNOME Files
GNOME Settings
GEdit/Text Editor
部分 Linux 原生工具
```

## 11.2 Qt

KDE 生态主力。

```text
Qt app
  ↓
QPA plugin
  ↓
wayland 或 xcb
  ↓
compositor / Xorg
```

常见应用：

```text
Dolphin
Krita
Kdenlive
Telegram Desktop
VirtualBox GUI
```

## 11.3 Electron / Chromium

```text
Electron app
  ↓
Chromium Ozone platform
  ↓
Wayland 或 X11
```

VS Code、Discord、Slack 等都在这类路径上。

## 11.4 SDL / GLFW

游戏和图形应用常见：

```text
Game
  ↓
SDL / GLFW
  ↓
Wayland / X11
  ↓
Vulkan / OpenGL
```

---

# 12. Portal、PipeWire、截图、屏幕共享

Wayland 加强了安全隔离后，一些以前 X11 下“随便读全屏”的能力不能直接做了。

所以现代桌面引入：

|组件|作用|
|---|---|
|xdg-desktop-portal|应用请求截图、文件选择、屏幕共享、打开 URI 等|
|xdg-desktop-portal-gnome|GNOME 后端|
|xdg-desktop-portal-kde|KDE 后端|
|xdg-desktop-portal-wlr|wlroots compositor 后端|
|PipeWire|屏幕共享、音视频流|
|WirePlumber|PipeWire session manager|

典型屏幕共享流程：

```text
浏览器 / Zoom / OBS
  ↓
xdg-desktop-portal
  ↓
桌面环境弹出授权 UI
  ↓
compositor 提供画面
  ↓
PipeWire stream
  ↓
应用接收视频帧
```

这也是为什么 Wayland 下屏幕录制、远程桌面、截图工具是否好用，常常取决于 portal + compositor + PipeWire 的配合。

---

# 13. 字体、主题、图标、输入法

这些常被忽略，但属于 GUI 体验核心。

## 13.1 字体栈

```text
应用
  ↓
Pango / HarfBuzz / FreeType / Fontconfig
  ↓
字体文件
```

|组件|作用|
|---|---|
|FreeType|字形栅格化|
|HarfBuzz|字形 shaping，复杂文字排版|
|Fontconfig|字体发现、匹配、fallback|
|Pango|GTK 常用文本布局|
|Qt text stack|Qt 自己的文本布局|

## 13.2 主题和图标

```text
GTK theme
Qt theme
icon theme
cursor theme
```

Wayland 下鼠标指针也有 compositor 参与，主题配置可能涉及：

```bash
~/.icons
~/.local/share/icons
/usr/share/icons
XCURSOR_THEME
XCURSOR_SIZE
```

## 13.3 输入法

中文输入法路径大致：

```text
应用
  ↓
GTK/Qt input method module
  ↓
IBus / Fcitx5
  ↓
Wayland text-input protocol / XIM / DBus
  ↓
应用收到文本
```

常见：

|框架|说明|
|---|---|
|IBus|GNOME 常见默认|
|Fcitx5|中文用户常用，Wayland 支持较好|
|XIM|老 X11 输入法协议|
|Wayland text-input / input-method protocols|Wayland 输入法相关协议，生态仍在演进|

---

# 14. 两条完整调用关系

## 14.1 GNOME Wayland：现代默认路径

```text
用户开机
  ↓
systemd 启动 gdm.service
  ↓
GDM 启动登录界面
  ↓
用户登录，PAM 认证
  ↓
systemd-logind 创建 user session
  ↓
gnome-session
  ↓
gnome-shell + mutter 作为 Wayland compositor
  ↓
应用启动，例如 Firefox
  ↓
Firefox 使用 GTK / Wayland / EGL
  ↓
Wayland protocol 提交 surface + buffer
  ↓
Mutter 接收输入、管理窗口、合成画面
  ↓
Mutter 使用 libinput 读取 /dev/input/eventX
  ↓
Mutter 使用 DRM/KMS 设置显示输出
  ↓
Mesa / GPU driver 渲染
  ↓
DRM page flip
  ↓
显示器
```

关键点：

```text
Mutter = Wayland display server + compositor + window manager
GDM = 登录入口，不是桌面本身
GNOME = 整套桌面环境
```

## 14.2 XFCE + LightDM + Xorg：传统轻量路径

```text
systemd
  ↓
lightdm
  ↓
lightdm-gtk-greeter
  ↓
PAM 认证
  ↓
启动 Xorg
  ↓
启动 xfce4-session
  ↓
xfwm4 管理窗口
  ↓
应用通过 GTK/Qt/Xlib/XCB 连接 Xorg
  ↓
Xorg 处理 X11 protocol
  ↓
Mesa/DRI 做 OpenGL
  ↓
DRM/KMS
  ↓
GPU / 显示器
```

关键点：

```text
LightDM = 登录管理器
Xorg = 显示服务器
xfwm4 = 窗口管理器
XFCE = 桌面环境
```

---

# 15. 常见组件归类速查表

|名称|类别|层级|
|---|---|---|
|GDM / gdm3|Display Manager|登录管理器|
|LightDM|Display Manager|登录管理器|
|SDDM|Display Manager|登录管理器|
|greetd|Display Manager|登录管理器|
|GNOME|Desktop Environment|桌面环境|
|KDE Plasma|Desktop Environment|桌面环境|
|XFCE|Desktop Environment|桌面环境|
|Cinnamon|Desktop Environment|桌面环境|
|MATE|Desktop Environment|桌面环境|
|GNOME Shell|Shell / Compositor frontend|桌面 Shell|
|Mutter|WM / Compositor|GNOME 窗口管理与合成|
|KWin|WM / Compositor|KDE 窗口管理与合成|
|i3|Window Manager|X11 平铺窗口管理器|
|Sway|Wayland Compositor|i3 风格 Wayland 合成器|
|Hyprland|Wayland Compositor|动态平铺合成器|
|Weston|Wayland Compositor|参考实现|
|Xorg|Display Server|X11 显示服务器|
|Wayland|Protocol|显示协议|
|XWayland|Compatibility Server|X11-on-Wayland|
|Mesa|Userspace graphics stack|OpenGL/Vulkan/EGL 驱动|
|libdrm|Userspace DRM library|访问内核 DRM|
|DRM|Kernel graphics subsystem|GPU 内核子系统|
|KMS|Kernel mode setting|显示模式设置|
|evdev|Kernel input interface|输入事件接口|
|libinput|Input library|用户态输入处理|
|systemd-logind|Session manager|seat/session/权限|
|D-Bus|IPC|桌面服务通信|
|PipeWire|Media graph|音频/视频/屏幕共享|
|xdg-desktop-portal|Permission broker|沙盒/Wayland 权限门户|
|GTK|GUI Toolkit|GNOME 应用框架|
|Qt|GUI Toolkit|KDE/跨平台应用框架|
|Electron|App runtime|Chromium-based 桌面应用|
|SDL / GLFW|App/game framework|游戏/图形应用框架|

---

# 16. 一句话分清几个高频混淆点

## GDM3 和 GNOME 是什么关系？

```text
GDM3 是登录管理器。
GNOME 是桌面环境。
GDM3 可以启动 GNOME，但 GDM3 不等于 GNOME。
```

## LightDM 和 GDM3 是同一类吗？

```text
是。它们都是 Display Manager。
区别是 GDM 偏 GNOME 集成，LightDM 偏桌面无关和轻量。
```

## GNOME 和 Mutter 是什么关系？

```text
GNOME 是整套桌面环境。
Mutter 是 GNOME 的窗口管理器 / Wayland compositor。
GNOME Shell 使用 Mutter 提供窗口管理和合成能力。
```

## Wayland 和 GNOME 是什么关系？

```text
Wayland 是协议。
GNOME 是桌面环境。
GNOME 的 Mutter 可以作为 Wayland compositor 实现这个协议。
```

## Xorg 和 Wayland 是同一层吗？

```text
大致是同一问题域：显示服务器/显示协议层。
但 Xorg 是一个显示服务器实现；Wayland 是协议，服务器通常是 compositor。
```

## 显卡驱动在哪一层？

```text
分两层：
用户态：Mesa / NVIDIA user-space driver / Vulkan ICD
内核态：amdgpu / i915 / xe / nouveau / nvidia_drm 等
```

## 输入驱动在哪一层？

```text
内核态：hid / usbhid / i2c-hid / input / evdev
用户态：libinput
上层：compositor 或 Xorg input driver
```

---

# 17. 调试和观察命令

## 当前会话类型

```bash
echo $XDG_SESSION_TYPE
```

输出：

```text
wayland
x11
```

## 当前桌面环境

```bash
echo $XDG_CURRENT_DESKTOP
echo $DESKTOP_SESSION
```

## 当前 display manager

```bash
systemctl status display-manager
```

或者：

```bash
readlink /etc/systemd/system/display-manager.service
```

## Wayland / X11 环境变量

```bash
echo $WAYLAND_DISPLAY
echo $DISPLAY
```

典型：

```text
WAYLAND_DISPLAY=wayland-0
DISPLAY=:0
```

在 Wayland 会话中，`DISPLAY` 也可能存在，因为 XWayland 需要它。

## GPU / DRM

```bash
ls -l /dev/dri/
lspci -k | grep -A3 -E "VGA|3D|Display"
```

## OpenGL 信息

```bash
glxinfo -B
```

X.Org 的 `glxinfo` 用于列出 X server 上 GLX extension、OpenGL renderer 等信息。 

## Vulkan 信息

```bash
vulkaninfo --summary
```

## 输入设备

```bash
libinput list-devices
sudo libinput debug-events
```

## logind seat/session

```bash
loginctl
loginctl session-status
loginctl seat-status seat0
```

systemd/logind 文档中也提到 `loginctl` 可查看 seats 和 session 状态。 

---

# 问题

## 一、桌面环境依赖 GTK / Qt 吗？

### 简要结论

桌面环境的大多数界面组件依赖 GTK、Qt 等 GUI 工具包，但窗口管理器和合成器这类核心组件通常更接近底层图形栈，不能简单理解为普通 GTK/Qt 应用。

### 1. 桌面环境不是单个程序

一个完整桌面环境通常包含很多组件：

```text
桌面环境
├── Shell / 面板 / 启动器
├── 窗口管理器
├── 合成器
├── 文件管理器
├── 设置中心
├── 通知系统
├── 电源管理
├── 输入法集成
├── 主题、图标、字体配置
└── 会话管理服务
```

所以讨论“桌面环境是否依赖 GTK/Qt”，要先区分它的不同部分。

### 2. 普通界面组件通常依赖 GTK / Qt

桌面环境中的大量可见界面，通常由 GUI 工具包开发。

例如：

|桌面环境|主要工具包|典型组件|
|---|---|---|
|GNOME|GTK|设置、文件管理器、系统对话框等|
|KDE Plasma|Qt / KDE Frameworks|系统设置、Dolphin、面板、小组件等|
|XFCE|GTK|面板、设置、Thunar 文件管理器等|
|Cinnamon|GTK|设置、文件管理器、桌面 UI 等|
|LXQt|Qt|面板、设置、文件管理器等|

这些工具包负责提供按钮、菜单、文本框、列表、窗口控件、主题适配等能力。

也就是说：

```text
GTK / Qt 主要负责“构建应用和桌面组件的用户界面”
```

### 3. 但窗口管理器 / 合成器不是普通 GUI 应用

桌面环境里还有一类更特殊的组件：窗口管理器和合成器。

例如：

|桌面环境|窗口管理 / 合成组件|
|---|---|
|GNOME|Mutter / GNOME Shell|
|KDE Plasma|KWin|
|XFCE|Xfwm4|
|Cinnamon|Muffin|
|Wayland 平铺环境|Sway、Hyprland、river 等|

它们负责：

```text
管理窗口位置
处理窗口大小变化
管理焦点
处理多显示器
处理输入事件
合成最终桌面画面
与 Wayland / X11 / DRM / KMS / GPU 驱动交互
```

这类组件虽然可能使用某些桌面生态库，但它们不是普通意义上的“用 GTK/Qt 写出来的界面程序”。  
尤其在 Wayland 下，GNOME 的 Mutter、KDE 的 KWin、Sway、Hyprland 这类组件本身就是 Wayland 合成器，也就是显示服务器。

### 4. 第三方应用不依赖特定桌面环境

用户可以在 GNOME 中运行 Qt 应用，也可以在 KDE 中运行 GTK 应用。

例如：

```text
GNOME 桌面中可以运行 Krita、Dolphin、Telegram Desktop
KDE 桌面中可以运行 Firefox、GIMP、GNOME Files
```

因为应用真正依赖的是：

```text
GUI 工具包 + 显示协议 + 图形驱动
```

而不是必须依赖某个桌面环境。

### 本节总结

```text
桌面环境的大多数 UI 组件通常基于 GTK 或 Qt。

GNOME 生态主要使用 GTK。
KDE Plasma 生态主要使用 Qt。
XFCE 主要使用 GTK。

但窗口管理器 / 合成器属于更底层、更特殊的组件，
它们会直接处理 Wayland、X11、EGL、OpenGL、Vulkan、DRM/KMS、libinput 等图形和输入接口。

因此，不能简单说“桌面环境就是用 GTK/Qt 写的”。
更准确地说，GTK/Qt 是桌面环境构建 UI 的重要工具，但不是整个图形栈的底座。
```

## 二、桌面环境是否直接调用 Wayland / X11 来绘制显示？

### 简要结论

普通应用和桌面组件通常通过 GTK/Qt 间接使用 Wayland/X11；但桌面环境中的合成器组件，在 Wayland 下本身就是显示服务器，在 X11 下则通常作为窗口管理器与 X Server 协作。

另外，Wayland/X11 主要不是“绘图 API”，而是客户端和显示系统之间的通信协议。

### 1. 先区分三个概念

理解这个问题，需要先区分：

```text
绘制 Rendering
合成 Compositing
显示输出 Scanout / Display Output
```

它们不是一回事。

#### 1.1 绘制：应用把自己的内容画出来

比如 Firefox 渲染网页，VS Code 渲染编辑器，终端渲染文字。

这一步通常由应用和它使用的图形库完成：

```text
应用程序
  ↓
GTK / Qt / Electron / SDL / Flutter 等
  ↓
Cairo / Skia / OpenGL / Vulkan / WebRender 等
  ↓
Mesa 或 NVIDIA 用户态驱动
  ↓
生成窗口内容 buffer
```

这个 buffer 可以理解为一张已经画好的图。

#### 1.2 合成：把多个窗口摆成最终桌面

系统里通常不止一个窗口。

合成器要决定：

```text
哪个窗口在上面
哪个窗口在下面
窗口在哪里
是否有阴影
是否透明
是否缩放
是否跨显示器
是否需要动画
```

合成后的结果才是你看到的完整桌面。

#### 1.3 显示输出：把最终画面送到显示器

最后，合成器或显示服务器通过内核图形系统把画面送到显示器：

```text
合成后的画面
  ↓
DRM / KMS
  ↓
显卡内核驱动
  ↓
HDMI / DisplayPort / eDP
  ↓
显示器
```

### 2. Wayland 下的关系

Wayland 下，架构比较清晰：

```text
应用程序
  ↓
GTK / Qt / Electron / SDL
  ↓
Wayland client library
  ↓
Wayland compositor
  ↓
DRM / KMS + GPU driver
  ↓
显示器
```

但这里有一个关键点：

```text
Wayland compositor 本身就是显示服务器
```

例如：

|桌面 / 环境|Wayland 合成器|
|---|---|
|GNOME|Mutter|
|KDE Plasma|KWin|
|Sway|Sway|
|Hyprland|Hyprland|
|Weston|Weston|

在 Wayland 下，应用通常不会直接控制窗口的最终位置，也不会直接控制显示器输出。应用负责把自己的窗口内容渲染成 buffer，然后通过 Wayland 协议提交给合成器。

更完整的流程是：

```text
应用渲染自己的窗口内容
  ↓
应用把 buffer 提交给 Wayland compositor
  ↓
compositor 决定窗口位置、大小、层级、焦点
  ↓
compositor 合成所有窗口
  ↓
compositor 通过 DRM/KMS 输出到显示器
```

所以，Wayland 下：

```text
应用负责画自己的内容。
合成器负责管理和摆放整个桌面。
```

### 3. X11 下的关系

X11 架构更历史化，也更复杂。

典型 X11 关系是：

```text
应用程序
  ↓
GTK / Qt / Xlib / XCB / GLX
  ↓
X Server
  ↓
Window Manager
  ↓
Compositor
  ↓
DRM / KMS + GPU driver
  ↓
显示器
```

在 X11 下：

|组件|职责|
|---|---|
|X Server|负责 X11 协议、窗口基础管理、输入输出|
|Window Manager|管理窗口位置、边框、焦点、最小化、最大化|
|Compositor|负责透明、阴影、动画和最终合成|
|应用程序|绘制自己的内容，并与 X Server 通信|

X11 里的窗口管理器通常是 X Server 的一个特殊客户端。  
它通过 X11 协议告诉 X Server 如何移动、调整和管理窗口。

例如：

```text
应用连接 X Server
窗口管理器也连接 X Server
窗口管理器通过 X11 协议管理其他窗口
```

这和 Wayland 不同。

在 Wayland 下，合成器本身就是服务器；  
在 X11 下，窗口管理器通常是 X Server 的客户端。

### 4. Wayland 和 X11 是“绘图接口”吗？

不完全是。

#### Wayland

Wayland 基本不提供传统意义上的绘图 API。

它更像一个通信协议：

```text
客户端：这是我画好的 buffer
合成器：我收到了，我来决定怎么显示
```

Wayland 的核心职责不是“画线、画字、画按钮”，而是规定客户端和合成器如何交换窗口、输入、buffer、状态等信息。

#### X11

X11 历史上包含一些绘图能力，比如画线、画矩形、绘制 pixmap 等。

但在现代桌面中，很多应用已经不主要依赖 X Server 来逐笔绘制界面，而是通过：

```text
Cairo
OpenGL
Vulkan
Skia
WebRender
Mesa
GPU 加速
```

自己渲染内容，再交给 X Server 或 compositor 显示。

所以：

```text
Wayland 基本不是绘图 API。
X11 历史上包含绘图 API，但现代应用常常绕过传统 X11 绘图路径。
```

### 5. 客户端应用会不会直接使用显卡？

会，但要准确理解“直接”。

普通应用不会直接控制显示器，也不会直接操作显卡寄存器。  
但它可以通过 OpenGL、Vulkan、Mesa、NVIDIA 驱动等方式使用 GPU 来渲染自己的窗口内容。

例如：

```text
游戏 / 浏览器 / Blender
  ↓
OpenGL / Vulkan
  ↓
Mesa 或 NVIDIA 用户态驱动
  ↓
/dev/dri/renderD128
  ↓
显卡内核驱动
  ↓
GPU 执行渲染
```

因此，下面这句话是不准确的：

```text
客户端不接触显卡，只发送缓冲区。
```

更准确的说法是：

```text
客户端可以使用 GPU 渲染自己的窗口内容，
但不负责最终桌面合成和显示输出。

最终窗口摆放、输入焦点、层级关系、多显示器输出，
由 Wayland compositor 或 X Server / compositor 负责。
```

### 6. 移动窗口时，应用会参与吗？

通常不会。

移动窗口主要由窗口管理器或合成器处理。

#### Wayland 下

```text
用户拖动窗口
  ↓
compositor 改变窗口在桌面中的位置
  ↓
compositor 重新合成桌面
```

应用通常不需要知道自己在屏幕上的绝对坐标。  
如果窗口大小、缩放比例、焦点状态等发生变化，compositor 才会通过协议通知应用。

例如：

```text
窗口被 resize
输出 scale 变化
焦点变化
弹出菜单位置需要重新约束
```

这类情况下，应用需要响应。

#### X11 下

X11 中应用、窗口管理器、X Server 之间的关系更开放，应用更可能知道窗口位置，也可能收到更多窗口配置事件。

但即便如此，移动窗口的主导者通常仍然是窗口管理器。