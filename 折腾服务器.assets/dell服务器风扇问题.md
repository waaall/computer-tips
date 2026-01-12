## 总结在前

具体技术细节和参考链接见下文。

- dell 服务器安装了第三方配件如PCIE卡、固态、显卡等，就会导致风扇自动控制废掉。
- 本来可以通过IPMI设置为手动控制解决，结果他在iDRAC 3.34版本后移除了改支持。
- 但是还能降版本重装解决，but 版本7.00.00.172 or newer设置无法降级。。。
- 或者取消第pand三方sg设备的guan关联，但是7.00zhi hou hai shia之后还是不行了。
- racadm就是iDRAC的命令行版本，几乎没有格外的控制功能。

## refs
- [ipmitool control PowerEdge fan](https://www.reddit.com/r/homelab/comments/t9pa13/dell_poweredge_fan_control_with_ipmitool/?tl=zh-hans)
- [fan_controller_Docker](https://github.com/tigerblue77/Dell_iDRAC_fan_controller_Docker)
- [服务器的BMC，IPMI介绍以及Dell服务器风扇降速方法](https://zhuanlan.zhihu.com/p/157796567)
- [reddit-adjust_the_fan_speed](https://www.reddit.com/r/homelab/comments/101u7br/how_can_i_adjust_the_fan_speed_beyond_low_offset/?tl=zh-hans)
- [Dell Fan Noise Control - Silence Your Poweredge](https://old.reddit.com/r/homelab/comments/7xqb11/dell_fan_noise_control_silence_your_poweredge/)

- [idrac9_downgrade](https://www.reddit.com/r/homelab/comments/1byc5pv/r740xd_idrac9_downgrade/?tl=zh-hans)
- [Dell ENG is taking away fan speed control away from users ( iDrac >= 3.34.34.34)](https://www.dell.com/community/en/conversations/poweredge-hardware-general/dell-eng-is-taking-away-fan-speed-control-away-from-users-idrac-3343434/647f8593f4ccf8a8de47aa9b)
- [Custom Cooling Fan Options for Dell EMC PowerEdge Servers](https://dl.dell.com/manuals/common/customcooling_poweredge_idrac9.pdf?dgc=SM&cid=243907&lid=spr5090153920&linkId=123036317](https://dl.dell.com/manuals/common/customcooling_poweredge_idrac9.pdf?dgc=SM&cid=243907&lid=spr5090153920&linkId=123036317))
- [iDRAC9 - RAC0181 - Firmware Downgrade Failures on 14G 15G Servers](https://www.dell.com/support/kbdoc/en-us/000225924/rac0181-idrac9-firmware-downgrade-failures-on-14-15g-poweredge-servers](https://www.dell.com/support/kbdoc/en-us/000225924/rac0181-idrac9-firmware-downgrade-failures-on-14-15g-poweredge-servers))
- [dell转速异常](https://www.dell.com/community/zh/conversations/poweredge服务器/r7525风扇转速异常/66bde9d047effa74c48587c6)

## ipmitool
```bash
sudo apt install -y ipmitool

# 去iDRAC设置密码，把《启动LAN伤的IPMI》打开，取消密钥（全设置0）否则会报错：无法建立 IPMI v2 / RMCP+ 会话
sudo ipmitool -I lanplus -H 192.168.4.100 -U root -P "pwd*1234" sdr elist all

# 查看信息
sudo ipmitool -I lanplus -H 192.168.4.100 -U root -P "pwd*1234" mc info

# Dell Fan Control Commands
# print temps and fans rpms
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> sensor reading "Ambient Temp" "FAN 1 RPM" "FAN 2 RPM" "FAN 3 RPM"

# print fan info
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> sdr get "FAN 1 RPM" "FAN 2 RPM" "FAN 3 RPM"

# enable manual/static fan control
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x01 0x00

# disable manual/static fan control
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x01 0x01

# set fan speed to 0 rpm
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x02 0xff 0x00

# set fan speed to 20 %
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x02 0xff 0x14

# set fan speed to 30 %
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x02 0xff 0x1e

# set fan speed to 100 %
ipmitool -I lanplus -H <iDRAC-IP> -U <iDRAC-USER> -P <iDRAC-PASSWORD> raw 0x30 0x30 0x02 0xff 0x64
```

### dell-iDRAC 与 IPMI问题

一、dell 服务器安装了第三方配件如PCIE卡、固态等，就会导致风扇自动控制废掉。

- [Dell actually instructs users to use this feature for certain issues arising from Dell's poor integration with other hardware.](https://www.dell.com/community/PowerEdge-Hardware-General/r730xd-excessive-fan-speed/td-p/4586254)
- So, dell says to do something and takes away the ability to do it? This is a very poor business practice.

```txt
# r730xd excessive fan speed
I added a PCIe card to my r730xd.  The fans went from 3,800 RPM to 17,000.

The Lifecycle log showed:

## _PCI3018_
_New PCI card(s) have been detected in the system. Fan speeds may have changed to add additional cooling to the cards._

The suggested solution to this is:
 _If a lower fan speed is required, contact your service provider for the appropriate IPMI commands to reduce the default fan speed response for new PCIe cards._

I have been working with my local Dell service contact but they so far are not able to provide me with the IPMI sequence I require to not scream the fans.

FWIW, my t410 has the pair of this card (a Mellanox 40/56GB dual port card) and it has not adjusted the fans in the least.  Mellanox describes this as a low power card.  Whenever I remove it from the screamer, the heat sink is not even warm to the touch.

```

二、本来可以通过IPMI设置为手动控制解决，结果他在iDRAC 3.34版本后移除了改支持。并在版本7.00.00.172 or newer设置无法降级。。。
- [idrac9_downgrade](https://www.reddit.com/r/homelab/comments/1byc5pv/r740xd_idrac9_downgrade/?tl=zh-hans)
- [Dell ENG is taking away fan speed control away from users ( iDrac >= 3.34.34.34)](https://www.dell.com/community/en/conversations/poweredge-hardware-general/dell-eng-is-taking-away-fan-speed-control-away-from-users-idrac-3343434/647f8593f4ccf8a8de47aa9b)
- [Custom Cooling Fan Options for Dell EMC PowerEdge Servers](https://dl.dell.com/manuals/common/customcooling_poweredge_idrac9.pdf?dgc=SM&cid=243907&lid=spr5090153920&linkId=123036317](https://dl.dell.com/manuals/common/customcooling_poweredge_idrac9.pdf?dgc=SM&cid=243907&lid=spr5090153920&linkId=123036317))
- [iDRAC9 - RAC0181 - Firmware Downgrade Failures on 14G 15G Servers](https://www.dell.com/support/kbdoc/en-us/000225924/rac0181-idrac9-firmware-downgrade-failures-on-14-15g-poweredge-servers](https://www.dell.com/support/kbdoc/en-us/000225924/rac0181-idrac9-firmware-downgrade-failures-on-14-15g-poweredge-servers))

下文节选自上述论坛。
```txt
我是戴尔EMC的解决方案经理，负责处理这个支持案例。我联系了我们的工程升级部门，询问了关于

使用IPMI命令以及在iDRAC 3.34版本中移除该功能的问题。虽然像您这样的客户很擅长使用

这些命令，但我们收到了很多关于因使用不当而导致严重问题的升级报告。我还被告知，

这些命令本来就不应该提供，但之前已经提供了一段时间。我们知道戴尔有一些白皮书介绍了如何使用IPMI，但由于它可能导致的问题，我们已经将其删除，并且不会在未来的任何版本中重新添加。至于您的服务器配置和

在系统中安装第三方组件，例如客户端硬盘和显卡，这些组件是不受支持的，并且您也知道，这会导致风扇高速运转，因为系统试图确保适当的散热。我们不确定您是如何使用这台服务器的，但作为建议

并且基于您添加的这些额外组件，使用工作站可能更合适，而不是服务器。

There are a couple configurations settings you can tweak.

This white paper has some adjustments you can try such as System Thermal Profile settings and Fan Offsets:

If you are on iDRAC vesion 7.00.00.172 or newer you cannot downgrade past 7.00.00.172
```

## 尝试关闭第三方配件响应

- [How to disable the third-party PCIe Card default cooling response on PowerEdge 13G Servers](https://www.dell.com/support/kbdoc/en-us/000135682/how-to-disable-the-third-party-pcie-card-default-cooling-response-on-poweredge-13g-servers)
```bash
# Set Third-Party PCIe Card Default Cooling Response Logic To Disabled
ipmitool -I lanplus -H <IPADDRESS> -U <USERNAME> -P <PASSWORD> raw 0x30 0xce 0x00 0x16 0x05 0x00 0x00 0x00 0x05 0x00 0x01 0x00 0x00
  
# Set Third-Party PCIe Card Default Cooling Response Logic To Enabled
ipmitool -I lanplus -H <IPADDRESS> -U <USERNAME> -P <PASSWORD> raw 0x30 0xce 0x00 0x16 0x05 0x00 0x00 0x00 0x05 0x00 0x00 0x00 0x00 

# Get Third-Party PCIe Card Default Cooling Response Logic Status.
ipmitool -I lanplus -H <IPADDRESS> -U <USERNAME> -P <PASSWORD> raw 0x30 0xce 0x01 0x16 0x05 0x00 0x00 0x00
```

The response data will be:
```bash
16 05 00 00 00 05 00 01 00 00 (Disabled)
16 05 00 00 00 05 00 00 00 00 (Enabled)
```

但是我的是：
```bash
Unable to send RAW command (channel=0x0 netfn=0x30 lun=0x0 cmd=0xce rsp=0xc1): Invalid command
```
### 还是iDRAC7.0的问题
下文部分内容截取自该链接：[dell转速异常](https://www.dell.com/community/zh/conversations/poweredge服务器/r7525风扇转速异常/66bde9d047effa74c48587c6)。

使用了ipmitool & racadm 风扇转速没有下降，还是在100%维持。
```
racadm>>racadm setsystem.pcieslotlfm.2.lfmmode disabled ERROR: PCI3022: Unable toadjust the Airflow Linear Flow per Minute (LFM) settings of the PCIe slot because the LFM settings can be adjusted only for installed cards that are identified as third party cards. racadm>>racadm getsystem.PCIeSlotLFM.2.LFMMode [Key=system.Embedded.1#PCIeSlotLFM.3] LFMMode=Automatic racadm>>racadm set system.PCIeSlotLFM.2.LFMMode 1ERROR: PCI3022: Unable to adjust the Airflow Linear Flow per Minute (LFM) settings of the PCIe slot because the LFM settings can be adjusted only for installed cards that are identified as third party cards. racadm>>racadm setsystem.PCIeSlotLFM.2.3rdpartycard yes ERROR: The specified object isREAD ONLY and cannot be modified.
```

以上是我尝试使用命令去关闭a30槽位的lfm补偿，但是它说这必须是第三方卡才行，但是这个a30卡就是普通的英伟达公版，并不是戴尔的oem版本，因此我尝试把它修改成第三方卡，发现这个值是只读的。(补充：我使用了非兼容性列表中的显卡，服务器依旧认为这不是第三方配件)

所以目前我想要修改它的lfm补偿值，就需要把它修改成第三方卡，但是第三方卡是只读的，我目前不知道怎么强行修改。但是在低版本的idrac9(6.00.30.00)中似乎可以直接通过：
```
racadm setsystem.pcieslotlfm.2.lfmmode disabled
```
命令来关闭lfm补偿，因为设备正确的把第三方配件识别出来了，但是在idrac9(7.00.00.00)中因为设备没有正确识别第三方配件，所以无法按照所希望的那样去执行，会有报错。
```
racadm>>racadm setsystem.pcieslotlfm.2.lfmmode disabled ERROR: PCI3022: Unable toadjust the Airflow Linear Flow perMinute (LFM) settings of the PCIe slot because the LFM settings can be adjusted only for installed cards that are identified as third party cards.
```
如果没有报错，就会像我以下列出的文章一样返回一个正确的响应，并且风扇速度下降：[Dell R7515 使用第三方Pcie设备后导致的风扇转速偏高](https://atsuko.org/?p=263)
我真诚希望可以在论坛中获取到如何修正第三方配件的识别结果或者其他有效的方法以把风扇转速降低到一个正常的范围，而不是在无负载且温度正常时转速维持100%

## racadm

- 《Dell EMC Systems Management Tools And Documentation 安装指南》
- [Dell EMC OpenManage DRAC Tools 9.2](https://www.dell.com/support/home/en-us/drivers/driversdetails?driverid=9dd9y)
- [Dell PowerEdge T640 风扇噪音问题的解决](https://zhuanlan.zhihu.com/p/336990051)
- [dell support](https://www.dell.com/support/product-details/en-us/product/poweredge-t640/drivers)「FZDCMW3」

- [T640噪音](https://blog.csdn.net/weixin_35727143/article/details/119591479)
```bash
# 查看有几个PCIE的东西。一般来说是最后一个。
sudo racadm get System.PCIESlotLFM

# 设置模式，应该只有0，1，2三种，对应高中低; 设置为2后，耳朵终于清静了？
sudo racadm set System.PCIESlotLFM.8.LFMMode
```

有三种 RACADM 使用模式（理解好再动手会少踩坑）

- Local RACADM（在被管理主机的 OS 上运行，通常需要在该主机上安装 iDRAC Tools/OMSA）；
- Remote RACADM（在管理站通过网络对 iDRAC 发命令，常用
```bash
racadm -r <IP> -u <user> -p <pass> <cmd>）；
```

Firmware/SSH RACADM（直接 SSH 登 iDRAC，进入 iDRAC 的 racadm shell）。

### 检查系统设置
1. 确认 iDRAC 的 IP、子网、网关与管理帐号（默认 root / calvin，若已改则用改后帐号）。
2. 管理站能连通 iDRAC（示例）：

```bash
ping -c 3 <idrac-ip>

# 或检查 443/22 端口是否开放
nc -vz <idrac-ip> 443
nc -vz <idrac-ip> 22
```

确保 iDRAC 上已启用 Remote RACADM/SSH（通常默认启用；若没启可在 iDRAC Web UI → Overview → iDRAC Settings → Network → Services 下启用 Remote RACADM / SSH）。

### 安装 RACADM

**Windows**

1. 到 Dell 支持页面下载 “Dell OpenManage / iDRAC Tools (包含 RACADM CLI)”（例如 Windows 安装包 OM-DRAC-Dell-Web-WINX64-*.exe）。下载页面示例。
2. 在管理员权限下运行安装程序，按向导完成。
3. 安装后打开 CMD/PowerShell，验证：

```bash
racadm help
racadm getsysinfo
```

**Linux（RHEL/CentOS/Ubuntu 等）**

1. 到 Dell 支持页面下载 iDRAC Tools for Linux 的 tar.gz（版本按你需要的 iDRAC Tools 选）。
2. 在管理站解压并安装（示例）：

```bash
# 假设文件名
iDRAC.TOOLS.LX.x.x.tar.gz
tar -zxvf iDRAC.TOOLS.LX.x.x.tar.gz
cd iDRAC_Tools/linux/rac
sudo ./install_racadm.sh
```

Debian/Ubuntu 如无原生包，有时需要把 RPM 转成 DEB（alien）或使用官方给出的说明（多数 RHEL系直接支持）。安装后验证：

```bash
which racadm
racadm help
racadm getsysinfo
```

（官方安装流程与脚本说明见包内 readme.txt/Dell 文档）。

### 远程连接 iDRAC

**1) Remote RACADM（最常用）**

语法：
```bash
racadm -r <iDRAC-IP> -u <username> -p <password> <subcommand> [options]
```

示例：
```bash
# 获取详细系统/iDRAC 信息
racadm -r 10.0.0.5 -u root -p 'YourP@ss' getsysinfo -d

# 查询 iDRAC 的网口配置
racadm -r 10.0.0.5 -u root -p 'YourP@ss' getniccfg

# 查看硬件清单（长）
racadm -r 10.0.0.5 -u root -p 'YourP@ss' hwinventory

# 查看系统事件日志（SEL）
racadm -r 10.0.0.5 -u root -p 'YourP@ss' getsel
```

（远程 RACADM 的访问/限制与使用说明见官方文档）。

**2) Firmware RACADM（SSH 登录 iDRAC）**

```bash
ssh root@<iDRAC-IP>

# 登入后会到 iDRAC shell，直接运行 racadm 命令（或直接在 ssh 一行运行）
ssh root@<iDRAC-IP> 'racadm getsysinfo -d'
```

这个方式等同在 iDRAC 固件层使用 racadm，适合无法在管理站安装工具或需要在 iDRAC 本地执行命令的情况。

### 常用命令

 **系统信息 / 盘点**
```bash
# 详细系统信息
racadm -r <IP> -u <user> -p <pass> getsysinfo -d        

# iDRAC/firmware 版本信息
racadm -r <IP> -u <user> -p <pass> getversion          

# 完整硬件清单（NIC, PCIe, DIMM...）
racadm -r <IP> -u <user> -p <pass> hwinventory
#（hwinventory 可用来定位“哪个 PCIe 卡 没被识别 / third-party”）。
```

**网络设置**
```bash
# 用静态 IP 设置（简便命令）
racadm -r <IP> -u <user> -p <pass> setniccfg -s 192.168.1.55 255.255.255.0 192.168.1.1

# 打开/关闭 DHCP
racadm -r <IP> -u <user> -p <pass> setniccfg -d   # 开启 DHCP
racadm -r <IP> -u <user> -p <pass> setniccfg -s <ip> <mask> <gw>  # 设静态
（也可用 racadm get / racadm set 或 racadm config -g <group> -o <obj> <val> 操作更细的对象）。

```
**电源 / 重启**
```bash
racadm -r <IP> -u <user> -p <pass> serveraction powerstatus   # 查看电源状态
racadm -r <IP> -u <user> -p <pass> serveraction powerdown     # 关机
racadm -r <IP> -u <user> -p <pass> serveraction powerup       # 开机
racadm -r <IP> -u <user> -p <pass> serveraction powercycle    # 重启（cold）
racadm -r <IP> -u <user> -p <pass> serveraction hardreset     # 强制重启
```
（这些是官方支持的 serveraction 选项）。

**日志 / SEL**

```bash
racadm -r <IP> -u <user> -p <pass> getsel
racadm -r <IP> -u <user> -p <pass> clrsel       # 清 SEL（谨慎）
```
**iDRAC 重启 / 恢复出厂**

```bash
# 重启 iDRAC（不改配置）
racadm -r <IP> -u <user> -p <pass> racreset

# 恢复出厂（会清除配置，谨慎）
racadm -r <IP> -u <user> -p <pass> racresetcfg    # 保留某些网络/用户选项
racadm -r <IP> -u <user> -p <pass> racresetcfg -rc # 恢复 root/calvin (出厂)
```
（racreset、racresetcfg 的行为与参数请先读说明，执行前确认）。

**创建 / 修改 iDRAC 用户（示例把 3 号槽设置为 admin2）**
```bash
racadm -r <IP> -u <user> -p <pass> set iDRAC.Users.3.Username admin2
racadm -r <IP> -u <user> -p <pass> set iDRAC.Users.3.Password 'P@ssw0rd'

# 启用该账号
racadm -r <IP> -u <user> -p <pass> set iDRAC.Users.3.Enable 1

# 分配权限：建议用官方文档查权限 bitmask 或用 web UI 设置
（默认 root 索引通常是 2；修改默认密码很重要）。
**上传 SSH 公钥（免密登录）**
# 本地安装 racadm 后，上传 public key 文件到用户 index（例如 index=2, key slot=1）
racadm sshpkauth -i 2 -k 1 -f /path/to/id_rsa.pub

# 或直接把 key 文本提交（remote racadm）
racadm -r <IP> -u <user> -p <pass> sshpkauth -i 2 -k 1 -t "<key-text>"
```

（iDRAC 支持为用户上传多把公钥，用于 SSH 公钥认证）。
```bash
# 验证连通
ping <idrac-ip>
nc -vz <idrac-ip> 443

# 测试远程 racadm
racadm -r <IP> -u <user> -p <pass> getsysinfo -d

# 查看传感器信息
racadm -r <IP> -u <user> -p <pass> getsensorinfo

# 网卡信息
racadm -r <IP> -u <user> -p <pass> getniccfg

# 硬件盘点
racadm -r <IP> -u <user> -p <pass> hwinventory

# 查看 / 清 SEL
racadm -r <IP> -u <user> -p <pass> getsel
racadm -r <IP> -u <user> -p <pass> clrsel

# 电源控制
racadm -r <IP> -u <user> -p <pass> serveraction powerstatus
racadm -r <IP> -u <user> -p <pass> serveraction powercycle

# 重启/恢复
racadm -r <IP> -u <user> -p <pass> racreset
racadm -r <IP> -u <user> -p <pass> racresetcfg -rc

# 添加用户
racadm -r <IP> -u <user> -p <pass> set iDRAC.Users.3.Username admin2
racadm -r <IP> -u <user> -p <pass> set iDRAC.Users.3.Password 'P@ssw0rd'
```

#### racadm 设置风扇(跟界面设置一样的)

```bash
racadm -r <iDRAC-IP> -u root -p '<pass>' get system.thermalsettings.ThermalProfile
racadm -r <iDRAC-IP> -u root -p '<pass>' get system.thermalsettings.FanSpeedOffset

# 0=Auto, 1=Maximum performance, 2=Minimum Power
racadm -r <iDRAC-IP> -u root -p '<pass>' set system.thermalsettings.ThermalProfile 2

# FanSpeedOffset: 0=Low, 1=High, 2=Medium, 3=Max, 255=None
racadm -r <iDRAC-IP> -u root -p '<pass>' set system.thermalsettings.FanSpeedOffset 255
# 或者设为 Low（看你机器实际效果）
racadm -r <iDRAC-IP> -u root -p '<pass>' set system.thermalsettings.FanSpeedOffset 0

# 0=Disable, 1=Enable
racadm -r <iDRAC-IP> -u root -p '<pass>' set system.thermalsettings.ThirdPartyPCIFanResponse 0
```

### 常见问题

1. “Failed to initialize transport” / racadm 无法发起连接：在 Linux 上常见是缺少 OpenSSL dev 库（或 openssl-devel），或管理站上 racadm 版本与系统库冲突；根据错误安装 openssl-devel / 相关依赖后重试。
2. 远程连接被拒绝 / “Remote RACADM disabled”：检查 iDRAC Web UI 的 Services 页面是否禁用了 Remote RACADM；SSH 也需启用。
3. 权限不足的错误：确认你用的账户有足够权限（例如查询 SEL 需相应权限，修改 iDRAC 配置需 Configure iDRAC 权限）。
4. 某些旧/新命令被弃用或行为随 iDRAC 版本不同：例如 getconfig 在新固件中被标记为弃用，使用 racadm get/racadm set 替代。务必按你 iDRAC 版本的 RACADM CLI Guide 来执行命令（不同版本的对象名或选项可能不同）。


**注意：**
- 修改 root/calvin 默认密码
- 把 iDRAC 放在受控的管理 VLAN/子网，控制访问来源（防火墙规则），不要直接暴露到公网。
- 用 SSH 公钥登录或证书登陆替代明文密码。
- RACADM、iDRAC 固件和管理工具（iDRAC Tools/OMSA）保持相互兼容的版本，升级前在测试环境验证命令行为（firmware 与工具的版本差异会影响命令可用性）。

## openBMC？

iDRAC就是从openBMC的基础上改的，到现在故意不兼容……

[Dell Open Server Manager (OSM) guide](https://www.dell.com/support/manuals/zh-cn/oth-t340/smog_26.0/dell-open-server-manager-osm?guid=guid-1242ec72-e69b-41c5-bfde-0729604acce0&lang=zh-cn)
> 注:OSM 现已停售，Dell Technologies 建议执行 OSM 3.0.2 到 iDRAC10 的转换。

## 尝试拆/换“不兼容”PCIE
SB-DELL，这明显故意不修，还把路都堵死，作为一个OEM，比苹果兼容性还差……
只能拆/换所谓不兼容的PCIE设备（4090显卡拆下来就好了）。

### dell 服务器兼容性查询
- [poweredge-server-gpu-matrix](https://www.delltechnologies.com/asset/en-iq/products/servers/briefs-summaries/poweredge-server-gpu-matrix.pdf)
- [poweredge-t640 GPU options](https://i.dell.com/sites/csdocuments/shared-content_data-sheets_documents/en/poweredge-t640-spec-sheet.pdf): 4 x DW or 8 x SW
	- Nvidia Tesla P100, K80M, M60, M10, P40
	- AMD S7150, S7150X22
