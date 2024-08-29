mac 日常瞎搞


[toc]

## macbook 字小问题
Mac上的字体选择：尽量不要改缩放比例，这样会导致不清楚（可能是非点对点渲染问题？）如果字太小，在辅助设置里选择大号字体，macbookpro14为例，我觉得15pt正好，14也OK。但是有些软件内不会改，比如sublime需要设置成15，上下行间距3；obsidian需要设置成16才不会太小。另外menubar size设成large；还可以在Apparence里把sidebar size设置成large。
如果使用27寸4k外接显示器的设置，由于缩放比例不同则完全不同，可能默认13或14就ok。

## mac 终端标题显示问题

### 取消ohmyzsh自动标题

```shell
vim ~/.zshrc

# 将下面代码粘贴到`~/.zshrc`文件中

```

### 在terminal设置中选择显示内容

> 来源：https://support.apple.com/zh-cn/guide/terminal/trmlwindw/mac
>
> 使用“终端”中的“窗口”偏好设置来更改[“终端”窗口描述文件](https://support.apple.com/zh-cn/guide/terminal/trml107/2.10/mac/10.15)的标题、大小、回滚限制及其他行为。
>
> 若要在 Mac 上的“终端” App ![img](https://help.apple.com/assets/5D92A6940946227D4301035B/5D92A6A50946227D43010362/zh_CN/31d7054c3bcf00abcba6dd75555bcff0.png) 中更改这些偏好设置，请选取“终端”>“偏好设置”，点按“描述文件”，选择一个描述文件，然后点按“窗口”。
>
> ***【注】*您在此偏好设置面板中选取的选项仅应用于所选的描述文件。这些设置不会应用到整个“终端” App。**
>
> |   选项      |                             描述                             |
>| :------:     | :----------------------------------------------------------: |
> |   标题      |         若要更改“终端”窗口的标题，请在栏中输入名称。         |
> |   目录      | 请选择“工作目录或文稿”。选择“路径”复选框以显示目录或文稿路径。 |
> |   进程      |   若要在标题栏中显示活跃进程的名称，请选择“活跃进程名称”。   |
> | shell名     | 若要显示正在运行 shell 命令的名称，请选择“Shell 命令名称”复选框。 |
> |  终端名    |          若要显示终端名称，请选择“TTY 名称”复选框。          |
> |  自变量    |          选择“自变量”复选框以在标题栏中显示自变量。          |
> | 窗口大小 |           若要显示窗口的大小，请选择“尺寸”复选框。           |
> |   命令      |   若要显示可用于使窗口活跃的命令键，请选择“命令键”复选框。   |
> 



## mac 修改用户名的诸多问题

当我想改用户名时

![img](https://pic2.zhimg.com/v2-87af9be8368e7015a9de2bd61aa6a811_b.jpg)

如果我们也改了个人目录名，那么重启后会发现个人配置全全全没了！！！这是不要担心，因为我们改了个人目录名称其实就是创建了个新的用户根目录，电脑重启后是从新的目录里运行数据的，所以我们也不需要参照网上那些从原目录复制所有文件到新目录下，那样一些隐藏或者 程序配置文件复制过去可能还会有一系列的路径不对问题。我们只需要重新把绿色的个人目录改成原目录就行了！改回去后，重启，OK了。

那么问题来了，为什么这么多设置都是在个人文件夹里，都在哪里呢？**系统设置，如账号、壁纸、诸多设置都储存在`Users/your name/Library`中，而很多非可视化、非系统的配置如ssh、zsh、vim等，都是直接在用户目录以`.ssh`、`.zshrc`等隐藏文件的形式存在的。**

## mac apple watch 解锁失败

我终于解决了！我在控制台中发现了一堆与“自动解锁”相关的错误，这提示我Mac上存在一些无效状态，按键和操作杆未正确重置。清除/重置它们后，我现在可以成功将watchOS 7 Series 5与macOS 10.15.7配对。

- 打开“钥匙串访问”，
- 在“查看”中，启用“显示不可见项”，
  ![image](http://media.baobao.zj.cn/image_1601091085633.png)
- 搜索“autolock” 或者“auto lock”，您应该看到一大堆“Auto Unlock：XXXX的...”应用程序密码。
  ![image](http://media.baobao.zj.cn/image_1601091127399.png)
- 选择所有记录并删除（如果您使用多台Mac，这将在其他Mac上重置/禁用自动解锁），删除以上图片中红色框中的文件
- 仍在“钥匙串访问”中，搜索“自动解锁”（无空格），“ tlk”，“ tlk-nonsync”，“ classA”，“ classC”应该有4个条目选择4条记录并删除（不必担心它们会再次出现，系统会自动对其进行修复）
- 打开“ 终端”
  ![image](mac_python版本.assets/image_1601091149125.png)
- 导航到 “~/Library/Sharing/AutoUnlock"
  ![image.png](http://media.baobao.zj.cn/image_1601091451806.png)
- 应该有两个文件“ ltk.plist”和“ pairing-records.plist”，
  ![image.png](http://media.baobao.zj.cn/image_1601091516323.png)
  ![image.png](http://media.baobao.zj.cn/image_1601091531748.png)

```
rm -rf ltk.plist

rm -rf pairing-records.plist
```

- 通过以上命令删除这两个文件

**重启Mac** 

- 最后打开“系统偏好设置”，然后尝试启用自动解锁。您可能需要启用两次，第一次尝试将失败。

## mac python 版本链接

```shell
export PATH="/usr/local/opt/python@3.8/libexec/bin:$PATH"
```

### mac隐藏安装包位置

#### ruby：

```shell
By default, binaries installed by gem will be placed into:
  /usr/local/lib/ruby/gems/2.7.0/bin

You may want to add this to your PATH.

ruby is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in parallel can cause all kinds of trouble.

If you need to have ruby first in your PATH run:
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
For compilers to find ruby you may need to set:

export LDFLAGS="-L/usr/local/opt/ruby/lib"

export CPPFLAGS="-I/usr/local/opt/ruby/include"
```



#### python：

```shell
Python has been installed as
  /usr/local/opt/python@3.8/bin/python3
You can install Python packages with
  /usr/local/opt/python@3.8/bin/pip3 install <package>
They will install into the site-package directory
  /usr/local/opt/python@3.8/Frameworks/Python.framework/Versions/3.8/lib/python3.8/site-packages
See: https://docs.brew.sh/Homebrew-and-Python
python@3.8 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.
If you need to have python@3.8 first in your PATH run:
  echo 'export PATH="/usr/local/opt/python@3.8/bin:$PATH"' >> ~/.zshrc
For compilers to find python@3.8 you may need to set:
export LDFLAGS="-L/usr/local/opt/python@3.8/lib"
```

```shell
#运行指令
brew info python@3.8

#结果显示
python@3.8: stable 3.8.4 (bottled)
Interpreted, interactive, object-oriented programming language
https://www.python.org/
/usr/local/Cellar/python@3.8/3.8.4 (4,391 files, 68.4MB)

Poured from bottle on 2020-07-20 at 04:53:00
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/python@3.8.rb

==> Dependencies
Build: pkg-config ✘
Required: gdbm ✔, openssl@1.1 ✔, readline ✔, sqlite ✔, xz ✔

==> Caveats
Python has been installed as
 	/usr/local/bin/python3

Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
`python3`, `python3-config`, `pip3` etc., respectively, have been installed into
 /usr/local/opt/python@3.8/libexec/bin

You can install Python packages with
	pip3 install <package>
They will install into the site-package directory
 	/usr/local/lib/python3.8/site-packages
See: https://docs.brew.sh/Homebrew-and-Python

==> Analytics
install: 549,104 (30 days), 1,346,283 (90 days), 2,071,180 (365 days)
install-on-request: 89,611 (30 days), 113,376 (90 days), 140,430 (365 days)
build-error: 0 (30 days)
```



### pip 更新后报错

```bash
  >>> pip #输入的指令
#下面是报错信息

Traceback (most recent call last):
  File "/usr/local/lib/python3.8/site-packages/pip/_vendor/pkg_resources/__init__.py", line 583, in _build_master
...
...
Traceback (most recent call last):
  File "/usr/local/opt/python/bin/pip3", line 33, in <module>
    sys.exit(load_entry_point('pip==20.1.1', 'console_scripts', 'pip3')())
...
...
pip._vendor.pkg_resources.DistributionNotFound: The 'pip==20.1.1' distribution was not found and is required by the application
```

#### 解决1（修改版本匹配信息）

打开目录`open /usr/local/Cellar/python/3.7.0/bin`(pip的安装目录)，然后用sublime等编辑器打开pip3文件如下：

```bash
#!/usr/local/opt/python/bin/python3.7
# EASY-INSTALL-ENTRY-SCRIPT: 'pip==18.0','console_scripts','pip3'
__requires__ = 'pip==18.0'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('pip==18.0', 'console_scripts', 'pip3')()
    )
123456789101112
```

把里面的`pip==18.0`改成对应报错的版本号即可，我这里改成`pip==19.1.1`，然后，保存。
最后，再次执行`pip3 -V`，如下：

```bash
$ pip3 -V
pip 19.1.1 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
```

#### 解决2(重新链接)

1. > sudo rm -rf `/usr/local/bin/pip3`**注意，这个路径是pip的默认链接路径，可能不一致，具体根据报错信息第二段第一行的路径，比如上述报错信息中就是**`/usr/local/opt/python/bin/pip3`

2. > sudo ln -s `/usr/local/your_python_path/bin/pip3`  /usr/local/bin/pip3
    >
    > 2中第一个路径是你真正python安装的路径，比如我们使用homebrew安装的就是：`/usr/local/Cellar/python@3.8/3.8.5/bin`
    >
    > 值得注意的是，报错信息第一段第一行中`/usr/local/lib/python3.8/site-packages/pip`这个路径是pip包所在的位置，如果我们需要回退pip版本等，甚至可以直接把老版本的包拷贝到这里，而且， 我们需要看下这个文件夹中，**pip版本**，因为报错，我们得不到pip当前版本信息。**下图可以看到是20.2**

<img src="mac_python版本.assets/Screen Shot 2020-08-15 at 10.57.28 AM.png" alt="Screen Shot 2020-08-15 at 10.57.28 AM" style="zoom: 67%;" />

所以对于我们这种情况：

```bash
sudo rm -rf /usr/local/opt/python/bin/pip3
sudo ln -s /usr/local/Cellar/python@3.8/3.8.5/bin/pip3 /usr/local/opt/python/bin/pip3
```

#### 终极解决

这两种方法都不行，我们来看下为什么？

我们最好是根据 **解决1** 中的方法，分别打开`/usr/local/Cellar/python@3.8/3.8.5/bin/pip3 `和`/usr/local/opt/python/bin/pip3`，看一下版本信息是否被更新过了：结果发现并不是链接问题，初始文件就没有更新，我们把下面代码中的`pip==20.1.1`都改为`pip == 20.2`	就OK啦

```python
#!/usr/local/opt/python@3.8/bin/python3.8
# EASY-INSTALL-ENTRY-SCRIPT: 'pip==20.1.1','console_scripts','pip3'
import re
import sys

# for compatibility with easy_install; see #2198
__requires__ = 'pip==20.1.1'

try:
    from importlib.metadata import distribution
except ImportError:
    try:
        from importlib_metadata import distribution
    except ImportError:
        from pkg_resources import load_entry_point


def importlib_load_entry_point(spec, group, name):
    dist_name, _, _ = spec.partition('==')
    matches = (
        entry_point
        for entry_point in distribution(dist_name).entry_points
        if entry_point.group == group and entry_point.name == name
    )
    return next(matches).load()


globals().setdefault('load_entry_point', importlib_load_entry_point)


if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(load_entry_point('pip==20.1.1', 'console_scripts', 'pip3')())
```

最终我们发现，可以了，但是提示我有了20.2.2版本更新。于是我又更新了，果然更新完还是报错，这时我们就可以继续更改我们那个pip3文件：完美解决，PS：这应该是homebrew版本python的bug。
