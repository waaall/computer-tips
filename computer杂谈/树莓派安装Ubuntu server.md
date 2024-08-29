# 树莓派安装Ubuntu server

[toc]

---

* [树莓派|如何在树莓派上安装 Ubuntu 服务器？ (linux.cn)](https://linux.cn/article-12783-1.html)



### 1.官网下载工具

* [install ubuntu on Raspberry Pi](https://ubuntu.com/download/raspberry-pi)

* [install image "writer"](https://www.raspberrypi.com/software/)



用`Raspberry Pi image`打开下载的镜像, 拷贝到sd卡中,此时修改sd卡中根目录中的文件:  `network-config`: 

```yaml
# 将下面这部分取消注释,然后把wifi名字和密码更改为自己的.
wifis:
  wlan0:
    dhcp4: true
    optional: true
    access-points:
      "your wifi name":
      password: "your_wifi_password"
```

这是ubuntu server 树莓派版的特殊设置方法, 虽然之后发现依然有问题. 但是还是附上相应的[参考网站](https://cloud-atlas.readthedocs.io/zh_CN/latest/arm/raspberry_pi/network/pi_ubuntu_network.html).

关于network, 一般做法是修改文件: `/etc/netplan/50-cloud-init.yaml`, 上述做法也是类似, 之后会在讲到. 



### 2.开机初设置

以下步骤大多数都是常规ubuntu server的配置方法.



#### 用户名和密码

默认的用户名和密码都是`ubuntu`, 在第一次开机后要求修改密码.

#### 更改console字体和大小

[参考blog](https://linux.cn/article-11258-1.html)

也就是使用一个工具: ` console-setup`, 其配置文件在: `/etc/default/console-setup`. 可以直接在shell使用如下指令来更改设置:

```bash
sudo dpkg-reconfigure console-setup
```

在使用 Systemd 的 Linux 发行版上，还可以通过编辑 `/etc/vconsole.conf` 来更改控制台字体。

#### 设置时间

```bash
#查看时间
date -R

#设置时区(time zone)
sudo tzselect

#设为默认
sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
```

#### 挂载U盘

在很多时候, 很多配置文件我们在已有的ubuntu server设置好了,所以只需要拷贝到U盘里, 复制到树莓派就可以, 所以需要先挂载U盘:

```bash
# 查看磁盘信息
sudo fdisk -l 

# 建一个文件夹, 也就是把这个U盘挂载到对应的文件夹上, 一般默认是/mnt/下的,不过可以随意
sudo mkdir /mnt/usb

# 挂载, 第一个参数名称就是上述第一个指令后显示的,U盘的名称, 比如/dev/sda1 之类的
sudo mount /dev/sdb1 /mnt/usb

# 卸载u盘
sudo umount /mnt/usb/
```



#### 联网

* 网线

linux的联网配置文件:



* [WiFi](https://zhuanlan.zhihu.com/p/252872750)

但上述链接中的方法不可行, [初步判断](https://bugs.launchpad.net/ubuntu/+source/netplan.io/+bug/1874377)在于树莓派的电源管理(省电)拒绝连接WiFi, 其控制权限更高, netplan无法修改. 来自[论坛](https://raspberrypi.stackexchange.com/questions/96606/make-iw-wlan0-set-power-save-off-permanent).



#### 美化终端
设置oh my zsh等，都是些常规操作。
* [bash的自定义设置](https://wiki.archlinux.org/title/Bash/Prompt_customization)

#### 设置ssh

```bash
sudo systemctl enable ssh
```

#### 再谈网络

net-tools不再维护，所以ifconfig不需要再安装，用ip指令代替。

关于Linux系统的网络配置，这篇文章讲的很全面：[How to use a WiFi interface](https://wiki.debian.org/WiFi/HowToUse#NetworkManager)

主要就是两个类似的工具：
> Wireless network interface configuration requires a backend, generally wpa_supplicant (often in conjunction with ifupdown and other utilities) or IWD. These can be used with connection managers that provide advanced functionality, and an easier way to configure them.

##### wpa_supplicant、netplan、iwd、NetworkManager的关系




#### iwd

[IWD-archwiki](https://wiki.archlinux.org/title/Iwd_(简体中文)#连接网络)

> iwd (iNet wireless daemon，iNet 无线守护程序) 是由英特尔（Intel）为 Linux 编写的一个无线网络守护程序。该项目的核心目标是不依赖任何外部库，而是最大程度地利用 Linux 内核提供的功能来优化资源利用。
> iwd 可以独立工作，也可以和 ConnMan、systemd-networkd 和 NetworkManager 这样更完善的网络管理器结合使用。

* iwd的配置
```bash
# 安装
sudo apt install iwd

# 
cd /etc/NetworkManager/conf.d/  # 如果没有conf.d文件夹，则sudo mkdir conf.d

sudo vim iwd.conf

#添加如下两行：
[device]
wifi.backend=iwd

#启动开机自启iwd服务
sudo systemctl enable iwd.service

#关上系统默认的这个类似服务
sudo systemctl mask wpa_supplicant
reboot   #重启

# 没啥用，就是看下自启服务有哪些
sudo systemctl list-unit-files --state enabled
```

* iwd的使用
以下指令来自本章开头的参考网址：[IWD-archwiki](https://wiki.archlinux.org/title/Iwd_(简体中文)#连接网络)
还有这个网站：[How to use a WiFi interface](https://wiki.debian.org/WiFi/HowToUse#NetworkManager)

```bash
# 首先进入iwd命令行
iwctl 

# 以下是在iwd命令行下输入
device list     #显示可用wifi适配器

station device scan   #注意这个device是上个指令显示结果中的名字，比如wlan0

#显示可以搜到的网络名，注意这个wlan0和上条指令的device一样，是具体的Wi-Fi适配器名字。
station wlan0 get-networks 

#连接具体网络，SSID就是Wi-Fi名字
station wlan0 connect SSID
```

#### 设置vim-plug

由于没有梯子，就在Windows上下载下plug.vim，然后用U盘考到ubuntu下，先了报错：

```bash
E492: Not an editor command: ^M
………
```
关于此错误的[stackoverflow](https://stackoverflow.com/questions/21902754/vim-startup-errors-invalid-expression-debian)：原来是文件类型是windows风格的，不是unix风格。
> That's caused by Vimscript files that have Windows-style CR-LF line endings when used on Linux. 

解决方案：用vim打开plug.vim重新用unix风格保存。
```vim
:w! ++ff=unix
```

* [安装YouCompleteMe](https://segmentfault.com/a/1190000025167983)


#### 设置tmux
[tmux教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)
```bash
#开启一个新“终端进程”，Ctrl+d是快捷键，退出当前的tmux窗口
tmux

# Ctrl+b 是一组新快捷键的“开头”，
```
Tmux 的最简操作流程：
1. 新建会话tmux new -s my_session。
2. 在 Tmux 窗口运行所需的程序。
3. 按下快捷键Ctrl+b d将会话分离。
4. 下次使用时，重新连接到会话tmux attach-session -t my_session。


#### tty支持中文

* [tty支持中文](https://forum.ubuntu.org.cn/viewtopic.php?t=491820&start=15)

#### wsl2支持mount ex4硬盘
* [微软wsl官方文档](https://docs.microsoft.com/zh-cn/windows/wsl/wsl2-mount-disk)