# Unix tips

任何代码他们的指令都是小写字母组成，为了避免歧义，我们自己定义量和函数时，最好是用大写字母来表示；

每个指令之间都应该用空格隔来，类似代码应该对齐书写，注释要用tab键尽量对齐，不仅美观，且大大增加了易读性。

[google开源代码书写规范](https://zh-google-styleguide.readthedocs.io/en/latest/contents/)

[toc]



## 通用



### 一 Unix 文件系统：

当然，Mac有自己的文件系统，2020年为APFS；Linux也更新了自己的文件系统，2020年为ZFS。但同为Unix内核，很多文件的逻辑依然保持一致，这里只谈一致的问题，不谈具体的文件系统特性。

#### 磁盘分区

> windows是先有硬盘分区，再有分区上的目录。
> linux是先有目录，再有每个目录对应的分区，进入一个分区的目录入口就叫挂载点。
> linux中不是每个目录都是挂载点，通常只要求根目录/是挂载点。其他的目录可以用户自己决定要不要挂载单独的分区，如果不挂载，这个目录实际的存储位置和它的父目录相同。
>
> win和linux的区别主要是文件结构(目录)和物理结构(存储)的侧重不同。目录在linux里是更基础的概念，在目录的基础上安排磁盘分区。win则是相反。



#### 目录结构

根据上述理论，所以磁盘是挂载在目录底下的。

 **[Linux文件系统](http://cn.linux.vbird.org/linux_basic/0210filepermission_3.php)**、 [FHS](https://www.pathname.com/fhs/)、[文件系统层次结构标准维基百科](https://zh.wikipedia.org/zh-cn/文件系统层次结构标准)、



* /(root, 根目录)：与开机系统有关；
* /usr (unix software resource)：与软件安装/执行有关；
* /var (variable)：与系统运作过程有关。
* /etc：配置文件
* /bin：重要执行档
* /dev：所需要的装置文件
* /lib：执行档所需的函式库与核心所需的模块
* /sbin：重要的系统执行文件
* /mnt：
* /swap：虚拟内存（硬盘作为内存）



##### 常见配置文件

>`/etc/profile`
>
> 在用户登录时，操作系统定制用户环境时使用的第一个文件，此文件为系统的每个用户设置环境信息，当用户第一次登录时，该文件被执行。
>
>`/etc /environment`
>
> 在用户登录时，操作系统使用的第二个文件， 系统在读取用户个人的profile前，设置环境文件的环境变量。
>
>`~/.profile`
>
> 在用户登录时，用到的第三个文件 是.profile文件，每个用户都可使用该文件输入专用于自己使用的shell信息，当用户登录时，该文件仅仅执行一次！默认情况下，会设置一些环境变量，执行用户的.bashrc文件。
>
>`/etc/bashrc`
>
> 为每一个运行bash shell的用户执行此文件，当bash shell被打开时，该文件被读取。
>
>`~/.bashrc`
>
> 该文件包含专用于用户的bash shell的bash信息，当登录时以及每次打开新的shell时，该该文件被读取。

用户文件夹里又很多.文件，这些都是系统和软件配置相关的，系统也会把这类文件设为隐藏，我们可以自己创建，以个性化定制app的设置（尤其是以终端为可视化界面的软件）er qi。以vim为例：

* /Users/zxll/.vimrc   #vim用户配置文件
* /Users/zxll/.vim/    #vim用户配置文件夹

##### 永久关闭swap分区

在/ etc / fstab中找到有关swap的行，并对其进行注释。是这样的：

```shell
UUID=6880a28d-a9dc-4bfb-ba47-0876b50e96b3 /               ext4    errors=remount-ro 0       1
UUID=7350e6f2-e3a7-4d80-9a95-8741c7db118f /home           ext4    defaults        0       2
UUID=E2E26AD1E26AAA0D /media/windows  ntfs    defaults,umask=007,gid=46 0       0

# Swap a usb extern (3.7 GB):
#/dev/sdb1 none swap sw 0 0
```

您可以使用gedit编辑该文件。首先备份它，以防万一：

```shell
sudo cp /etc/fstab /etc/fstab_backup
gksu gedit /etc/fstab
```

只需在交换所在行的开头添加＃，然后重新启动计算机即可。


#### 文件链接(非编译链接)

硬链接是指针，所有的硬链接都是指向同一个磁盘块。 删除一个指针不会真正删除文件，只有把所有的指针都删除才会真正删除文件。 软连接是另外一种类型的文件，保存的是它指向文件的全路径， 访问时会替换成绝对路径。具体应用见`mac`中的`链接动态库`一节。

```shell
man ln
#得到下面描述 ========
  指令名称 : ln
  使用权限 : 所有使用者
  使用方式 : ln [options] source dist，其中 option 的格式为 :
  [-bdfinsvF] [-S backup-suffix] [-V {numbered,existing,simple}]
  [--help] [--version] [--]
  说明 : Linux/Unix 档案系统中，有所谓的连结(link)，我们可以将其视为档案的别名，而连结又可分为两种 : 硬连结(hard link)与软连结(symbolic link)，硬连结的意思是一个档案可以有多个名称，而软连结的方式则是产生一个特殊的档案，该档案的内容是指向另一个档案的位置。硬连结是存在同一个档 案系统中，而软连结却可以跨越不同的档案系统。
  ln source dist 是产生一个连结(dist)到 source，至于使用硬连结或软链结则由参数决定。
  不论是硬连结或软链结都不会将原本的档案复制一份，只会占用非常少量的磁碟空间。
  -f : 链结时先将与 dist 同档名的档案删除
  -d : 允许系统管理者硬链结自己的目录
  -i : 在删除与 dist 同档名的档案时先进行询问
  -n : 在进行软连结时，将 dist 视为一般的档案
  -s : 进行软链结(symbolic link)
  -v : 在连结之前显示其档名
  -b : 将在链结时会被覆写或删除的档案进行备份
  -S SUFFIX : 将备份的档案都加上 SUFFIX 的字尾
  -V METHOD : 指定备份的方式
  --help : 显示辅助说明
  --version : 显示版本
```



### 二 守护进程

#### 1. 守护进程概述

Linux Daemon（守护进程）是运行在后台的一种特殊进程。它独立于控制终端并且周期性地执行某种任务或等待处理某些发生的事件。它不需要用户输入就能运行而且提供某种服务，不是对整个系统就是对某个用户程序提供服务。Linux系统的大多数服务器就是通过守护进程实现的。常见的守护进程包括系统日志进程syslogd、 web服务器httpd、邮件服务器sendmail和数据库服务器mysqld等。

守护进程一般在系统启动时开始运行，除非强行终止，否则直到系统关机都保持运行。守护进程经常以超级用户（root）权限运行，因为它们要使用特殊的端口（1-1024）或访问某些特殊的资源。

一个守护进程的父进程是init进程，因为它真正的父进程在fork出子进程后就先于子进程exit退出了，所以它是一个由init继承的孤儿进程。守护进程是非交互式程序，没有控制终端，所以任何输出，无论是向标准输出设备stdout还是标准出错设备stderr的输出都需要特殊处理。

守护进程的名称通常以d结尾，比如sshd、xinetd、crond等

#### 2. 创建守护进程步骤

首先我们要了解一些基本概念：

进程组 ：

> * 每个进程也属于一个进程组 
>
> - 每个进程主都有一个进程组号，该号等于该进程组组长的PID号 .
> - 一个进程只能为它自己或子进程设置进程组ID号 

会话期： 

> 会话期(session)是一个或多个进程组的集合。

setsid()函数可以建立一个对话期：

 如果，调用setsid的进程不是一个进程组的组长，此函数创建一个新的会话期。

> (1)此进程变成该对话期的首进程 
>
> (2)此进程变成一个新进程组的组长进程。 
>
> (3)此进程没有控制终端，如果在调用setsid前，该进程有控制终端，那么与该终端的联系被解除。 如果该进程是一个进程组的组长，此函数返回错误。
>
> (4)为了保证这一点，我们先调用fork()然后exit()，此时只有子进程在运行

现在我们来给出创建守护进程所需步骤：

编写守护进程的一般步骤步骤：

> （1）在父进程中执行fork并exit推出；
>
> （2）在子进程中调用setsid函数创建新的会话；
>
> （3）在子进程中调用chdir函数，让根目录 ”/” 成为子进程的工作目录；
>
> （4）在子进程中调用umask函数，设置进程的umask为0；
>
> （5）在子进程中关闭任何不需要的文件描述符

说明：

1. 在后台运行。 

   > 为避免挂起控制终端将Daemon放入后台执行。方法是在进程中调用fork使父进程终止，让Daemon在子进程中后台执行。 
   > if(pid=fork()) 
   > exit(0);//是父进程，结束父进程，子进程继续 

2. 脱离控制终端，登录会话和进程组 

   > 有必要先介绍一下Linux中的进程与控制终端，登录会话和进程组之间的关系：进程属于一个进程组，进程组号（GID）就是进程组长的进程号（PID）。登录会话可以包含多个进程组。这些进程组共享一个控制终端。这个控制终端通常是创建进程的登录终端。 
   >    控制终端，登录会话和进程组通常是从父进程继承下来的。我们的目的就是要摆脱它们，使之不受它们的影响。方法是在第1点的基础上，调用setsid()使进程成为会话组长： 
   >    setsid(); 
   >    说明：当进程是会话组长时setsid()调用失败。但第一点已经保证进程不是会话组长。setsid()调用成功后，进程成为新的会话组长和新的进程组长，并与原来的登录会话和进程组脱离。由于会话过程对控制终端的独占性，进程同时与控制终端脱离。 

3. 禁止进程重新打开控制终端 

   > 现在，进程已经成为无终端的会话组长。但它可以重新申请打开一个控制终端。可以通过使进程不再成为会话组长来禁止进程重新打开控制终端： 
   > if(pid=fork()) 
   > exit(0);//结束第一子进程，第二子进程继续（第二子进程不再是会话组长） 

4. 关闭打开的文件描述符 

   > 进程从创建它的父进程那里继承了打开的文件描述符。如不关闭，将会浪费系统资源，造成进程所在的文件系统无法卸下以及引起无法预料的错误。按如下方法关闭它们： 
   > for(i=0;i 关闭打开的文件描述符close(i);> 

5. 改变当前工作目录 

   > 进程活动时，其工作目录所在的文件系统不能卸下。一般需要将工作目录改变到根目录。对于需要转储核心，写运行日志的进程将工作目录改变到特定目录如/tmpchdir("/") 

6. 重设文件创建掩模 

   > 进程从创建它的父进程那里继承了文件创建掩模。它可能修改守护进程所创建的文件的存取位。为防止这一点，将文件创建掩模清除：umask(0); 

7. 处理SIGCHLD信号 

   > 处理SIGCHLD信号并不是必须的。但对于某些进程，特别是服务器进程往往在请求到来时生成子进程处理请求。如果父进程不等待子进程结束，子进程将成为僵尸进程（zombie）从而占用系统资源。如果父进程等待子进程结束，将增加父进程的负担，影响服务器进程的并发性能。在Linux下可以简单地将SIGCHLD信号的操作设为SIG_IGN。 
   > signal(SIGCHLD,SIG_IGN); 
   > 这样，内核在子进程结束时不会产生僵尸进程。这一点与BSD4不同，BSD4下必须显式等待子进程结束才能释放僵尸进程。 



#### 3. 创建守护进程

在创建之前我们先了解setsid()使用：

```c
 #include <unistd.h>
	pid_t setsid(void);
```

> DESCRIPTION 
>  setsid() creates a new session if the calling process is not a process 
>  group leader. The calling process is the leader of the new session, 
>  the process group leader of the new process group, and has no control- 
>  ling tty. The process group ID and session ID of the calling process 
>  are set to the PID of the calling process. The calling process will be 
>  the only process in this new process group and in this new session.

//调用进程必须是非当前进程组组长，调用后，产生一个新的会话期，且该会话期中只有一个进程组，且该进程组组长为调用进程，没有控制终端，新产生的group ID 和 session ID 被设置成调用进程的PID

> RETURN VALUE 
>  On success, the (new) session ID of the calling process is returned. 
>  On error, (pid_t) -1 is returned, and errno is set to indicate the 
>  error.

现在根据上述步骤创建一个守护进程：

以下程序是创建一个守护进程，然后利用这个守护进程每个一分钟向daemon.log文件中写入当前时间：

```c
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <fcntl.h>
#include <string.h>
#include <sys/stat.h>

#define ERR_EXIT(m) \
do\
{\
    perror(m);\
    exit(EXIT_FAILURE);\
}\
while (0);\

void creat_daemon(void);
int main(void)
{
    time_t t;
    int fd;
    creat_daemon();
    while(1){
        fd = open("daemon.log",O_WRONLY|O_CREAT|O_APPEND,0644);
        if(fd == -1)
            ERR_EXIT("open error");
        t = time(0);
        char *buf = asctime(localtime(&t));
        write(fd,buf,strlen(buf));
        close(fd);
        sleep(60);
            
    }
    return 0;
}
void creat_daemon(void)
{
    pid_t pid;
    pid = fork();
    if( pid == -1)
        ERR_EXIT("fork error");
    if(pid > 0 )
        exit(EXIT_SUCCESS);
    if(setsid() == -1)
        ERR_EXIT("SETSID ERROR");
    chdir("/");
    int i;
    for( i = 0; i < 3; ++i)
    {
        close(i);
        open("/dev/null", O_RDWR);
        dup(0);
        dup(0);
    }
    umask(0);
    return;
}
```


结果：

[![QQ截图20130713184143](https://images0.cnblogs.com/blog/529981/201307/13191708-dc3544d132f64360a4b6ccb54d936958.png)](https://images0.cnblogs.com/blog/529981/201307/13191708-0a54178e53cb4b4b9beaf0962d2415fb.png)

结果显示：当我一普通用户执行a.out时，进程表中并没有出现新创建的守护进程，但当我以root用户执行时，成功了，并在/目录下创建了daemon.log文件，cat查看后确实每个一分钟写入一次。为什么只能root执行，那是因为当我们创建守护进程时，已经将当前目录切换我/目录，所以当我之后创建daemon.log文件是其实是在/目录下，那肯定不行，因为普通用户没有权限，或许你会问那为啥没报错呢？其实是有出错，只不过我们在创建守护进程时已经将标准输入关闭并重定向到/dev/null，所以看不到错误信息。

### 三 shell命令

#### 常用

```shell
uname #查看计算机类型等系统信息

chsh -s /bin/zsh    #设置默认shell为zsh

env  #查看系统全部环境变量
echo $path #仅查看path
env|grep PATH #同样仅查看path

whereis zsh #返回二进制、man文件、src文件等路径
which zsh #shell的path中的二进制文件路径

man ln #查看ln这个指令的说明文档
```

#### 权限

Linux chmod（英文全拼：change mode）命令是控制用户对文件的权限的命令

Linux/Unix 的文件调用权限分为三级 : 文件所有者（Owner）、用户组（Group）、其它用户（Other Users）。

![img](https://www.runoob.com/wp-content/uploads/2014/08/file-permissions-rwx.jpg)

只有文件所有者和超级用户可以修改文件或目录的权限。可以使用绝对模式（八进制数字模式），符号模式指定文件的权限。

![img](https://www.runoob.com/wp-content/uploads/2014/08/rwx-standard-unix-permission-bits.png)

**使用权限** : 所有使用者

##### 语法

```shell
chmod [-cfvR] [--help] [--version] mode file...
```

mode : 权限设定字串，格式如下 :

```shell
[ugoa...][[+-=][rwxX]...][,...]
```

其中：

- u 表示该文件的拥有者，g 表示与该文件的拥有者属于同一个群体(group)者，o 表示其他以外的人，a 表示这三者皆是。
- \+ 表示增加权限、- 表示取消权限、= 表示唯一设定权限。
- r 表示可读取，w 表示可写入，x 表示可执行，X 表示只有当该文件是个子目录或者该文件已经被设定过为可执行。

其他参数说明：

- -c : 若该文件权限确实已经更改，才显示其更改动作
- -f : 若该文件权限无法被更改也不要显示错误讯息
- -v : 显示权限变更的详细资料
- -R : 对目前目录下的所有文件与子目录进行相同的权限变更(即以递归的方式逐个变更)
- --help : 显示辅助说明
- --version : 显示版本

##### 符号模式

使用符号模式可以设置多个项目：who（用户类型），operator（操作符）和 permission（权限），每个项目的设置可以用逗号隔开。 命令 chmod 将修改 who 指定的用户类型对文件的访问权限，用户类型由一个或者多个字母在 who 的位置来说明，如 who 的符号模式表所示:

| who  | 用户类型 | 说明                   |
| :--- | :------- | :--------------------- |
| `u`  | user     | 文件所有者             |
| `g`  | group    | 文件所有者所在组       |
| `o`  | others   | 所有其他用户           |
| `a`  | all      | 所用用户, 相当于 *ugo* |

operator 的符号模式表:

| Operator | 说明                                                   |
| :------- | :----------------------------------------------------- |
| `+`      | 为指定的用户类型增加权限                               |
| `-`      | 去除指定用户类型的权限                                 |
| `=`      | 设置指定用户权限的设置，即将用户类型的所有权限重新设置 |

permission 的符号模式表:

| 模式 | 名字         | 说明                                                         |
| :--- | :----------- | :----------------------------------------------------------- |
| `r`  | 读           | 设置为可读权限                                               |
| `w`  | 写           | 设置为可写权限                                               |
| `x`  | 执行权限     | 设置为可执行权限                                             |
| `X`  | 特殊执行权限 | 只有当文件为目录文件，或者其他类型的用户有可执行权限时，才将文件权限设置可执行 |
| `s`  | setuid/gid   | 当文件被执行时，根据who参数指定的用户类型设置文件的setuid或者setgid权限 |
| `t`  | 粘贴位       | 设置粘贴位，只有超级用户可以设置该位，只有文件所有者u可以使用该位 |

##### 八进制语法

chmod命令可以使用八进制数来指定权限。文件或目录的权限位是由9个权限位来控制，每三位为一组，它们分别是文件所有者（User）的读、写、执行，用户组（Group）的读、写、执行以及其它用户（Other）的读、写、执行。历史上，文件权限被放在一个比特掩码中，掩码中指定的比特位设为1，用来说明一个类具有相应的优先级。

| #    | 权限           | rwx  | 二进制 |
| :--- | :------------- | :--- | :----- |
| 7    | 读 + 写 + 执行 | rwx  | 111    |
| 6    | 读 + 写        | rw-  | 110    |
| 5    | 读 + 执行      | r-x  | 101    |
| 4    | 只读           | r--  | 100    |
| 3    | 写 + 执行      | -wx  | 011    |
| 2    | 只写           | -w-  | 010    |
| 1    | 只执行         | --x  | 001    |
| 0    | 无             | ---  | 000    |

```shell
#语法为：
chmod abc file
其中a,b,c各为一个数字，分别表示User、Group、及Other的权限。
r=4，w=2，x=1
若要 rwx 属性则 4+2+1=7；
若要 rw- 属性则 4+2=6；
若要 r-x 属性则 4+1=5。
chmod a=rwx file
```



#### 文件相关

```shell
#磁盘管理
diskutil list       # 显示磁盘列表
df -h               # disk free查看磁盘可用空间
lsblk               # 查看所有磁盘和分区

echo $SHELL         #查看当前使用的shell类型
cat /etc/shells     #查看已安装的shell
cat “filename”      #查看文件
pwd                 #查看当前文件路径
ls                  #查看当前文件下有
chmod 777 homebrew.sh #授权sh文件运行、具体见上一节中权限
open .              #打开当前文件夹
#把finder拖入terminal就会自动把绝对路径拷贝到terminal里
pbcopy < /dev/null  #清除剪贴板
pbcopy              #相当于‘cmd’+C

vim /Volumes/files/研究生/friction** # 编辑外置硬盘里的文件(** 表示利用了fzf模糊搜索)
vim ~/.oh-my-zsh/plugins	#这里边装了很多内置的插件，但是默认不开启比如下面这个z
z
  -c    # restrict matches to subdirectories of the current directory
  -h    # show a brief help message
  -l    # list only
  -r    # match by rank only
  -t    # match by recent access only
  -x    # remove the current directory from the datafile

ag read_csv ~/code/ # ag搜索文件内容‘read_csv’ 后边是指定在文件夹‘~/code/’里边 


grep -q "Per MPI" log1.txt  #检查文件log1.txt中是否有“Per MPI”若有，返回0
# https://wangchujiang.com/linux-command/c/grep.html


##=============================sed================================
sed   # https://www.runoob.com/linux/linux-comm-sed.html
	  # https://juejin.im/post/5d669f4bf265da03ea5a8f82
      # http://zhouxiaohong.com/2016/08/02/sed-in-mac/   
      
sed '/^$/d' sed-demo.txt         #删除 sed-demo.txt 中的空行
sed '/^[RF]/d' sed-demo.txt      #删除 R 或者 F 字符开头的所有行
sed '/m$/d' sed-demo.txt         #删除 m 字符结尾的所有行
sed '/[A-Za-z]/d' sed-demo.txt   #删除所有包含字母的行
sed '/^$/{n;/^$/d}' sed-demo.txt #删除重复空行，连续的空行只保留一个替换
sed '/^[[:space:]]*$/d' gra1.txt >gra.txt #将文件gra1.txt删除带有空格的空行，并保存为gra.txt

#下面这个指令是Mac上的“特有的”去除每行前的空格，必须要换  行
LC_CTYPE=C sed -i '' -e '1i \  
   ' log.txt          


cat tmp.txt 
123456789
123456789
123456789

# 删除每行第一个字符
sed 's/.//' tmp.txt 
23456789
23456789
23456789

# 删除每行前两个字符，并保存到tmp2.txt
sed 's/..//' tmp.txt > tmp2.txt
3456789
3456789
3456789

# 删除每行前k个字符，例如k=5
sed 's/.\{5\}//' tmp.txt 
6789
6789
6789

#删除每行开头的空格键和TAB键
sed 's/^[ \t]*//g'

#删除每行结尾的空格键和TAB键
sed 's/[ \t]*$//g'

#删除所有空格
sed 's/[[:space:]]//g'  tmp.txt >aa.txt
cat tmp.txt | sed 's/\ //g'>aa.txt

#删除每行开头的空格
sed 's/^ *//' tmp.txt > tmp2.txt
#或sed 's/^[ ]*//' tmp.txt > tmp2.txt
#或sed 's/^[[:space:]]*//' tmp.txt > tmp2.txt

#删除空行
sed '/^$/d' tmp.txt

#在每行行首添加双引号"
sed 's/^/"&/g' tmp.txt
#在每行行尾添加双引号和逗号
sed 's/$/",&/g' tmp.txt



[[:space:]]表示空格或者TAB的集合
s表示替换命令
/asd/qwe/ 表示匹配asd，并写入qwe
g表示此行中替换所有的匹配
. 表示任何单个字符
*表示某个字符出现了0次或多次
^[ \t]表示以空格或者TAB键开头
^行首，/^#/ 以#开头的匹配 
$行尾，/}$/ 以}结尾的匹配
[ ] 字符集合。 如：[abc]表示匹配a或b或c，还有[a-zA-Z]表示匹配所有的26个字符。如果其中有^表示反，如[^a]表示非a的字符
\< 表示词首。 如 \<abc 表示以 abc 为首的詞
\> 表示词尾。 如 abc\> 表示以 abc 結尾的詞

参数说明：
-e<script>或--expression=<script> 以选项中指定的script来处理输入的文本文件。
-f<script文件>或--file=<script文件> 以选项中指定的script文件来处理输入的文本文件。
-h或--help 显示帮助。
-n或--quiet或--silent 仅显示script处理后的结果。
-V或--version 显示版本信息。
动作说明：
a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！
```

#### 编译相关

```shell
##============================ c系语言 =============================
gcc -v				#查看gcc版本信息
python3             # enter the python shell

g++ 指令# https://www.cnblogs.com/yyehl/p/6862153.html

gcc -Og -S -masm=intel mstore.c #预处理+编译，且汇编语言为intel格式标准，-Og表示不进行优化
g++ -E test.cpp (-o test.i)#预处理, -o是指定输出文件名
g++ -S test.i (-o bala.s) #编译（生成的就是汇编文件）
g++ -c test.s -o balabala.o #汇编，生成的为二进制文件
g++ test.o #链接，就是把相关的#include文件链接起来，生成a.out文件

#单文件直接生成可执行文件
g++ test.cpp
#多文件直接生成可执行文件
g++ test1.cpp test2.cpp

##==============================其他============================
javac test.java #编译java
java test #运行java
```

####  网络相关

```shell
sudo apt install net-tools #安装ifconfig等工具
traceroute www.apple.com #追踪网络连接所跳转的路由器列表
ssh username@ip     # Users/zxll/.ssh/known而且mei ssh 记录着已有信息
scp run/friction.py zxll@192.168.11.15:/home/zxll/run/friction.py #用ssh把本地文件上传到目标服务器，反之亦反

wget https://ram.github.com/Homebrew/install/master/install.sh #这个链接就是把github前加raw，可见，网站和文件不在同一服务器。

https://ram.github.com和https://ram.githubusercontent.com应该都可以

##======================= git =========================
git config --global http.proxy socks5://127.0.0.1:1086
git config --global --unset http.proxy	#取消代理
git config --global --unset https.proxy
#终端设置代理
export ALL_PROXY=socks5://127.0.0.1:1086   #terminal使用sock5代理
unset ALL_PROXY	#取消代理


```

#### screen

```shell
screen -S yourname -> 新建一个叫yourname的session
screen -ls -> 列出当前所有的session
screen -r yourname -> 回到yourname这个session
screen -d yourname -> 远程detach某个session
screen -d -r yourname -> 结束当前session并回到yourname这个session

#在每个screen session 下，所有命令都以 ctrl+a(C-a) 开始。
C-a ? -> #显示所有键绑定信息
C-a c -> #创建一个新的运行shell的窗口并切换到该窗口
C-a n -> #Next，切换到下一个 window 
C-a p -> #Previous，切换到前一个 window 
C-a 0..9 -> #切换到第 0..9 个 window
Ctrl+a [Space] -> #由视窗0循序切换到视窗9
C-a C-a -> #在两个最近使用的 window 间切换 
C-a x -> #锁住当前的 window，需用用户密码解锁
C-a d -> #detach，暂时离开当前session，将目前的 screen session (可能含有多个 windows) 丢到后台执行，并会回到还没进 screen 时的状态，此时在 screen session 里，每个 window 内运行的 process (无论是前台/后台)都在继续执行，即使 logout 也不影响。 
C-a z -> #把当前session放到后台执行，用 shell 的 fg 命令则可回去。
C-a w -> #显示所有窗口列表
C-a t -> #Time，显示当前时间，和系统的 load 
C-a k -> #kill window，强行关闭当前的 window
C-a [ -> #进入 copy mode，在 copy mode 下可以回滚、搜索、复制就像用使用 vi 一样
```



#### curl

```shell
curl ifconfig.me
--->123.112.11.172%


##============================选项===========================
-A/--user-agent <string>              设置用户代理发送给服务器
-b/--cookie <name=string/file>    cookie字符串或文件读取位置
-c/--cookie-jar <file>                    操作结束后把cookie写入到这个文件中
-C/--continue-at <offset>            断点续转
-D/--dump-header <file>              把header信息写入到该文件中
-e/--referer                                  来源网址
-f/--fail                                          连接失败时不显示http错误
-o/--output                                  把输出写到该文件中
-O/--remote-name                      把输出写到该文件中，保留远程文件的文件名
-r/--range <range>                      检索来自HTTP/1.1或FTP服务器字节范围
-s/--silent                                    静音模式。不输出任何东西
-T/--upload-file <file>                  上传文件
-u/--user <user[:password]>      设置服务器的用户和密码
-w/--write-out [format]                什么输出完成后
-x/--proxy <host[:port]>              在给定的端口上使用HTTP代理
-#/--progress-bar                        进度条显示当前的传送状态
```



#### pip

* pip修改镜像源

镜像源：http://mirrors.aliyun.com/pypi/simple/

```shell
[global] #pip.conf来修改默认下载源
index-url=https://pypi.tuna.tsinghua.edu.cn/simple/
[install]
trusted-host=pypi.tuna.tsinghua.edu.cn
```

参考资料：
https://zhuanlan.zhihu.com/p/46975553
https://blog.csdn.net/lixiaozhe_csdn/article/details/94414108

* 指令

```shell
pip install pandas -i https://pypi.tuna.tsinghua.edu.cn/simple/ #pip 换源

#Home-brew安装的python，包所在地址如下
/usr/local/lib/python3.8/site-packages

python -m pip install --upgrade pip #更新pip

pip list --outdated #pip检查有无更新
          
pip install --upgrade 要升级的包名 #更新app

pip show Name #查看Name这个包的具体信息

pip install - -ignore-installed Name #重装最新版插件
```



#### git

---

单独写了一个git的描述文档在learn code里。

git 忽略mac中的`.DS_Store`文件方法见下：

```shell
touch ~/.gitignore_global
```

然后对这个文件进行修改。

```shell
# Mac OS
**/.DS_Store
```

然后对git进行全局设置，让git忽略.gitignore_global中的所有文件：

```shell
git config --global core.excludesfile ~/.gitignore_global
```

这样就不用每个git目录都设置忽略.DS_Store文件了！

#### vim

```shell
##=====================编辑、保存、退出====================
`a`/`i` #在光标处开始编辑: append/insert
`o`		#在下一行开始编辑: open a line
`c`		#删除并插入: change
`ct)`	# change to ）
`ci"`	#把双引号内的删除并插入 : change inner "

`:wq` 		#保存并退出: 
`:w Name` 	#另存为Name
`:q!` 		#强制退出

`esc` #退出编辑模式

##=====================搜索、替换====================
`fs`	#跳转到s这个字母: find s

`/name` #搜索光标以下,回车
`?word` #搜索光标以下,回车
`n`		#光标到下一个搜索结果: next
`:noh` 	#取消搜索后高亮 
`N` 	#反向上一个搜索

`:%s/preword/newword/gc`	#全局(%)查找"preword"替换为"nweword"并且需要确认(c)
`:%s/foo/bar/i`				#全局(%)查找"foo"替换为"bar"，大小写不敏感(i)，敏感用(I)

##=====================移动光标====================
`数字+Enter` #光标向下移动n行
`数字+gg`	#移动到第n行
`数字键+space` #光标向后移动n个字符

`gg` 	#移动到第一行
`G` 	#移动到最后一行

##=====================复制、粘贴、删除、撤销====================
`u`  #复原前一个动作，等于`command+z`
`ctrl+r` #重做上一个动作

`.`	 #重复上一个动作，⚠️是重复！

`v`/鼠标双击选中 	#进入visual模式
`y`				#复制选中文本，若vimrc中

`yy` #复制光标所在行：yank
`p`	 #粘贴内容到光标下一行：paste
`P`	 #粘贴内容到光标上一行

`dd` #删除光标所在行: delete
`dw` #delete a word
`ctrl+w` #在insert模式下delete

##=====================多光标操作====================
"g+d" 	#高亮显示所有相同的单词
`*`			#选中当前光标后所在的相同词语
`#`			#选中当前光标前所在的相同词语

`Ctrl+ v`	#首先进入块模式 
			#使用按键j/k/h/l进行选中多列
`Shift + i`	#进行块模式下的插入
`ESC`		#完成多行的插入

##=====================复杂功能====================
`Ctrl+F` #下一页
`Ctrl+B` #上一页
`Ctrl+O` #前一个buffer
`Ctrl+i` #后一个buffer

`:%s/word1/word2/gc` #全部替换,c表示需要确认

`:2,99s/word1/word2/g` #替换从1行到99行

`:vs Name` #竖直方向再打开一个窗口显示文件‘Name’，水平为`sv`

`:n1,n2 w run/Name` #将n1行到n2行的内容另存为run文件夹下，名为Name

`:set fileencoding` #查看编码格式
`:set fileencoding=utf-8` #转码为UTF-8
`set list` #查看不可见字符（空格换行等）
`set nolist` # 隐藏不可见字符
```

* 我的vimrc : 备份文件里

```shell
ls /usr/share/vim/vim81/colors #查看mac vim本地 主题
```

vim主题one dark ： https://github.com/joshdick/onedark.vim

[Creat our own syntax for vim](https://vim.fandom.com/wiki/Creating_your_own_syntax_files)

vim插件管理器有很多，时代久远的vundle和轻便的[vimplug](https://github.com/junegunn/vim-plug) 还有vim8之后引入了[内置包管理器](https://aisk.me/vim-8-native-plugin-manager/?utm_source=tuicool&utm_medium=referral)
原理都差不多，推荐vimplug。

~/.vim/coc-settings.json 为coc插件的配置文件

* vimplug安装插件很简单：分两步
  1. 在.vimrc中添加如：Plug 'vim-airline/vim-airline'
  2. 进入vim命令行模式输入:PlugInstall

[较新的vim插件推荐](http://liaoph.com/modern-vim/)

[vim插件推荐：](https://zhuanlan.zhihu.com/p/58816186)

[nvim配置](https://github.com/0xff91/vide)

[vim配置](https://blog.fninit.com/posts/2017/golang-in-vim/)

* NERDTree
* [这个怎么样](https://github.com/neoclide/coc.nvim/blob/master/doc/coc.cnx)
* [coc.nvim补全官方](https://github.com/neoclide/coc.nvim/blob/master/doc/coc.cnx)
* [coc插件配置](https://www.jianshu.com/p/cbe374491da4)
* [airline](https://github.com/vim-airline/vim-airline-themes)
* [powerline字体](https://github.com/powerline/fonts)
* [vim support python](https://blog.csdn.net/weixin_33670786/article/details/88678170)
* [fzf 文件模糊搜索](https://github.com/junegunn/fzf/wiki/examples)
* [vim-latex](https://zhuanlan.zhihu.com/p/61036165)
* [vim-markdown](https://zhuanlan.zhihu.com/p/84773275)
* [vim多光标](https://github.com/terryma/vim-multiple-cursors)
* [ale配置](https://segmentfault.com/a/1190000016405629)
* [ale配置2](https://www.cnblogs.com/wudongwei/p/9083546.html)

* vim NERDTree instuction

F3：自定义启用/隐藏目录树
?: 快速帮助文档
o: 打开一个目录或者打开文件，创建的是buffer，也可以用来打开书签
go: 打开一个文件，但是光标仍然留在NERDTree，创建的是buffer
t: 打开一个文件，创建的是Tab，对书签同样生效
T: 打开一个文件，但是光标仍然留在NERDTree，创建的是Tab，对书签同样生效
i: 水平分割创建文件的窗口，创建的是buffer
gi: 水平分割创建文件的窗口，但是光标仍然留在NERDTree
s: 垂直分割创建文件的窗口，创建的是buffer
gs: 和gi，go类似
x: 收起当前打开的目录
X: 收起所有打开的目录
e: 以文件管理的方式打开选中的目录
D: 删除书签
P: 大写，跳转到当前根路径
p: 小写，跳转到光标所在的上一级路径
K: 跳转到第一个子路径
J: 跳转到最后一个子路径
和: 在同级目录和文件间移动，忽略子目录和子文件
C: 将根路径设置为光标所在的目录
u: 设置上级目录为根路径
U: 设置上级目录为跟路径，但是维持原来目录打开的状态
r: 刷新光标所在的目录
R: 刷新当前根路径
I: 显示或者不显示隐藏文件
f: 打开和关闭文件过滤器
q: 关闭NERDTree
A: 全屏显示NERDTree，或者关闭全屏

## Mac

### 软件

**官网**

* [Sublime](https://www.sublimetext.com)	        ---文本编辑器
* [Itsycal](https://www.mowglii.com/itsycal/)               ---日期显示
* [Rectangle](https://rectangleapp.com)         ---窗口管理
* [FDM](https://www.freedownloadmanager.org)                  ---下载工具
* [Typaro](https://typora.io)               ---Markdown
* [IINA](https://iina.io)                   ---视频播放器
* [Appcleaner](https://freemacsoft.net/appcleaner/)        ---软件卸载
* [f.lux](https://justgetflux.com)                    ---动态色温
* [MacFanControll](https://crystalidea.com/macs-fan-control) ---风扇控制
* [Shadowsocks](https://github.com/shadowsocks/ShadowsocksX-NG)    ---代理
* BackgroundMusic-调节声音

**App Store**

* HiddenBar         ---隐藏图标
* Unarchiver         ---解压工具
* BlackMagicDisk ---硬盘测速
* NewFileMenu    ---右键新建文件
* Cleaner Onelite  ---垃圾清理

- - - -


### Mac 快捷键

- - - -

`command + shift + . `       #显示隐藏文件

`command + shift +3`         # 全屏截图

`command + shift +4`         # 自由截图 改成 `command 4`

`command + shift +5`         # 全部截图录屏选项  改成 `command 5`

`Caps` # 换中英文

`Opt+S` # siri (改)

**`Opt+esc` # 读出选中词**

`Opt+shift+音量` # 精准调整音量

按住 `Opt` # 选中框

按住 `opt` #左右键是在pdf中回退跳转

按住`Opt` # 调整finder窗口大小为修改默认大小

在任务管理器中 `cmd+2` #打开cpu多核占用率窗口

`Cmd+M` ##最小化，区别于隐藏，这个用application window就可以找到，而`Cmd+H`隐藏可以被`Cmd+tab`找到

### Terminal

* 快捷键

`Tab`  #自动补全或查看shell命令

`Ctrl + u`        # 删除光标到行首
`Ctrl + k`      # 删除光标之前到行尾的字符

`Ctrl + a`      # 光标移动到行首(ahead)
`Ctrl + e`      # 光标移动到行尾(End)

`Ctrl + 右箭头`  # 光标向后移动一个字符位置

`Arrow up`  # 直接输入history里的指令

`ctrl+d`     #quit ssh
`ctrl+c`     #kill recent program

`ctrl+r`    # fzf 终端命令历史搜索

#### 终端中文支持

将下面几行代码加`.shellrc/.zshrc`。

但要注意的是，若有`ohmyzsh`，它会重置语言环境，所以需要将其添加在`source oh-my-zsh.sh`后。

```shell
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
```

#### mac terminal 标题

```shell
#加入.zshrc，取消ohmyzsh自动生成题目
DISABLE_AUTO_TITLE="true"
#再在terminal设置中window中设置显示项目
```

#### mac terminal 取消login信息显示

```shell
touch ~/.hushlogin
```



#### 指令

##### 常用

```shell
top -l 1 | head -n 10 | grep PhysMem  #查看mac内存占用
sudo purge          #mac清理RAM  

pmset -g custom	#显示电源设置
sudo pmset -a tcpkeepalive 0  #关闭所有情况下睡眠是保持TCP链接的设置
man pmset		#查看电源设置的手册，比如下面这个：
	proximitywake - On supported systems, this option controls 			system wake from sleep based on proximity of devices using same 	iCloud id. (value = 0/1)


netstat -an | grep 1080	 #查看端口号信息(lsof -i:80 也是看端口号)
>>> tcp6       0      0  ::1.1080          *.*             LISTEN     
>>> tcp4       0      0  127.0.0.1.1080    *.*             LISTEN 

```

##### 杂

```shell
sudo tlmgr repository set http://mirror.hust.edu.cn/CTAN/systems/texlive/tlnet #latex包设置镜像

tlmgr update --self #更新tlmgr



#finder显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true
KillAll Finder

sudo scutil --set HostName zx #设置机器名，也就是@后的名字
defaults write com.apple.dock springboard-rows -int 7 #改launchpad图标
defaults write com.apple.dock springboard-columns -int 8
defaults write com.apple.dock ResetLaunchPad -bool TRUE
killall Dock

defaults write com.apple.dock showhidden -bool true #有隐藏窗口的图标变暗 
killall Dock

defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' #dock添加透明图标
defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}' #dock堆栈区添加空白
killall Dock

#更改访达默认显示模式（不好使）    
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
　　killall Finder
```

##### 链接动态库！

```shell
man ln
#得到下面描述 ========
  指令名称 : ln
  使用权限 : 所有使用者
  使用方式 : ln [options] source dist，其中 option 的格式为 :
  [-bdfinsvF] [-S backup-suffix] [-V {numbered,existing,simple}]
  [--help] [--version] [--]
  说明 : Linux/Unix 档案系统中，有所谓的连结(link)，我们可以将其视为档案的别名，而连结又可分为两种 : 硬连结(hard link)与软连结(symbolic link)，硬连结的意思是一个档案可以有多个名称，而软连结的方式则是产生一个特殊的档案，该档案的内容是指向另一个档案的位置。硬连结是存在同一个档 案系统中，而软连结却可以跨越不同的档案系统。
  ln source dist 是产生一个连结(dist)到 source，至于使用硬连结或软链结则由参数决定。
  不论是硬连结或软链结都不会将原本的档案复制一份，只会占用非常少量的磁碟空间。
  -f : 链结时先将与 dist 同档名的档案删除
  -d : 允许系统管理者硬链结自己的目录
  -i : 在删除与 dist 同档名的档案时先进行询问
  -n : 在进行软连结时，将 dist 视为一般的档案
  -s : 进行软链结(symbolic link)
  -v : 在连结之前显示其档名
  -b : 将在链结时会被覆写或删除的档案进行备份
  -S SUFFIX : 将备份的档案都加上 SUFFIX 的字尾
  -V METHOD : 指定备份的方式
  --help : 显示辅助说明
  --version : 显示版本


#=================一个案例==================
#安装
cd atomsk	#进入安装文件夹
sudo zsh install.sh		#运行安装程序
>>> The program was successfuly installed in /usr/local/bin/
    To run it, enter 'atomsk' in a terminal.

#试运行（失败）
atomsk		#运行一下 
>>> dyld: Library not loaded: /usr/local/gfortran/lib/libquadmath.0.dylib

#调试（链接动态库）
gfortran --print-file-name libquadmath.0.dylib	#看一下现在这个动态库文件位置
>>> /usr/local/Cellar/gcc/9.3.0/lib/gcc/9/gcc/x86_64-apple-darwin19/9.3.0/../../../libquadmath.0.dylib

which gcc   
>>> /usr/bin/gcc

which gfortran		#看一下全局变量被链接到哪个位置
>>> /usr/local/bin/gfortran

ln /usr/local/Cellar/gcc/9.3.0/lib/gcc/9/libquadmath.0.dylib /usr/local/lib/libquadmath.0.dylib			#把动态库连接到这个位置

#再次试运行（成功）
atomsk --create fcc 4.02 Al aluminium.xsf	#成功啦！
>>> Creating system:
..> Fcc Al oriented X=[100] Y=[010] Z=[001].
..> System was successfully created.
>>> Writing output file(s) (4 atoms):
..> Successfully wrote XSF file: aluminium.xsf
\o/ Program terminated successfully!
>>> Total time: 0.002 s.; CPU time: 0.002 s.
```

#### 终端软件管理

- - - -

homebrew，curl，wget，pip，conda，yum，scoop……均是包管理器，也就是app store➕迅雷

决定Mac使用Homebrew+wget+pip3来管理terminal的包下载。（pip已集成在python3里，叫pip3）

#### Oh my zsh

安装插件步骤

（zsh和bash的区别…？）

1. 终端输入  vim ~/.zshrc
2. 找到 plugins=(zsh-syntax-highlighting)    #（）里增加要安装的插件

3. 终端输入
   `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

clone 与 $ 之间的网址就是安装文件GitHub网址，上述命令指：下载到~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 文件夹

4. 终端输入
   `source ~/.zshrc`      # 更新配置文件
5. 重启终端

[**oh my zsh 有很多内置插件但默认不打开**](https://hufangyun.com/2017/zsh-plugin/)： `cd ~/.oh-my-zsh/plugins` 就可以看下，然后比如使用sublime，就在.zshrc中的plugins=（）中加入sublime，就可以在终端使用如下代码了：

```shell
omz update #更新ohmyzsh 
st filename	#用sublime 打开文件
stt		#用sublime打开当前文件夹


# 还有很多不错的内置插件，比如可以代替autojump的‘z’
z	# 首先你需要进入某个文件夹，然后z会记住，下次就不用cd了，直接z 主要是不需要写路径
>>> 4          /Users/zxll/Desktop/code/lammps/friction
>>> 4          /Users/zxll/Desktop/code/lammps/mechanical
>>> 4          /Users/zxll/Desktop/code/lammps/run
>>> 4          /Users/zxll/Desktop/code/lammps/thermal
>>> 4          /Users/zxll/Desktop/code/python/pandas
>>> 4          /Users/zxll/Desktop/write/markdown/computer
>>> 4          /Users/zxll/Downloads

```

#### Homebrew

mac上终端设置代理然后运行下面的install.sh（因为我用的是beta版系统，有时识别不出来就报错，所以把那个linux和mac的if语句删掉了，不判断直接执行）

**文件改动见`/Users/zxll/Documents/zx-profiles/teminal/homebrew改.sh`**

包一般安装在：**/Users/zxll/Library/Caches/Homebrew/downloads**

---

```shell
brew list #列出已安装的软件
brew outdated #查看哪些需要更新
brew update #更新brew
brew home #用浏览器打开brew的官方网站
brew info #显示软件信息brew deps #显示包依赖
brew upgrade #更新所有
brew upgrade  [Name] #更新指定包
brew cleanup #清理所有包的旧版本
brew cleanup  [Name] #清理指定包的旧版本
brew cleanup -n #查看可清理的旧版本包，不执行实际操作
brew deps --installed --tree #查看所有依赖关系
```

[brew清华源](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)：

```shell
# brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

# 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask-drivers.git
```

brew 设置原有源：

```shell
# brew 程序本身，Homebrew/Linuxbrew 相同
git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git

# 以下针对 mac OS 系统上的 Homebrew
git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core.git
git -C "$(brew --repo homebrew/cask)" remote set-url origin https://github.com/Homebrew/homebrew-cask.git
git -C "$(brew --repo homebrew/cask-fonts)" remote set-url origin https://github.com/Homebrew/homebrew-cask-fonts.git
git -C "$(brew --repo homebrew/cask-drivers)" remote set-url origin https://github.com/Homebrew/homebrew-cask-drivers.git
```





[mac vim 配置](https://www.jianshu.com/p/923aec861af3)

### Neovim

```shell
#安装
brew install neovim
pip3 install neovim --upgrade
```

#### ipython

import os
print (os.path.abspath('.'))      #查看python读取路径

~/.ipython/profile_default/startup  #创建一个自启默认设置https://www.pypandas.cn/docs/user_guide/options.html#overview

pandas 多核运行 https://github.com/nalepae/pandarallel
df.parallel_apply(func) #加上这个使得命令利用多核

### sublime



sublime 快捷键：

* `cmd+c/v/x` #复制/粘贴/剪切 某行（不需要选中）
* `cmd+d/u`   #选词/撤销上个选词（选中一个词后，多光标选同样word）
* `cmd+/`     #注释本行
* `cmd+[/]`   #缩进与取消缩进（选中多行可以同时）
* `cmd+k`     #打开/关闭侧边文件栏
* `cmd+F`     #搜索
* `cmd+G`     #搜索中为搜索下一个
* `opt+Enter` #搜索中搜索并选中全部
* opt+'click'  #进入列选择模式
* **`cmd+Arrow` #去最上或最下**
* `F12`/`cmd+opt+Arrow down`       #跳转定义

sublime插件：

* Package Control
* ConvertToUTF8
* SideBar Enhancements
* Anaconda
* Autopep8
* sublimelinter
* PackageDev
* latextools

[latextools](https://latextools.readthedocs.io/en/latest/install/)

* [sublime 多重选择]((null))

* [sublime anaconda 自动补全python库]((null))

* [配置sublime-python1](https://www.jianshu.com/p/193d0f9a6190)

* [配置sublime-python2](https://blog.csdn.net/DawnRanger/article/details/48575507)

* [sublimelinter](http://www.sublimelinter.com/en/stable/)

* [sublime自定义高亮](http://blog.lessfun.com/blog/2016/10/28/make-a-custom-syntax-highlighting-for-sublime-text/)

* [sublime snippets and completions](https://blog.csdn.net/varalpha/article/details/105128139)

* [sublime自定义语法官方文档](https://www.sublimetext.com/docs/3/scope_naming.html)

In Sublime , we can create our own language highlight document named “.sublime-syntax”,which saved in package/user folder.
**其中match语法为正则表达式**

### vscode

快捷键：

* **`cmd+c/v/x` #复制/粘贴/剪切 某行（不需要选中）**
* **`cmd+d/u`   #选词/撤销上个选词（选中一个词后，多光标选同样word）**
* **`cmd+/`     #注释本行**
* **`cmd+[/]`   #缩进与取消缩进（选中多行可以同时）**
* **`cmd+B`     #打开/关闭侧边文件栏**
* **`ctrl+B`     #运行脚本**
* **`cmd+F`     #搜索**
* **`cmd+R`     #打开最近**
* **`cmd+T`     #打开下面分割的终端**
* **`cmd+J`     #打开控制台**
* **`cmd+P`     #打开文件**
* **`cmd+G`     #搜索中为搜索下一个**
* **`opt+Enter` #搜索中搜索并选中全部**
* **opt+shift+'click'  #进入列选择模式**
* **`cmd+Arrow` #去最上或最下**
* **`cmd+E`/`cmd+opt+Arrow down`       #跳转定义**


### 

## Linux


### Ubuntu安装驱动

```shell
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
#如果想安装特定项，就用apt install 
```


### 快捷键：

`Ctrl+H`  #显示隐藏文件

### Terminal：



#### dircolors



```shell
00 　　　 //默认
01 　　 　//加粗
04 　 　　//下划线
05 　 　　//闪烁
07 　 　　//反显
08 　 　　//隐藏
文字颜色 
30 — Black   //黑色
31 — Red     //红色
32 — Green   //绿色
33 — Yellow  //黄色
34 — Blue    //蓝色
35 — Magenta //洋红色
36 — Cyan    //蓝绿色
37 — White   //白色
背景颜色 
40 — Black 
41 — Red 
42 — Green 
43 — Yellow 
44 — Blue 
45 — Magenta 
46 — Cyan 
47 – White
```







#### 自定义窗口名

* 指令

```shell
systemctl start sshd.service   # 开启ssh服务

systemctl enable sshd.service #ssh 开机自启

sudo apt install net-tools #安装ifconfig等工具
sudo apt install build-essential #安装gcc、g++、make等
apt-cache show gcc #Ubuntu 看软件库中软件信息
dpkg -L gcc #Ubuntu查看gcc所有文件都安装在哪里

```

### 主题：

1. 安装Gnome tweak tool（可视化）

```shell
sudo apt install gnome-tweak-tool
sudo apt install chrome-gnome-shell
sudo apt install gnome-shell-extensions
```

2. 去浏览器安装extension
   搜索下载theme解压，复制到`/usr/share/themes`
   同样下载icon 解压，复制到`/usr/share/icons`(这是全局的，用户见下)

3. 手动安装 GNOME Shell 扩展

   你不需要始终在线才能安装 GNOME Shell 扩展，你可以下载文件并稍后安装，这样就不必使用互联网了。

   去 GNOME 扩展网站下载最新版本的扩展。

   ![Download GNOME Shell Extension](https://img.linux.net.cn/data/attachment/album/201803/15/105337xtikyv2llvyjlzf2.jpg)

   *Download GNOME Shell Extension*

   解压下载的文件，将该文件夹复制到 `~/.local/share/gnome-shell/extensions` 目录。到主目录下并按 `Ctrl+H` 显示隐藏的文件夹，在这里找到 `.local` 文件夹，你可以找到你的路径，直至 `extensions` 目录。

   一旦你将文件复制到正确的目录后，进入它并打开 `metadata.json` 文件，寻找 `uuid` 的值。

   确保该扩展的文件夹名称与 `metadata.json` 中的 `uuid` 值相同。如果不相同，请将目录重命名为 `uuid` 的值。

   ![Manually install GNOME Shell extension](https://img.linux.net.cn/data/attachment/album/201803/15/105337j5wm799el6lezyig.jpg)

   差不多了！现在重新启动 GNOME Shell。 按 `Alt+F2` 并输入 `r` 重新启动 GNOME Shell

**[上述参考链接](https://linux.cn/article-9447-1.html)**。

4. 重置存储在/ org / gnome /中的所有Gnome设置（从命令行）

   建议您在使用dconf reset命令之前执行备份。为此，请创建一个备份 `~/.config/dconf/user` 除了在Gnome Tweaks中发布的设置外，您还可以在系统设置中重置Gnome设置。保存dconf设置 `/org/gnome/`，以及其他Gnome设置。使用以下命令：

   ```shell
   dconf reset -f /org/gnome/
   mv .config/dconf/user .config/dconf/user.bak && sudo reboot
   ```




## reference

* **[mac 设置指南](https://github.com/macdao/ocds-guide-to-setting-up-mac)**
* **[mac dock设置](https://sspai.com/post/33493)**
* **[Linux文件系统](http://cn.linux.vbird.org/linux_basic/0210filepermission_3.php)**
* **[oh my zsh配置](https://www.zrahh.com/archives/167.html)**
* **[win-vim安装](https://segmentfault.com/a/1190000019360991)**

