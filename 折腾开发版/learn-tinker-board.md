# 安装安卓系统

- [没啥卵用的官网GitHub](https://github.com/TinkerBoard/TinkerBoard/wiki)
- [官网github要看右侧的目录找](https://github.com/TinkerBoard/TinkerBoard/wiki/Tinker-Board-S-R2.0-&-R2.0,-Tinker-Board-&-S)

## 下载windows工具
最开始还需要下载两个东西：
    - 一是DriverAssitant，这个东西是瑞芯微芯片组的驱动，不好下载，可以去其他使用该cpu的板子网站下载
    - img烧录工具，官网建议balenaEtcher，试过，免费，可以，去官网下载，或者下载其他类似，但是用瑞芯微驱动助手不太行好像

## 下载官网img文件
下面是实时更新的官网安装包（tinker-board系统的）下载网址，不要在别的网站帖子下载，这里是最新的。
https://tinker-board.asus.com/download-list.html

## 安装
下面网址很关键，USB3.0接口不能用，只能用usb2.0，真是服了。
https://www.tinkerboard.cn/thread-137-1-1.html

### 重新烧录
如果安装错了，EMMC上错误的系统无法被windows识别盘符，则需要按照下述方式重新烧录：
https://youyeetoo.cn/forum.php?mod=viewthread&tid=5645&page=1&authorid=8447
如果用户不小心刷错了固件，导致插USB到PC上无法识别到U盘，所以没法烧录新的固件。

解决方法：
1，下载最新的固件（TinkerOS_Android/TinkerOS_Debian）
      用做卡工具，烧录到TF卡上
2，把做好的系统卡插到tinkerboad S上，并且，跳线如下(跳到eMMC Recovery模式，表示上电运行的是TF卡里的系统)

3，主板通过Micro USB线插到电脑上，此时PC上应概就能看得到一个U盘了，
     此时用做卡工具（win32imager）对这个U盘烧录最新的固件，烧录完成后拔出USB

4，板子重新跳线帽回到default/diable模式那里，如上图 重新给板子上电，就能进入EMMC的系统了。


# 开发工具

- [官方-GitHub-Developer_Guide](https://github.com/TinkerBoard/TinkerBoard/wiki/Developer-Guide)
- [Tinker Board S R2.0 & R2.0, Tinker Board & S](https://github.com/TinkerBoard/TinkerBoard/wiki/Tinker-Board-S-R2.0-&-R2.0,-Tinker-Board-&-S)

## adb

- [adb-android官网](https://developer.android.com/tools/adb?hl=zh-cn#)
ADB的全称是： Android debug bridge

通俗的话来说就是：如果想通过Shell命令来操作Android系统，这个调试前提就是需要ADB当成一座桥，Android环境和开发环境需要ADB来进行桥接。

我们还可以借助ADB工具，可以管理设备或手机模拟器的状态。还可以进行很多手机操作，如安装软件、系统升级、运行shell命令等等。可以让用户在电脑上对手机进行全面的操作。
（1）快速更新设备或手机模拟器中的代码，如应用或Android系统升级；
（2）在设备上运行Shell命令；
（3）管理设备或手机模拟器上的预定端口；
（4）在设备或手机模拟器上复制或粘贴文件。
