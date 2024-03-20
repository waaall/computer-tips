# [Raspberry Π Ubuntu server install](https://ubuntu.com/tutorials/how-to-install-ubuntu-desktop-on-raspberry-pi-4#4-optional-usb-boot)



## (optional) USB Boot

You can also now boot from a USB attached hard-drive or SSD with no microSD card involved. You have to do this after booting from an SD card however because all Raspberry Pi 4 models ship with an EEPROM configuration that boots from SD cards only. But we can change that.

The first check you’ve got an up to date EEPROM version on your Pi 4:

```auto
sudo apt install rpi-eeprom
```

Extract the current bootloader configuration to a text file:

```auto
sudo vcgencmd bootloader_config > bootconf.txt
```

Next we need to set the `BOOT_ORDER` option to `0xf41` (meaning attempt SD card, then USB mass-storage device, then repeat; see [pi4 bootloader configuration](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md) for more information).

Alternatively vim bootconf.txt and make the edits yourself if you don’t like sed-hacking

```auto
sed -i -e '/^BOOT_ORDER=/ s/=.*$/=0xf41/' bootconf.txt
```

Now we generate a copy of the EEPROM with the update configuration:

```auto
rpi-eeprom-config --out pieeprom-new.bin --config bootconf.txt /lib/firmware/raspberrypi/bootloader/critical/pieeprom-2020-09-03.bin
```

Set the system to flash the new EEPROM firmware on the next boot

```auto
sudo rpi-eeprom-update -d -f ./pieeprom-new.bin
```

To apply any changes (the EEPROM is only updated during the early stages of boot)

```auto
sudo reboot
```

Now we need to get the image onto a hard drive. That’s the easy part. If you roll this tutorial back to “Prepare the SDcard” and go through it replacing “SD card” with “Hard Drive” you’ll have it.

You should now be able to boot from your hard-drive. Congratulations.

**Warning**
Be aware that some drives have issues being used to boot the Pi. In particular:

- Spinning hard-disks required a lot more power than SSDs and will very likely require a powered USB hub.
- Hubs themselves can cause compatibility issues, so you’re better off with an SSD to boot off (typically no need for a hub and no spin-up time issues).

There’s lots of good information on both the Pi forums and various GitHub issues for debugging boot issues; here’s a selection of links in a rough “look at this first” order from our top Pi guy:

- [Pi Forums: Is your Pi not booting?](https://www.raspberrypi.org/forums/viewtopic.php?t=58151)
- [Pi Forums: USB MSD boot EEPROM](https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=277007)
- [Pi Forums: Pi 4 USB3 SSD slow speeds?](https://www.raspberrypi.org/forums/viewtopic.php?t=245931)
- [Pi Docs: Pi 4 Bootloader Configuration](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md)
- [GitHub Issue: Enclosure doesn’t power on after reboot](https://github.com/raspberrypi/rpi-eeprom/issues/180)








该文章地址：https://helloworlde.github.io/2020/09/20/Raspberry-Pi-4-使用-USB-从-SSD-启动/

## Raspberry Pi 4 使用 USB 从 SSD 启动

树莓派 4 的最新固件已经支持从USB 启动，通过外接 U盘或者硬盘，能够摆脱 SD 卡的IO 速度限制，这里通过 USB 从 SSD 硬盘启动系统

### 安装 Raspberry Pi OS

- 下载 Imager 

从 https://www.raspberrypi.org/downloads/ 下载相应 Imager

- 安装 Raspberry Pi OS 到 SD 卡中

选择第一个镜像

![RaspberryPiOS-install-1.png](https://hellowoodes.oss-cn-beijing.aliyuncs.com/picture/RaspberryPiOS-install-1.png)

然后选择 SD 卡后写入

![RaspberryPiOS-install-2.png](https://hellowoodes.oss-cn-beijing.aliyuncs.com/picture/RaspberryPiOS-install-2.png)

待写入完成后，将 SD 卡插入树莓派 4，正常启动

### 更新 EEPROM

- 查看配置

```
vcgencmd bootloader_version
Apr 16 2020 18:11:26
version a5e1b95f320810c69441557c5f5f0a7f2460dfb8 (release)
timestamp 1587057086
```

如果日期是 `May 15 2020` 之前的，则需要修改配置以启用新的固件

- 更新 

```
sudo apt update
sudo apt full-upgrade
sudo reboot now
```

等更新完成后，会安装新的 `rpi-eeprom`，更新重启后的版本是 `Jun 15 2020`

- 查看配置

```
vcgencmd bootloader_config

[all]
BOOT_UART=0
WAKE_ON_GPIO=1
POWER_OFF_ON_HALT=0
DHCP_TIMEOUT=45000
DHCP_REQ_TIMEOUT=4000
TFTP_FILE_TIMEOUT=30000
ENABLE_SELF_UPDATE=1
DISABLE_HDMI=0
SD_BOOT_MAX_RETRIES=1
USB_MSD_BOOT_MAX_RETRIES=1
BOOT_ORDER=0xf41
```

其中的 `BOOT_ORDER`的值是`0xf41`，说明首先从`USB mass storage boot`启动，如果失败，则从`SD CARD`启动，具体的配置解释可以参考 [Pi 4 Bootloader Configuration](https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md)

### 配置硬盘

- 拷贝 SD 卡的内容到硬盘

点击左上角的树莓派图标，选择附件 -> SD Card Copier
然后选择 From 和 To Device 为相应的 SD 卡和硬盘，点击 Start 开始复制

- 覆盖系统文件
  下载 [raspberrypi/firmware](https://github.com/raspberrypi/firmware) master 分支，解压后将 boot 目录下的所有 `dat` 和 `elf` 后缀的文件拷贝到硬盘中，替换原有的内容，这么因为镜像中的文件尚未支持 USB 启动，所以需要替换，待镜像中支持后，这个操作就可以省略了
- 从 USB 启动
  关闭树莓派，拔出 SD 卡，连接硬盘后重新启动，就可以从 USB 硬盘启动系统了

### 参考文章

- [Raspberry Pi 4 boot EEPROM](https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md)