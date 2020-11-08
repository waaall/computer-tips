# Windows tips

[toc]



## 环境变量

重要系统变量含义和功能：

ComSpec 变量：规定 http://CMD.COM 文件的位置。运行 http://cmd.com 可直接打开 “命令提示符” 窗口。
NUMBER_OF_PROCESSORS 变量：代表用户电脑中处理器的数量。
OS 变量：表明用户的操作系统。
Path 变量：规定操作系统在指定的文件路径中查看可执行文件。
PathExt 变量：规定在 Path 变量中所指定的可执行文件的扩展名有哪些。
PROCESSOR_ARCHITECTURE 变量：表明用户处理器的架构。
PROCESSOR_IDENTIFIER 变量：表明用户处理器。
PROCESSOR_LEVEL 变量：表明用户处理器的等级。
PROCESSOR_REVISION 变量：表明用户处理器的版本。
TEMP、TMP 变量：规定系统运行或安装程序时用来存储临时文件的目录。
windir 变量：规定操作系统的系统目录的路径。


## 注册表

> 打开注册表：`win+R`输入 `regedit` 按回车键之后，打开注册表编辑器。
>
> 
>
> 1. 添加鼠标右键新建项：对应**单击桌面空白处**，新建菜单中的项目对应注册表中的位置 ：
>
> HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew
>
>  
>
> 2. 鼠标单击桌面：**桌面空白处点击右键菜单**对应注册表位置：
>
> HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers
>
>  
>
> 3. 右键单击文件：鼠标**右键文件**，弹出的菜单项对应注册表中的位置：
>
> HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers
>
>  
>
> 4. 单机文件夹：鼠标**右键文件夹**，弹出的菜单项对应注册表中的位置：
>
> HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers
>
>  
>
> 5. 鼠标单击ie浏览器里：鼠标**右键在IE浏览器**里，弹出的菜单明细对应注册表中的位置：
>
> HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt



## Cmd

[CMD脚本](https://wsgzao.github.io/post/windows-batch/)、

[右键打开CMD](https://lanlan2017.github.io/blog/ed5250a2/)、

* [Start命令](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/start)、

 * 命令1 & 命令2 & 命令3 ... (无论前面命令是否故障,照样执行后面)   
 * 命令1 && 命令2 && 命令3....(仅当前面命令成功时,才执行后面)   
 * 命令1 || 命令2 || 命令3.... (仅当前面命令失败时.才执行后面)

```bash
#文件操作
md test #新建文件夹
dir #显示目录
tree #显示目录结构

#网络
ping ip/域名
ping ip/DN -n 5 # 测试5次
tracert ip/DN #路由追踪

#进程管理
tasklist #查看当前进程
tasklist|findstr "9208" #查看进程号
start “” folder1\run.bat #运行
start cmd /k “cd folder1&&python run.py”
taskkill /im notepad.exe #结束进程，按名称
taskkill /pid 1234 #关闭 PID 为 1234 的进程

#服务管理
net start #显示当前正在运行的服务
net start sshd   #开启ssh
net stop 名字 #停止此服务
netstat -aon|findstr "1080" #查看端口占用情况

#查看系统信息
wmic memorychip list brief #看内存
```



## powershell

### powershell配置指令

```bash

##==================使用powershell模块===========================
PS C:\Users\zxll> Import-Module PackageManagement
Import-Module : 无法加载文件 C:\Program Files\WindowsPowerShell\Modules\PackageManagement
\1.4.7\PackageManagement.psm1，因为在此系统上禁止运行脚本。有关详细信息，请参阅 https:/go
.microsoft.com/fwlink/?LinkID=135170 中的 about_Execution_Policies。
所在位置 行:1 字符: 1
+ Import-Module PackageManagement
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [Import-Module]，PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportMod
   uleCommand
PS C:\Users\zxll> get-executionpolicy
Restricted
PS C:\Users\zxll> set-executionpolicy remotesigned
PS C:\Users\zxll> get-executionpolicy
RemoteSigned

###库操作
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module
Get-InstalledModule

Install-Module -Name PSReadLine -AllowPrerelease -Force
Install-Module posh-git -Scope CurrentUser 

Install-Module oh-my-posh -Scope CurrentUser 


```



### 常用指令

```bash
start . #用文件管理器打开当前文件夹（ii .也可以）
Get-Alias #查看现在有的指令别名

where.exe curl #类似which，查看命令的地址
--> C:\Windows\System32\curl.exe

#这个一次性的，需要加入$profile才永久生效
New-Alias #创建新别名“”（或者Set-Alias）
Remove-Item alias:\curl #删除"curl"这个别名
```



### 网络指令

```bash
ssh：（用管理员打开powershell）
net start sshd   #开启ssh
Get-NetFirewallRule -Name *ssh*   #查看防火墙

# (管理员打开powershell输入这个命令)把默认cmd改成powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force 

#查看端口占用情况
netstat -aon|findstr "1080"
>>> TCP  [::1]:1575     [::1]:1080       ESTABLISHED     9208

tasklist|findstr "9208"
>>> TCP  [::1]:1575     [::1]:1080       ESTABLISHED     9208
```

* [配置ssh：](https://www.cnblogs.com/sparkdev/p/10166061.html)、

## Linux on Win

以GNU套件为主的Liunx编程环境，在Windows上实现主要有四种方式：**虚拟机、双系统、mingw 和 WSL**。而只要不是重度使用，在2020年强烈推荐**mingw +  WSL** 方案。

1. 简单编译c++等c系语言、调试Windows下C系项目 均可以用mingw。

2. 而中度使用Linux系统命令行、Linux非图形界面app调试、跨平台共享文件等，WSL是最佳选择。



### msys2与mingw64:

[windows上msys2配置及填坑](https://hustlei.github.io/2018/11/msys2-for-win.html)

```bash
clang++ -O3 -target x86_64-pc-windows-gnu for.cpp -o for.exe
```



#### [wget](https://eternallybored.org/misc/wget/) on Win





#### [git](https://git-scm.com/downloads) on Win

[安装git：](https://git-scm.com/download/win)、

[git 原理及教程（官方）](https://git-scm.com/book/zh/v2)、

#### [vim](https://www.vim.org/) on Win

[配置vim：](https://segmentfault.com/a/1190000019360991)、



### [WSL](https://docs.microsoft.com/zh-cn/windows/wsl/compare-versions):



windows 应用商店安装Ubuntu 

* 需要在控制面板——程序

```bash
wsl --set-version Ubuntu 2 #将Ubuntu虚拟内核换成WSL2版本
wsl -l -v #查看现有的wsl
wslconfig /list #查看默认的wsl
wsl #进入默认的wsl
wslconfig /setdefault Ubuntu #修改"Ubuntu"为默认的wsl
wsl —shutdown #关闭WSL中的Linux内核
```

#### wsl 解决ls文件夹颜色

```bash
#修改wsl里面查看windows磁盘文件的颜色
dircolors -p > $HOME/.dircolors

vim $HOME/.dircolors
#将 STICKY_OTHER_WRITABLE 后面的数字改成02;32
#将 OTHER_WRITABLE 后面的数字改成01;34

#然后在$HOME/.bashrc(如果用zsh, $HOME/.zshrc)后面添加:
eval $(dircolors -b $HOME/.dircolors)
```



## 动态库

[windows动态库位置](https://www.cnblogs.com/tocy/p/windows_dll_searth_path.html)、



## 软件

[10个经验的国产软件](https://sspai.com/post/42153)、

- [ ] geek                卸载软件
- [ ] quicklook        空格预览
- [ ] freefilesync    本地同步文件
- [ ] Rufus              启动盘（2020直接[Windows官网](https://go.microsoft.com/fwlink/?LinkId=691209)自动下载制作启动盘）
- [ ] potplayer        看视频
- [ ] f.lux                 调色温
- [ ] 华为管家        避免过充
- [ ] sublime          文本编辑器
- [ ] Typora            Markdown
- [ ] Bandzip          解压缩软件
- [ ] Wisedata Recovery 数据恢复
- [ ] 火绒                杀毒软件
- [ ] Listary/everything   搜索
- [ ] XMind             思维导图
- [ ] Snipaste         截图
- [ ] FDM                下载

