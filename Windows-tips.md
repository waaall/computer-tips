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
> 1. 添加鼠标右键新建项：对应**单击桌面空白处**，新建菜单中的项目对应注册表中的位置 ：
>
> HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Discardable\PostSetup\ShellNew
>
> 2. 鼠标单击桌面：**桌面空白处点击右键菜单**对应注册表位置：
>
> HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers
>
> 3. 右键单击文件：鼠标**右键文件**，弹出的菜单项对应注册表中的位置：
>
> HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers
>
> 4. 单机文件夹：鼠标**右键文件夹**，弹出的菜单项对应注册表中的位置：
>
> HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers
>
> 5. 鼠标单击ie浏览器里：鼠标**右键在IE浏览器**里，弹出的菜单明细对应注册表中的位置：
>
> HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt

### win11修改任务栏大小

1. 打开运行，输入“regedit”来启动注册表编辑器；　
2. 定位到“HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\”
3. 新建一个DWORD值，将其命名为“TaskbarSi”；
4. 修改这个值的数据，可以将它修改为0、1和2，分别对应小、中、大尺寸。
5. 保存后关闭注册表编辑器，重启Windows资源管理器进程，即可看到变化了。

## Cmd

[CMD脚本](https://wsgzao.github.io/post/windows-batch/)、

[右键打开CMD](https://lanlan2017.github.io/blog/ed5250a2/)、

* [Start命令](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/start)、

 * 命令1 & 命令2 & 命令3 ... (无论前面命令是否故障,照样执行后面)   
 * 命令1 && 命令2 && 命令3....(仅当前面命令成功时,才执行后面)   
 * 命令1 || 命令2 || 命令3.... (仅当前面命令失败时.才执行后面)

```powershell
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

### 常用指令

```powershell
#找可执行文件的位置，类似Unix中的which或whereis
where.exe atomsk
C:\software\bin\atomsk
C:\software\bin\atomsk.exe


start . #用文件管理器打开当前文件夹（ii .也可以）
Get-Alias #查看现在有的指令别名

where.exe curl #类似which，查看命令的地址
--> C:\Windows\System32\curl.exe

#这个一次性的，需要加入$profile才永久生效
New-Alias #创建新别名“”（或者Set-Alias）
Remove-Item alias:\curl #删除"curl"这个别名
```

### windows 终端设置代理
```shell
# cmd
set http_proxy=http://127.0.0.1:代理服务器本地端口号
set https_proxy=http://127.0.0.1:代理服务器本地端口号

#powershell
$Env:http_proxy="http://127.0.0.1:代理服务器本地端口号"
$Env:https_proxy="http://127.0.0.1:代理服务器本地端口号"

$Env:ALL_proxy="http://127.0.0.1:代理服务器本地端口号"

#git代理 （因为大部分终端网络问题都是github的问题，所以这种情况可以只设置git代理）
git config --global https.proxy http://127.0.0.1:代理服务器本地端口号
git config --global https.proxy https://127.0.0.1:代理服务器本地端口号

#git取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
```


### mklink
mklink，有点像Unix中的ln指令，又有些不同，它和Windows下的快捷方式也有些不同

|                  | 不带参数      | `/D` 参数              | `/H` 参数      | `J` 参数               |
| :--------------- | :------------ | :--------------------- | :------------- | :--------------------- |
| 中文名称         | 符号链接      | 符号链接               | 硬链接         | 联接                   |
| 英文名称         | Symbolic Link | Symbolic Link          | Hard Link      | Junction               |
| 作用对象         | 文件          | 目录                   | 文件           | 目录                   |
| 是否一定指向路径 | 否            | 否                     | 否             | 是                     |
| `dir` 类型       | `SYMLINK`     | `SYMLINK`              | 无特殊显示     | `JUNCTION`             |
| 资源管理器类型   | `.symlink`    | 文件夹                 | 无特殊显示     | 文件夹                 |
| 资源管理器图标   | 快捷方式      | 文件夹快捷方式         | 无特殊显示     | 文件夹快捷方式         |
| 修改同步         | 是            | 是                     | 是             | 是                     |
| 删除同步         | 否            | 否                     | 否             | 否                     |
| 彻底删除源       | 删除源路径    | 删除源路径             | 删除所有硬链接 | 删除源路径             |
| 引用错误报错     | 无            | 引用了一个不可用的位置 | -              | 引用了一个不可用的位置 |

```powershell
mklink source_link.txt source.txt		#为文件创建符号链接
mklink /D source_link source			#为文件夹创建符号链接

#下面这几步让Ubuntu和powershell都可以使用atomsk指令，且只需要将bin文件夹加入系统环境变量即可

# mklink /H bin\atomsk atomsk-win\atomsk.exe	#这是用cmd，用powershell或者wsl使用下面指令 
cmd.exe /c mklink /H 'bin\atomsk' 'atomsk-win\atomsk.exe'	#为文件创建硬链接
cmd.exe /c mklink /H 'bin\atomsk.exe' 'atomsk-win\atomsk.exe'
cmd.exe /c mklink /H 'bin\cmake.exe' 'c-compiler\cmake\bin\cmake.exe'

cmd.exe /c mklink /H 'bin\vim.exe' 'Vim\vim82\vim.exe'	#windows下使用vim，但实际上Windows下vim不需要加入环境变量，因为它在windows文件夹下创建了一个vim.bat，用来启动vim
```


### 网络指令
```powershell
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

* [配置ssh：](https://www.cnblogs.com/sparkdev/p/10166061.html)

### 磁盘管理

#### [Diskpart](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart) : 

```powershell
list disk
list partition
list volume
list vdisk

select disk
select partition
select vdisk
select volume

assign letter=e
```

#### Winfr [命令](https://support.microsoft.com/en-us/windows/recover-lost-files-on-windows-10-61f5b28a-f5b8-3cc2-0f8e-a63cb4e1d4c4)：

> 1. If necessary, [download and launch the app](https://www.microsoft.com/store/r/9N26S50LN705) from the Microsoft Store.
> 2. Press the Windows key, enter **Windows File Recovery** in the search box, and then select **Windows File Recovery.**
> 3. When you are prompted to allow the app to make changes to your device, select **Yes**.
> 4. In the **Command Prompt** window, enter the command in the following format:

```powershell
winfr source-drive: destination-drive: [/switches]
```


##### Default mode examples

Recover a specific file from your C: drive to the recovery folder on an E: drive：

```powershell
winfr C: E: /n \Users\<username>\Documents\QuarterlyStatement.docx
```


Recover jpeg and png photos from your Pictures folder to the recovery folder on an E: drive：

```powershell
winfr C: E: /n \Users\<username>\Pictures\*.JPEG /n \Users\<username>\Pictures\*.PNG
```


Recover your Documents folder from your C: drive to the recovery folder on an E: drive.

```powershell
winfr C: E: /n \Users\<username>\Documents\
```

Don’t forget the backslash (\) at the end of the folder.

##### Segment mode examples (/r)

Recover PDF and Word files from your C: drive to the recovery folder on an E: drive.
```powershell
winfr C: E: /r /n *.pdf /n *.docx
```

Recover any file with the string "invoice" in the filename by using wildcard characters.
```powershell
winfr C: E: /r /n *invoice*
```

##### Signature mode examples (/x)**

When using signature mode, it's helpful to first see the supported extension groups and corresponding file types.
```powershell
winfr /#
```

Recover JPEG (jpg, jpeg, jpe, jif, jfif, jfi) and PNG photos from your C: drive to the recovery folder on an E: drive.
```powershell
winfr C: E: /x /y:JPEG,PNG
```

Recover ZIP files (zip, docx, xlsx, ptpx, and so on) from your C: drive to the recovery folder on an E: drive.

```powershell
winfr C: E:\RecoveryTest /x /y:ZIP
```

1. When you are prompted for confirmation to continue, enter **Y** to start the recovery operation.

   Depending on the size of your source drive, this may take a while.

   To stop the recovery process, press Ctrl+C.

#### fsutil [指令](https://docs.microsoft.com/zh-cn/windows-server/administration/windows-commands/fsutil)：


#### chkdsk [指令](https://docs.microsoft.com/zh-cn/windows-server/administration/windows-commands/chkdsk)：

检查卷的文件系统和文件系统元数据，以查找逻辑错误和物理错误。 如果在没有参数的情况下使用， **chkdsk** 只显示卷的状态，并且不会修复任何错误。 如果与 **/f**、 **/r**、 **/x**或 **/b** 参数一起使用，则会修复卷上的错误。

## Linux on Win

以GNU套件为主的Liunx编程环境，在Windows上实现主要有四种方式：**虚拟机、双系统、mingw 和 WSL**。而只要不是重度使用，在2020年强烈推荐**mingw +  WSL** 方案。

1. 简单编译c++等c系语言、调试Windows下C系项目 均可以用mingw。

2. 而中度使用Linux系统命令行、Linux非图形界面app调试、跨平台共享文件等，WSL是最佳选择。

### msys2与mingw64:

[windows上msys2配置及填坑](https://hustlei.github.io/2018/11/msys2-for-win.html)

使用 MSYS2 時，實際上我們有五種終端機環境：

MinGW 32 bit：原生的 Windows 終端機環境，使用 32 bit 的 MinGW，搭配 msvcrt，用於編譯 32 位元的 Windows 原生軟體
MinGW 64 bit：原生旳 Windows 終端機環境，使用 64 bit 的 MinGW，搭配 msvcrt，用於編譯 64 位元的 Windows 原生軟體
UCRT 64 bit：原生的 Windows 終端機環境，使用 64 bit 的 MinGW，搭配 ucrt，用於編譯 64 位元的 Windows 10 原生軟體
Clang 64 bit：原生的  Windows 終端機環境，使用 64 bit 的 Clang，搭配 ucrt，用於編譯 64 位元的 Windows 10 原生軟體
MSYS：特殊的 POSIX 子系統，僅用於編譯和安裝套件
我們要安裝套件時，會使用 MSYS 終端機環境，而要編譯 Windows 原生軟體時，就會回到其他終端機環境。現在 MSYS2 終端機環境的選擇比先前多了。不用感到慌亂，同一時間只會用到一種終端機環境。隨自己的需求來選擇即可。

MSYS2 在不同子環境下，可用的套件相異。msys2 的套件有五種字首：

mingw-w64-i686：用於 MinGW 32 bit 終端機環境中
mingw-w64-x86_64：用於 MinGW 64 bit 終端機環境中
mingw-w64-ucrt-x86_64：用於 UCRT 64 bit 終端機環境中
mingw-w64-clang-x86_64：用於 Clang 64 bit 終端機環境中



```powershell
# 打开msys2命令行
pacman -S mingw-w64-x86_64-toolchain
# 再找到安装位置，加入环境变量

# clang++ -O3 -target x86_64-pc-windows-gnu for.cpp -o for.exe
```


#### [wget](https://eternallybored.org/misc/wget/) on Win

#### [git](https://git-scm.com/downloads) on Win
[安装git：](https://git-scm.com/download/win)、
[git 原理及教程（官方）](https://git-scm.com/book/zh/v2)、

#### [vim](https://www.vim.org/) on Win
[配置vim：](https://segmentfault.com/a/1190000019360991)、

### [WSL](https://docs.microsoft.com/zh-cn/windows/wsl/compare-versions)

安装：
1. 打开windows功能 --- 打开 WSL(Linux子系统) 和 虚拟化相关系统功能。

如果家庭版没有HyperV功能：
```bash
@echo off
Pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
```
就把这个保存为`hyper-v-enable.bat`管理员执行一下，然后等着重启就好了。

2. 如果有小飞机就加上 `--web-download`,这会在github下载而不是微软商店。
```powershell
wsl --update --web-download
# wsl --set-version Ubuntu 2 #将Ubuntu虚拟内核换成WSL2版本，但现在默认就是2
wsl -l -v #查看现有的wsl
# wsl --install -d Ubuntu-24.04 --web-download
```


#### windows 访问wsl位置
```bash
# 在文件管理器地址栏输入：
\\wsl$
```


#### wsl网络问题
在windows用户目录下面创建一个配置文件 .wslconfig，写入以下内容：
注：这个现在也有可视化操作，就是wsl settings这个软件。
```bash
[experimental]
autoMemoryReclaim=gradual
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```
然后就可以在wsl中输入以下指令可使用windows代理：(7890换成自己小飞机的端口号)
```bash
# export ALL_PROXY=socks5://127.0.0.1:7890
export ALL_PROXY=http://127.0.0.1:7897
unset ALL_PROXY
```

- 常用指令
```powershell
wslconfig /list #查看默认的wsl
wsl #进入默认的wsl
wslconfig /setdefault Ubuntu #修改"Ubuntu"为默认的wsl
wsl —shutdown #关闭WSL中的Linux内核
```
#### wsl 解决ls文件夹颜色
```powershell
#修改wsl里面查看windows磁盘文件的颜色
dircolors -p > $HOME/.dircolors

vim $HOME/.dircolors
#将 STICKY_OTHER_WRITABLE 后面的数字改成02;32
#将 OTHER_WRITABLE 后面的数字改成01;34

#然后在$HOME/.bashrc(如果用zsh, $HOME/.zshrc)后面添加:
eval $(dircolors -b $HOME/.dircolors)
```


#### wsl 安装错误

```
Could not write value to key \SOFTWARE\Classes\Directory\Background\shell\WSL.   
Verify that you have sufficient access to that key, or contact your support personnel.wsl:  
WSL 安装似乎已损坏 (错误代码： Wsl/CallMsi/Install/ERROR_INSTALL_FAILURE)。  
按任意键修复 WSL，或 CTRL-C 取消。  
此提示将在 60 秒后超时。
```

解决方案：
1. 去[github wsl release](https://github.com/microsoft/WSL/releases)下载stable baoa版本手动安装。
2. 再关上代理去微软应用shang d商店下载ubuntu或其他版本。


## 动态库

[windows动态库位置](https://www.cnblogs.com/tocy/p/windows_dll_searth_path.html)

## 软件
### 包管理器
- [Windows 系统缺失的包管理器：Chocolatey、WinGet 和 Scoop](https://sspai.com/post/65933)

如果c盘空间太少，且D盘也是固态硬盘，建议安装到D盘，否则默认安装。
#### chocolatey/[choco](https://github.com/chocolatey/choco)
```bash
# 1. 安装到D盘，实际上就是加一个环境变量（独立与path的）制定其安装目录，自己搜索系统环境变量添加一个也可。自己改记得还要检查下path
$env:ChocolateyInstall = 'D:\Develop\Chocolatey'
[Environment]::SetEnvironmentVariable('ChocolateyInstall', $env:ChocolateyInstall, 'User')
# Machine意味着全局，一般不用
[Environment]::SetEnvironmentVariable('ChocolateyInstall', $env:ChocolateyInstall, 'Machine')

## 2. 安装
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## 3. 使用
choco upgrade chocolatey
```
#### [scoop](https://github.com/ScoopInstaller/Scoop)

```bash
## 1. 安装到D盘，实际上就是加一个环境变量（独立与path的）制定其安装目录，自己搜索系统环境变量添加一个也可。自己改记得还要检查下path
$env:SCOOP='D:\Develop\scoop' 
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

## 2. 安装
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

## 3. 使用
scoop install sudo
scoop update
sudo scoop install pyenv
sudo scoop install 7zip --global
```
#### [winget](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/)
安装，win新系统就有，无需安装。
[WinGet CLI Settings](https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md#winget-cli-settings)

You can configure WinGet by editing the `settings.json` file. Running `winget settings` will open the file in the default json editor; if no editor is configured, Windows will prompt for you to select an editor, and Notepad is a sensible option if you have no other preference.

[File Location](https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md#file-location)
Settings file is located in %LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json

If you are using the non-packaged WinGet version by building it from source code, the file will be located under %LOCALAPPDATA%\Microsoft\WinGet\Settings\settings.json

[Source](https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md#source)

The `source` settings involve configuration to the WinGet source.

```json
    "source": {
        "autoUpdateIntervalInMinutes": 3
    },
```


### UWP软件

- [ ] quicklook                        空格预览
- [ ] Windows Terminal         官方终端
- [ ] Ubuntu                            官方Linux虚拟机
- [ ] twinkle Tray                    调外接显示器亮度
- [ ] powertoys                      官方小工具（包括键盘映射等）

### 官网下载
- [ ] [geek](https://geekuninstaller.com/download)                                  卸载软件
- [ ] [windows File Recovery](https://www.microsoft.com/store/r/9N26S50LN705) 文件恢复（官方）/`winfr`
- [ ] [freefilesync](https://freefilesync.org/)                     本地同步文件
- [ ] [Rufus](https://rufus.ie/)                                启动盘（2020直接[Windows官网](https://go.microsoft.com/fwlink/?LinkId=691209)自动下载制作启动盘）
- [ ] [potplayer](https://potplayer.daum.net/)                         看视频
- [ ] [f.lux](https://justgetflux.com/)                                  调色温
- [ ] [sublime](https://www.sublimetext.com)                           文本编辑器
- [ ] [Typora](https://typora.io)                             Markdown（不行了）
- [ ] [Bandzip](https://cn.bandisoft.com/bandizip/)/ 7zip                 解压缩软件
- [ ] [火绒](https://www.huorong.cn/)                                 杀毒软件（防流氓）
- [ ] [Listary](https://www.listary.com/)/everything         搜索
- [ ] [XMind](https://www.xmind.cn)                             思维导图
- [ ] [FDM](https://www.freedownloadmanager.org/zh/)                                下载
[10个经验的国产软件](https://sspai.com/post/42153)


### github开源
- [PDFMathTranslate](https://github.com/Byaidu/PDFMathTranslate)： 翻译PDF文档
- [卡卡字幕助手](https://github.com/WEIFENG2333/VideoCaptioner)： 视频下载+字幕生成+翻译


## 一些小问题

### cuda和cudnn
CUDA（Compute Unified Device Architecture）是 NVIDIA 的通用 GPU 编程模型和 API 框架。
- **核心功能**: 
    - 提供 C/C++/Fortran 等语言的 GPU 编程接口
    - 管理 GPU 内存、线程调度和硬件加速计算
    - 实现 CPU-GPU 异构计算

cuDNN（CUDA Deep Neural Network Library）：专门为深度神经网络优化的 GPU 加速库。
- **核心功能**：
    - 高效实现卷积、池化、归一化等神经网络层
    - 支持 FP16/FP32 精度自动混合计算
    - 提供 Winograd 等加速算法

- [What is the CUDA Software Platform?](https://modal.com/gpu-glossary/host-software/cuda-software-platform)
具体cuda软硬件架构见上述链接和官网资料。

pytorch 安装cuda版会自带安装cuda&cudnn的动态库，无需再安装nvidia的工具包（包括nvcc等等）
#### 版本
```bash
# 该指令知识查看当前硬件&驱动可以安装的最高cuda版本，并不代表安装了cuda
nvidia-smi

# 该指令一般是安装了官方的cuda组件（即包含了nvcc编译器）之后可以查看
nvcc -V
```

#### pytorch cuda&cudnn动态库
- [pytorch官方安装](https://pytorch.org/get-started/locally/)

#### nvidia官方cuda工具包
- [cuda-downloads](https://developer.nvidia.com/cuda-downloads)
- [cudnn-archive](https://developer.nvidia.com/rdp/cudnn-archive)
上述链接是官方下载的，cudnn是个压缩包，对应的文件放到cuda的同名的安装目录中即可。

#### 无法调用？
pytorch显示没有GPU占用---nvidia-smi和windows的任务管理器都有统计问题，CUDA是默认不在统计范围。在windows的任务管理器-性能-GPU中可以把默认的copy换成Cuda就可以看到CUDA是可以被调用的。


### 屏幕对比度、亮度、色域明显降低问题

这是一般显卡驱动的问题，AMD、intel都有此问题。显卡驱动一般都有亮度自动调节之类的这个选项，关了就可以。



#### AMD显卡

![amd显卡设置](Windows-tips.assets/amd显卡设置.png)

#### intel 显卡

![intel显卡设置](Windows-tips.assets/intel显卡设置.webp)



这里我要多说几句，首先就是亮度自适应调节，本不应该影响色域，使屏幕明显颜色失真，所以这个技术很不合格。再就是强调一下时效性，截止到2021年Windows普遍存在这个问题，往往也和电源管理挂钩。

比如风扇转速的问题，屏幕显示的问题，最好在windows设置-显示中，把关于能效的管理策略取消，包括在高级电源管理设置中的诸多选项，可以自定义设置下相关问题，目前的这种“智能”，挺智障的，若真是笔记本电量不足，可以认为的调低电量、关下后台应用等。

### 输入法无法改中文标点

setting - time&language - Language&region - options - keyboard/Microsoft Pinyin - General ：关闭「Use English punctuations when in Chinese input mode」

### 不同外接屏幕无法记住设置的缩放系数
setting - System - Display - Scale 开启[自动scale，也就是关闭用户自己设置缩放系数]


### 网线连接给ubuntu
1. 连接到wifi后，打开“网络和设置中心”——“更改适配器设置”——“找到你当前的无线网卡”——属性——共享——“允许”，下面选择本地连接——确认框，确定——确定。
2. 将本地连接ip设置为 192.168.137.1，子网掩码自动生成 (一般是默认不用改)
3. ubuntu一般不用设置，都自动就可以。


## windows 新电脑设置流程

### windows 开始不登录

#### 新电脑
**在联网之前这样操作：**
1.  shift Fn F10
2. OOBE\BypassNRO.cmd
3. 重启后，计算机再次进入基本设置界面，按界面提示操作，当再次进入让我们为你连接到网络界面，将出现我没有 Internet 连接（或暂时跳过）选项，点击我没有 Internet 连接（或暂时跳过）。
4. 点击继续执行受限设置或许可协议，将进入下一个操作界面，此时，您已跳过网络连接操作，请您按界面提示完成其他配置，进入到 Windows 系统中。

**在联网之后这样操作：**
1.  shift Fn F10
2. OOBE\BypassNRO.cmd
3. 重启后，点击

#### 取消密码
1. 按下Win + R （）组合键，输入 `netplwiz`，然后按回车键。﻿
2. 在“用户帐户”窗口中，找到要取消密码的账户，取消勾选“要使用本计算机，用户必须输入用户名和密码”。﻿
3. 点击“应用”，然后输入当前密码，点击“确定”。﻿
4. 重启电脑，现在应该可以直接进入桌面，无需输入密码。

## 安装可视化软件
- 火绒
- QQ
- 微信
- 腾讯会议
- [potplayer](https://potplayer.tv)
- vscode
- [7zip](https://www.7-zip.org)
- powertoys

## 安装dev
- [chatbox](https://chatboxai.app/en)
- [git](https://git-scm.com/downloads/win)
- python
- Windows Terminal  （微软应用商店）
### oh-my-posh

1. 先安装包管理器
```powershell
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


PS C:\Users\zxll> set-executionpolicy remotesigned

###库操作
Import-Module PackageManagement
Install-PackageProvider -Name NuGet -Force
Install-Module -Name PowerShellGet -Force
Update-Module
Get-InstalledModule

Install-Module -Name PSReadLine -Force
Install-Module posh-git -Scope CurrentUser

```
2. 安装 oh my posh 在微软应用商店就可以安装

#### PROFILE
```powershell
# 编写PROFILE文件，见下
code $PROFILE
```

```powershell
# 引入 posh-git
Import-Module posh-git

# 引入 ps-read-line
Import-Module PSReadLine


#### 下面这些不用。

# # 添加主题
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\Pararussel.omp.json" | Invoke-Expression
#------------------------------- Import Modules END   -------------------------------

#-------------------------------  Set Hot-keys BEGIN  -------------------------------
# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
#-------------------------------  Set Hot-keys END    -------------------------------
```
 
 
 
### wsl
 [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
 更多具体细节看上面章节。
#### wsl换源
- [ubuntu清华源](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)
在 Ubuntu 24.04 之前，Ubuntu 的软件源配置文件使用传统的 One-Line-Style，路径为 `/etc/apt/sources.list`；从 Ubuntu 24.04 开始，Ubuntu 的软件源配置文件变更为 DEB822 格式，路径为 `/etc/apt/sources.list.d/ubuntu.sources`。
```vim
Types: deb
URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
# Types: deb-src
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: noble noble-updates noble-backports
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
Types: deb
URIs: http://security.ubuntu.com/ubuntu/
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# Types: deb-src
# URIs: http://security.ubuntu.com/ubuntu/
# Suites: noble-security
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# 预发布软件源，不建议启用

# Types: deb
# URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# Suites: noble-proposed
# Components: main restricted universe multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

# # Types: deb-src
# # URIs: https://mirrors.tuna.tsinghua.edu.cn/ubuntu
# # Suites: noble-proposed
# # Components: main restricted universe multiverse
# # Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
```
#### windows 访问wsl位置
```bash
# 在文件管理器地址栏输入：
\\wsl$
```

#### wsl网络问题
在windows用户目录下面创建一个配置文件 .wslconfig，写入以下内容：
注：这个现在也有可视化操作，就是wsl settings这个软件。
```bash
[experimental]
autoMemoryReclaim=gradual
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```
然后就可以在wsl中输入以下指令可使用windows代理：(7890换成自己小飞机的端口号)
```bash
# export ALL_PROXY=socks5://127.0.0.1:7890
export ALL_PROXY=http://127.0.0.1:7897
unset ALL_PROXY
```

 

- [arm-gnu-toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
	- Windows (mingw-w64-x86_64) hosted cross toolchains 
	- AArch32 bare-metal target (arm-none-eabi)


- [clash-verge](https://github.com/clash-verge-rev/clash-verge-rev/releases/)
- chocolate & scoop 见上
