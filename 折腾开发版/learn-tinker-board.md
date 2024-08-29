最开始还需要下载两个东西：
    - 一是DriverAssitant，这个东西是瑞芯微芯片组的驱动，不好下载，可以去其他使用该cpu的板子网站下载
    - img烧录工具，官网建议balenaEtcher，试过，免费，可以，去官网下载，或者下载其他类似，但是用瑞芯微驱动助手不太行好像

下面是实时更新的官网安装包（tinker-board系统的）下载网址，不要在别的网站帖子下载，这里是最新的。
https://tinker-board.asus.com/download-list.html

下面网址很关键，USB3.0接口不能用，只能用usb2.0，真是服了。
https://www.tinkerboard.cn/thread-137-1-1.html

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