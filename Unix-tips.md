任何代码他们的指令都是小写字母组成，为了避免歧义，我们自己定义量和函数时，最好是用大写字母来表示；

每个指令之间都应该用空格隔来，类似代码应该对齐书写，注释要用tab键尽量对齐，不仅美观，且大大增加了易读性。

[google开源代码书写规范](https://zh-google-styleguide.readthedocs.io/en/latest/contents/)
# 通用
## 一 Unix 文件系统：

当然，Mac有自己的文件系统，2020年为APFS；Linux也更新了自己的文件系统，2020年为ZFS。但同为Unix内核，很多文件的逻辑依然保持一致，这里只谈一致的问题，不谈具体的文件系统特性。

1. [认识 EXT2 文件系统](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk)  
　　1.1 [硬盘组成与分割的复习](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-physical)  
　　1.2 [文件系统特性](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-filesystem)： [索引式文件系统](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#indexed_allocation)  
　　1.3 [Linux 的 EXT2 文件系统(inode)](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-inode): [data block](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#block), [inode table](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#inode), [superblock](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#super_block), [dumpe2fs](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#dumpe2fs)  
　　1.4 [与目录树的关系](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-dir)  
　　1.5 [EXT2/EXT3 文件的存取与日志式文件系统的功能](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-journal)  
　　1.6 [Linux 文件系统的运行](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-filerun)  
　　1.7 [挂载点的意义 (mount point)](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-mount)  
　　1.8 [其他 Linux 支持的文件系统与 VFS](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#harddisk-other)2. [文件系统的简单操作](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#filesys)  
　　2.1 [磁盘与目录的容量：](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#filesys_1) [df](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#df), [du](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#du)  
　　2.2 [实体链接与符号链接：](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#link) [ln](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#ln)3. [磁盘的分割、格式化、检验与挂载](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#disk)  
　　3.1 [磁盘分区： fdisk](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#fdisk), [partprobe](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#partprobe)  
　　3.2 [磁盘格式化：](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#format) [mkfs](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#mkfs), [mke2fs](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#mke2fs)  
　　3.3 [磁盘检验： fsck](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#fsck), [badblocks](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#badblocks)  
　　3.4 [磁盘挂载与卸除： mount](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#mount), [umount](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#umount)  
　　3.5 [磁盘参数修订](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#diskpara)： [mknod](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#mknod), [e2label](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#e2label), [tune2fs](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#tune2fs), [hdparm](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#hdparm)4. [配置启动挂载：](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#bootup)  
　　4.1 [启动挂载 /etc/fstab 及 /etc/mtab](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#fstab)  
　　4.2 [特殊装置 loop 挂载(映象档不刻录就挂载使用)](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#loop)5. [内存置换空间(swap)之建置：](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#swap)  
　　5.1 [使用实体分割槽建置swap](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#swapdevice)  
　　5.2 [使用文件建置swap](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#swapfile)  
　　5.3 [swap使用上的限制](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#swapuse)6. [文件系统的特殊观察与操作](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#special)  
　　6.1 [boot sector 与 superblock 的关系](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#special_boot_sector)  
　　6.2 [磁盘空间之浪费问题](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#special_waste)  
　　6.3 [利用 GNU 的 parted 进行分割行为](http://cn.linux.vbird.org/linux_basic/0230filesystem.php#parted)

> windows是先有硬盘分区，再有分区上的目录。
> linux是先有目录，再有每个目录对应的分区，进入一个分区的目录入口就叫挂载点。
> linux中不是每个目录都是挂载点，通常只要求根目录/是挂载点。其他的目录可以用户自己决定要不要挂载单独的分区，如果不挂载，这个目录实际的存储位置和它的父目录相同。
>
> win和linux的区别主要是文件结构(目录)和物理结构(存储)的侧重不同。目录在linux里是更基础的概念，在目录的基础上安排磁盘分区。win则是相反。

### 硬盘设备/分区/文件系统/挂载

**(1) 磁盘设备（/dev/sdX）**
- 物理磁盘（如 HDD、SSD）在 Linux 中表示为 `/dev/sdX`（如 `/dev/sda`, `/dev/sdb`）。
- 可以通过 `lsblk` 或 `fdisk -l` 查看。

**(2) 分区（Partition）**
- 磁盘可以划分成多个分区（如 `/dev/sdb1`, `/dev/sdb2`）。
- 使用 `fdisk`/`gdisk`/`parted` 管理。

**(3) 逻辑卷管理（LVM，可选）**
- 更灵活的存储管理方式，支持动态调整大小、快照等。
- 涉及 **PV（Physical Volume）**、**VG（Volume Group）**、**LV（Logical Volume）**。
- 具体见下面章节：《硬盘扩容》- 《LVM》

**(4) RAID（冗余磁盘阵列）**
- 通过 `mdadm` 实现 **软件 RAID**，将多个磁盘组合成一个逻辑设备（如 `/dev/md0`）。
- 提供数据冗余（RAID 1/5/6）或性能提升（RAID 0）。
- 具体见下面章节：《linux 硬盘raid》

**(5) 文件系统（File System）**
- 数据存储的最终组织形式（如 `ext4`、`xfs`、`btrfs`）。
- 必须 **格式化** 后才能存储文件。 

**(6) 挂载（Mount）**
- 将设备（如 `/dev/md0`）关联到目录（如 `/mnt/raid`），才能访问其中的文件。
- 挂载点（Mount Point）是文件系统的访问入口。

---
 **2. 为什么需要 `/dev/md0` 和 `/mnt/raid` 两个步骤？**

|名称|作用|类比|
|---|---|---|
|**`/dev/md0`**|RAID 设备文件（原始存储块）|相当于一个“未拆封的硬盘”|
|**`/mnt/raid`**|挂载点（访问文件的入口）|相当于“插上硬盘后的盘符（如 D:）”|

1. **`/dev/md0` 是 RAID 设备，但不是文件系统**
    - 当你运行 `sudo mdadm --create /dev/md0 ...` 时，只是创建了一个 **逻辑磁盘设备**，它还没有：
        - 文件系统（如 ext4）。
        - 挂载点（无法直接访问文件）。
    - 此时如果直接尝试访问 `/dev/md0`，系统会报错：
        `cd /dev/md0  # 错误！这不是目录。`
        
2. **`mkfs` 格式化：让 `/dev/md0` 支持存储文件**
    - `sudo mkfs.ext4 /dev/md0` 会在 `/dev/md0` 上创建 **ext4 文件系统**，使其能存储文件和目录。
    
3. **`mount` 挂载：关联设备到目录**
    - Linux 没有“盘符”（如 Windows 的 `C:\`、`D:\`），而是通过 **挂载到目录** 访问文件。
    - `sudo mount /dev/md0 /mnt/raid` 的作用：
        - 将 `/dev/md0` 的文件系统挂载到 `/mnt/raid`。
        - 之后所有对 `/mnt/raid` 的读写操作都会映射到 `/dev/md0`。

#### Linux存储层次结构
- **物理磁盘**：如 `/dev/sda`、`/dev/sdb`（原始存储设备）
- **分区**：磁盘划分的逻辑单元（如 `/dev/sda1`）
- **逻辑卷 (LVM)**：
    - 物理卷 (PV)：分区或磁盘被初始化为PV（如 `sda2` 类型为 `LVM2_member`）
    - 卷组 (VG)：多个PV组合成VG（未直接显示）
    - 逻辑卷 (LV)：在VG上创建的虚拟分区（如 `/dev/mapper/centos-root`）
- **文件系统**：在分区或LV上格式化（如 `xfs`、`swap`）
- **挂载**：将文件系统链接到目录（如 `/`、`/home`）

|命令|作用层级|关键信息|使用场景|
|---|---|---|---|
|**`fdisk -l`**|磁盘分区表|分区物理信息（起止扇区、大小）|查看磁盘分区结构|
|**`lsblk -f`**|块设备拓扑关系|设备树、文件系统类型、挂载点|展示设备间逻辑关系|
|**`df -hT`**|已挂载文件系统使用情况|空间使用率、挂载点、文件系统|监控磁盘空间消耗|

#### 1. `fdisk -l`：磁盘分区信息
```bash
Disk /dev/sda: 53687.1 GB  # 物理磁盘sda（53.6TB）
   /dev/sda1  *  2048  2099199  1GB  83 Linux     # 启动分区（/boot）
   /dev/sda2     2099200 209715199  50GB 8e Linux LVM  # LVM物理卷
   /dev/sda3     209715200 419430399  50GB 8e Linux LVM # LVM物理卷

Disk /dev/sdb: 107.4 GB    # 第二块磁盘（107GB）
   /dev/sdb1      2048 209715199  50GB 8e Linux LVM    # LVM物理卷
```
- **关键点**：
    - `sda` 有3个分区，`sdb` 有1个分区，均加入LVM。
    - 逻辑卷（如 `/dev/mapper/centos-root`）是LVM创建的虚拟设备，不在分区表中直接管理。

####  2. `lsblk -f`：块设备拓扑与文件系统
```bash
sda
├─sda1 xfs               /boot    # 独立分区（/boot）
├─sda2 LVM2_member                 # 物理卷PV（sda2）
│ ├─centos-root xfs      /        # 根逻辑卷（150GB）
│ ├─centos-swap swap     [SWAP]   # 交换分区
│ └─centos-home xfs      /home    # /home逻辑卷（142GB）
└─sda3 LVM2_member                 # 物理卷PV（sda3）
  └─centos-home xfs      /home    # 与sda2的home是同一LV（跨PV）

sdb
└─sdb1 LVM2_member                 # 物理卷PV（sdb）
  └─centos-root xfs      /         # 与sda2的root是同一LV（跨PV）
```

- **关键点**：
    - **LVM扩展性**：`centos-root` 同时使用 `sda2` 和 `sdb1` 的空间（跨磁盘扩展）。
    - **跨PV存储**：`centos-home` 同时使用 `sda2` 和 `sda3` 的空间。
    - **UUID唯一性**：相同UUID（如 `32ab20e6...`）表示同一逻辑卷。

#### 3. `df -hT`：文件系统使用情况
```bash
/dev/mapper/centos-root xfs  150G  24G  127G  16% /     # 根分区使用率16%
/dev/mapper/centos-home xfs  142G  87G   55G  62% /home # /home使用率62%
/dev/sda1              xfs 1014M 151M  864M  15% /boot  # 启动分区
192.168.50.103:/home/data nfs4 965G 216G 749G 23% /nfs-data  # NFS网络存储
overlay               overlay 150G 24G 127G 16% /var/lib/docker/... # Docker容器
```
- **关键点**：
    - **LVM空间分配**：根目录（`/`）150GB来自 `centos-root`（跨 `sda2+sdb1`）。
    - **高使用率目录**：`/home` 占用87GB（62%），需关注清理。
    - **特殊文件系统**：
        - `nfs4`：网络存储
        - `overlay`：Docker容器分层文件系统（共享宿主机的 `/` 空间）
        - `tmpfs`：内存虚拟磁盘（重启消失）


### linux 磁盘分区及调整
- lsblk
- parted 
- fdisk
- resize2fs
- df
- gparted
这些 Linux 磁盘工具各有不同的用途和功能，但它们有一定的关联，主要用于管理磁盘分区和文件系统。下面是它们的区别和关系：

**1. lsblk（列出块设备信息）**

• **用途**：显示系统中的块设备（磁盘、分区、LVM 逻辑卷等）。
• **特点**：
	• 只读工具，不会修改磁盘。
	• 直观展示磁盘结构及其挂载点。
	• 不会显示 CD-ROM 或者网络存储设备（区别于 fdisk -l）。
• **示例**：
```
lsblk
```

**2. parted（高级分区管理工具）**
• **用途**：创建、调整、删除和管理磁盘分区。
• **特点**：
	• 支持 GPT（GUID 分区表）和 MBR（主引导记录）。
	• 可以调整分区大小（GPT和大于2T的MBR下不能用fdisk，要用parted或者gparted）。
	• 交互式和非交互式模式均可用。

• **示例**：
```bash
parted /dev/sda
(parted) print
(parted) mkpart primary ext4 1MiB 10GiB
```

**3. fdisk（传统 MBR 分区管理工具）**

• **用途**：用于查看和管理 MBR 分区表的磁盘分区（不推荐用于 GPT）。
• **特点**：
	• 仅支持 MBR（不支持 GPT，GPT 需要 gdisk）。
	• 命令行交互式操作。
• **示例**：
```bash
fdisk /dev/sda
Command (m for help): p   # 打印分区表
Command (m for help): n   # 创建新分区
```

**4. resize2fs（调整 ext 文件系统大小）**
• **用途**：调整 ext2/ext3/ext4 文件系统的大小。
• **特点**：
	• **只能用于 ext 文件系统**，不支持 NTFS、XFS、Btrfs 等。
	• 扩展时，目标分区必须已经扩展（如 parted 或 gparted 扩展分区后）。
	• 收缩时，建议先卸载文件系统。
• **示例**：
```bash
resize2fs /dev/sda1
resize2fs /dev/sda1 20G   # 调整文件系统大小为 20GB
```

**5. df（显示磁盘使用情况）**
• **用途**：查看文件系统的磁盘空间使用情况。
• **特点**：
	• 只显示已挂载的文件系统。
	• 支持 -h 选项（人类可读格式）。
• **示例**：
```bash
df -h
```

**6. gparted（GUI 分区管理工具）**
• **用途**：图形化的磁盘分区管理工具（基于 parted）。
• **特点**：
	• 适合新手，提供可视化界面。
	• 支持调整、删除、创建、格式化分区。
	• 支持多种文件系统（ext4、NTFS、FAT32、XFS 等）。
• **示例**：
```
gparted
```

**工具之间的关系**

| **工具**    | **主要功能**      | **作用对象** | **关键区别**        |
| --------- | ------------- | -------- | --------------- |
| lsblk     | 显示块设备信息       | 磁盘 & 分区  | 只读，不修改          |
| fdisk     | 分区管理（仅 MBR）   | 磁盘       | 传统工具，不支持 GPT    |
| parted    | 分区管理（支持 GPT）  | 磁盘       | 现代工具，可调整大小      |
| resize2fs | 调整 ext 文件系统大小 | 分区上的文件系统 | 仅支持 ext 系列      |
| df        | 显示磁盘空间使用情况    | 挂载的文件系统  | 仅显示挂载的分区        |
| gparted   | GUI 分区管理工具    | 磁盘 & 分区  | parted 的 GUI 版本 |

**总结**：
如果你的磁盘是 GPT，建议用 parted 或 gparted 进行分区管理，而 fdisk 主要适用于 MBR。

### [LVM](http://cn.linux.vbird.org/linux_basic/0420quota.php#lvm)扩容

| 序号  | 功能   | PV 物理卷命令                                                                                                                          | VG 卷组命令                                                                                                                           | LV 逻辑卷命令                                                                                                                          |
| --- | ---- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| 01  | 扫描功能 | [pvscan](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=pvscan&zhida_source=entity)     | [vgscan](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=vgscan&zhida_source=entity)     | [lvscan](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=lvscan&zhida_source=entity)     |
| 02  | 建⽴功能 | [pvcreate](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=pvcreate&zhida_source=entity) | [vgcreate](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=vgcreate&zhida_source=entity) | [lvcreate](https://zhida.zhihu.com/search?content_id=217277193&content_type=Article&match_order=1&q=lvcreate&zhida_source=entity) |
| 03  | 查询功能 | pvdisplay                                                                                                                         | vgdisplay                                                                                                                         | lvdisplay                                                                                                                         |
| 04  | 删除功能 | pvremove                                                                                                                          | vgremove                                                                                                                          | lvremove                                                                                                                          |
| 05  | 扩容功能 |                                                                                                                                   | vgextend                                                                                                                          | lvextend                                                                                                                          |
| 06  | 缩容功能 |                                                                                                                                   | vgreduce                                                                                                                          | lvreduce                                                                                                                          |

> 需要先使用 fdisk 命令进行一个分区设置。  

- [给LVM添加磁盘扩容](https://blog.csdn.net/xieshaohu/article/details/129671846)
已经在VMware中成功添加了一块100G的新磁盘（sdb），现在需要将这100G空间扩展到根目录（/）。你的根目录是LVM逻辑卷（centos-root），所以推荐的做法是将新磁盘加入LVM，并扩展根分区。操作步骤如下：

#### 1. 对新磁盘分区（sdb）  
假设全部用于LVM：
```bash
fdisk /dev/sdb
```
- 输入 n 创建新分区
- 输入 t 设置分区类型为 8e（LVM）
- 输入 w 保存并退出

#### 2. 创建物理卷（PV）  
```bash
pvdisplay
pvcreate /dev/sdb1
```

#### 3. 将新PV加入现有卷组（VG）  
你的卷组名是 centos（可用 vgs 或 vgdisplay 查看确认）：
```sh
vgdisplay
vgextend 你的vg名字 /dev/sdb1
```

#### 4. 扩展根逻辑卷（LV）  
先确认根LV名称（一般为 centos-root）：
```sh
lvdisplay
```
扩展根LV（假设全部扩展到根）：
```sh
# 俩都可以，看lvdisplay显示的是啥
# lvextend -l +100%FREE /dev/centos/root
lvextend -l +100%FREE /dev/mapper/centos-root
```

#### 5. 扩展文件系统  
对于xfs（CentOS 7/8默认）：
```sh
xfs_growfs /
```
对于ext4：
```sh
resize2fs /dev/centos/root
```

验证一下：
```bash
df -hT
```
#### 6. 扩容问题
1. 为什么要fdisk输入 t 回车（更改分区类型），默认的分区类型是什么？
```text
默认新建的分区类型是 Linux（类型代码 83），而LVM需要分区类型为 Linux LVM（类型代码 8e）。  
如果不更改为 8e，后续 LVM 工具可能无法识别该分区为物理卷（PV），导致无法加入卷组（VG）。
所以必须用 t 命令将分区类型改为 8e（Linux LVM），这样才能用于LVM扩容。
```

2. 为什么 `resize2fs /dev/centos/root`指定的是设备名？而`xfs_growfs /` 是根目录是文件路径名？
```text
这是因为两种文件系统工具的设计理念不同：
	ext4 工具面向设备层面操作；xfs 工具面向文件系统层面操作

resize2fs（ext4）：
- 操作的是"块设备"（block device），所以需要指定设备路径
- 语法：resize2fs /dev/centos/root
- 它直接修改设备上的文件系统结构

xfs_growfs（xfs）：
- 操作的是"挂载点"（mount point），所以需要指定目录路径
- 语法：xfs_growfs /
- 它通过挂载点找到对应的文件系统进行扩展
```


### linux 硬盘raid
#### 1. 确认硬盘设备
首先，列出所有磁盘，确认要用于 RAID 的硬盘（如 `/dev/sdb`、`/dev/sdc`）：
```bash
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT   # 查看所有磁盘
sudo fdisk -l                          # 查看详细信息
```

确保目标磁盘 **没有重要数据**（RAID 创建会清除数据）。

#### 2. 安装 `mdadm`（软件 RAID 工具）
```bash
# Debian/Ubuntu
sudo apt update && sudo apt install mdadm

# RHEL/CentOS
sudo yum install mdadm

# Arch Linux
sudo pacman -S mdadm
```

#### 3. 创建 RAID 阵列
-  **3.1 常用 RAID 级别**

| RAID 级别     | 最少磁盘数 | 容错能力      | 存储效率    | 适用场景    |
| ----------- | ----- | --------- | ------- | ------- |
| **RAID 0**  | 2+    | ❌ 无       | 100%    | 高性能，无冗余 |
| **RAID 1**  | 2+    | ✔️（镜像）    | 50%     | 高可用性    |
| **RAID 5**  | 3+    | ✔️（1块盘）   | (N-1)/N | 平衡性能与冗余 |
| **RAID 6**  | 4+    | ✔️（2块盘）   | (N-2)/N | 更高容错    |
| **RAID 10** | 4+    | ✔️（镜像+条带） | 50%     | 高性能+高可用 |

-  **3.2 创建 RAID 示例**

 **（1）创建 RAID 1（镜像）**
```bash
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
```

- `/dev/md0`：RAID 设备名  
- `--level=1`：RAID 1（镜像）  
- `--raid-devices=2`：使用 2 块磁盘  

 **（2）创建 RAID 5（带奇偶校验）**
```bash
sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd
```

**（3）创建 RAID 10（条带+镜像）**
```bash
sudo mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/sdb /dev/sdc /dev/sdd /dev/sde
```

#### 4. 检查 RAID 状态
```bash
cat /proc/mdstat                  # 查看 RAID 构建进度
sudo mdadm --detail /dev/md0      # 查看详细信息

输出示例：

Personalities : [raid1] 
md0 : active raid1 sdc[1] sdb[0]
      20971456 blocks [2/2] [UU]
```

- `[UU]`：所有磁盘正常（`[_U]` 表示一块盘故障）。

#### 5. 格式化并挂载 RAID
 **（1）格式化（如 ext4）**
```bash
sudo mkfs.ext4 /dev/md0
```

 **（2）创建挂载点并挂载**
```bash
sudo mkdir /mnt/raid
sudo mount /dev/md0 /mnt/raid
```

 **（3）开机自动挂载**
```bash
# 获取 RAID 的 UUID
sudo blkid /dev/md0

# 编辑 /etc/fstab
echo "UUID=你的-UUID /mnt/raid ext4 defaults 0 0" | sudo tee -a /etc/fstab
```

#### 6. 保存 RAID 配置
```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf  # Debian/Ubuntu
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf        # RHEL/CentOS

# 然后更新 initramfs：
sudo update-initramfs -u        # Debian/Ubuntu
sudo dracut -v -f               # RHEL/CentOS
```

#### 7. 故障处理
 **（1）模拟磁盘故障**
```bash
sudo mdadm /dev/md0 --fail /dev/sdb
```

**（2）移除故障盘**
```bash
sudo mdadm /dev/md0 --remove /dev/sdb
```

**（3）添加新盘**
```bash
sudo mdadm /dev/md0 --add /dev/sde
```

#### 8. 硬件 RAID 配置
如果使用 **硬件 RAID 卡（如 LSI MegaRAID）**：
1. 开机进入 RAID 卡 BIOS（按提示键，如 `Ctrl+H`）。
2. 在管理界面中创建虚拟磁盘（VD）。
3. 在 Linux 中识别为单块磁盘（如 `/dev/sda`），无需 `mdadm`。

#### 9. 总结

| 操作 | 命令/步骤 |
|------|----------|
| **安装工具** | `sudo apt install mdadm` |
| **创建 RAID** | `sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc` |
| **查看状态** | `cat /proc/mdstat` |
| **格式化** | `sudo mkfs.ext4 /dev/md0` |
| **挂载** | `sudo mount /dev/md0 /mnt/raid` |
| **自动挂载** | 编辑 `/etc/fstab` |
| **故障恢复** | `mdadm --fail /dev/md0 /dev/sdb` |

---

1. **数据备份**：RAID 不是备份！重要数据仍需额外备份。
2. **性能权衡**：RAID 0 快但无冗余，RAID 1/5/6 更安全但写入速度较慢。
3. **硬件 RAID**：优先使用主板/RAID 卡配置，性能更稳定。

通过以上步骤，你可以在 Linux 上轻松配置软件 RAID！ 🚀



### 目录结构

根据上述理论，所以磁盘是挂载在目录底下的。

 **[Linux文件系统](http://cn.linux.vbird.org/linux_basic/0210filepermission_3.php)**、 [FHS](https://www.pathname.com/fhs/)、[文件系统层次结构标准维基百科](https://zh.wikipedia.org/zh-cn/文件系统层次结构标准)

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

### 常见配置文件

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

#### 永久关闭swap分区

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
### 文件链接(非编译链接)

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



## 二 守护进程

### 1. 守护进程概述

Linux Daemon（守护进程）是运行在后台的一种特殊进程。它独立于控制终端并且周期性地执行某种任务或等待处理某些发生的事件。它不需要用户输入就能运行而且提供某种服务，不是对整个系统就是对某个用户程序提供服务。Linux系统的大多数服务器就是通过守护进程实现的。常见的守护进程包括系统日志进程syslogd、 web服务器httpd、邮件服务器sendmail和数据库服务器mysqld等。

守护进程一般在系统启动时开始运行，除非强行终止，否则直到系统关机都保持运行。守护进程经常以超级用户（root）权限运行，因为它们要使用特殊的端口（1-1024）或访问某些特殊的资源。

一个守护进程的父进程是init进程，因为它真正的父进程在fork出子进程后就先于子进程exit退出了，所以它是一个由init继承的孤儿进程。守护进程是非交互式程序，没有控制终端，所以任何输出，无论是向标准输出设备stdout还是标准出错设备stderr的输出都需要特殊处理。

守护进程的名称通常以d结尾，比如sshd、xinetd、crond等

### 2. 创建守护进程步骤

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
> （2）在子进程中调用setsid函数创建新的会话；
> （3）在子进程中调用chdir函数，让根目录 ”/” 成为子进程的工作目录；
> （4）在子进程中调用umask函数，设置进程的umask为0；
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


### 3. 创建守护进程
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

## 三 shell命令

### 常用
```shell
uname #查看计算机类型等系统信息

# 系统资源管理器
top

# 查看用户组
groups
# 查看用户组（更全）
# cat /etc/group

chsh -s /bin/zsh    #设置默认shell为zsh

env  #查看系统全部环境变量
echo $path #仅查看path
env|grep PATH #同样仅查看path

whereis zsh #返回二进制、man文件、src文件等路径
which zsh #shell的path中的二进制文件路径

man ln #查看ln这个指令的说明文档
```

### 系统时间

- timedatectl
- sntp
- chrony

| 特性/工具      | `timedatectl`            | `sntp`                   | `ntpq`                  | `ntpdate` (已弃用)         | `chrony` (`chronyd`/`chronyc`) |
| ---------- | ------------------------ | ------------------------ | ----------------------- | ----------------------- | ------------------------------ |
| **核心定位**   | 系统时间/日期/时区/NTP开关**管理前端** | 轻量级**一次性NTP客户端**         | **监控诊断工具** (针对 `ntpd`)  | **过时**的一次性NTP设置工具       | **现代NTP客户端/服务器实现套件**           |
| **是否持续同步** | ❌ (控制背后的服务)              | ❌ (运行一次退出)               | ❌ (查询工具)                | ❌ (运行一次退出)              | ✅ (`chronyd` 是守护进程)            |
| **主要功能**   | 查看/设置时间、时区、RTC、NTP开关     | 查询NTP服务器、一次性设置系统时间       | 查询/监控/诊断 `ntpd` 状态      | 强制一次性设置系统时间 (跳变)        | 持续NTP同步、时钟漂移补偿、NTP服务器          |
| **时间调整方式** | N/A                      | 可配置步进(Step)或倾斜(Slew)     | N/A                     | **强制步进(Step) 跳变**       | **优先倾斜(Slew)**，减少跳变            |
| **守护进程**   | ❌                        | ❌                        | ❌                       | ❌                       | ✅ (`chronyd`)                  |
| **监控工具**   | 基本状态 (`status`)          | ❌                        | ✅ (自身就是工具)              | ❌                       | ✅ (`chronyc`)                  |
| **网络中断处理** | N/A                      | N/A                      | N/A                     | N/A                     | ✅ (利用历史漂移率估算)                  |
| **启动同步速度** | N/A                      | ✅ (快)                    | N/A                     | ✅ (快，但有跳变风险)            | ✅✅ (非常快，设计目标之一)                |
| **资源占用**   | 很低                       | 很低                       | 低                       | 低                       | 低到中等                           |
| **现代推荐度**  | ✅✅ (管理首选)                | ✅ (替代 `ntpdate`， 用于简单场景) | ⚠️ (主要用于遗留 `ntpd` 系统诊断) | ❌ (避免使用)                | ✅✅✅ (默认首选实现)                   |
| **典型使用场景** | 日常时间/时区查看设置，启用NTP同步      | 脚本、嵌入式设备、快速一次性同步         | 诊断传统 `ntpd` 服务问题        | **无** (使用 `sntp` 或守护进程) | 服务器、桌面、笔记本、虚拟机等所有场景            |

```bash
# timedatectl
timedatectl set-timezone Asia/Shanghai
timedatectl set-ntp true
timedatectl status

# chronyd
sudo apt install chronyd
systemctl restart chronyd.service
chronyc tracking
chronyc sources

timedatectl status
```

### 权限

Linux chmod（英文全拼：change mode）命令是控制用户对文件的权限的命令

Linux/Unix 的文件调用权限分为三级 : 文件所有者（Owner）、用户组（Group）、其它用户（Other Users）。

![img](https://www.runoob.com/wp-content/uploads/2014/08/file-permissions-rwx.jpg)

只有文件所有者和超级用户可以修改文件或目录的权限。可以使用绝对模式（八进制数字模式），符号模式指定文件的权限。

![img](https://www.runoob.com/wp-content/uploads/2014/08/rwx-standard-unix-permission-bits.png)

**使用权限** : 所有使用者

#### 语法

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

#### 符号模式

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

#### 八进制语法

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



### 文件读写

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

### rsny
`rsync` 是一个强大的文件同步和传输工具，比 `scp` 更高效，支持**增量传输**（只传输变化的部分）、**断点续传**、**压缩传输**、**保留文件属性**（权限、时间戳等），是局域网或远程文件同步/备份的首选工具。

---

#### **1. 基本语法**
```bash
rsync [选项] 源文件 目标路径
```
- **源文件**：可以是本地路径或远程路径（格式：`user@host:path`）
- **目标路径**：可以是本地目录或远程服务器路径

#### **2. 常用选项**
| 选项 | 说明 |
|------|------|
| `-a` (archive) | 归档模式（保留权限、时间戳、递归目录等，相当于 `-rlptgoD`） |
| `-v` (verbose) | 显示详细传输信息 |
| `-z` (compress) | 压缩传输（节省带宽） |
| `-P` | 显示进度 + 支持断点续传（`--partial --progress`） |
| `-n` (dry run) | 模拟运行，不实际传输（测试用） |
| `--delete` | 删除目标端多余的文件（保持严格同步） |
| `-e ssh` | 使用 SSH 加密传输（默认支持，可省略） |
| `--exclude="*.log"` | 排除某些文件（如日志） |

#### **3. 常见用法示例**
 **(1) 本地同步（类似 `cp`，但更智能）**
```bash
rsync -avz /path/to/source/ /path/to/destination/
```
- 注意 `/` 的区别：
  - `source/` → 同步 `source` 目录下的**内容**到 `destination`
  - `source` → 同步 `source` 目录**本身**到 `destination`

 **(2) 同步到远程服务器（类似 `scp`，但更高效）**
```bash
rsync -avzP /local/path/ user@remote_host:/remote/path/
```
- `-P` 显示进度，支持断点续传
- `-z` 压缩传输（适合慢速网络）

 **(3) 从远程服务器同步到本地**
```bash
rsync -avzP user@remote_host:/remote/path/ /local/path/
```

 **(4) 排除某些文件（如 `node_modules` 或日志）**
```bash
rsync -avz --exclude="node_modules" --exclude="*.log" /source/ /dest/
```
或使用 `--exclude-from=FILE` 指定排除列表文件：
```bash
rsync -avz --exclude-from="exclude_list.txt" /source/ /dest/
```
`exclude_list.txt` 示例：
```
*.tmp
cache/
*.bak
```

 **(5) 删除目标端多余文件（严格同步）**
```bash
rsync -avz --delete /source/ /dest/
```
- 如果 `dest/` 中有 `source/` 没有的文件，`--delete` 会删除它们，确保两端完全一致。

 **(6) 限速传输（避免占用全部带宽）**
```bash
rsync -avz --bwlimit=1000 /source/ user@remote:/dest/
```
- `--bwlimit=1000` 限制速度为 1000 KB/s（单位：KB/s）

 **(7) 仅同步更新的文件（增量备份）**
```bash
rsync -avzu /source/ /dest/
```
- `-u` (update) 仅同步比目标端新的文件

 **(8) 使用 SSH 自定义端口**
```bash
rsync -avz -e "ssh -p 2222" /source/ user@remote:/dest/
```
- `-e "ssh -p 2222"` 指定 SSH 端口（如 2222）

#### **4. `rsync` vs `scp` 对比**
| 特性         | `rsync`       | `scp`    |
| ---------- | ------------- | -------- |
| **增量传输**   | 只传变化部分        | ❌ 每次全量传输 |
| **断点续传**   | 支持            | ❌ 不支持    |
| **压缩传输**   | ✅ `-z` 节省带宽   | ❌ 无压缩    |
| **目录同步**   | ✅ 递归同步目录      | ✅ 但效率低   |
| **删除多余文件** | ✅ `--delete`  | ❌ 不支持    |
| **带宽限制**   | ✅ `--bwlimit` | ❌ 不支持    |
| **模拟运行**   | ✅ `-n` 测试     | ❌ 不支持    |
| **速度**     | ⚡ 更快（增量+压缩）   | 🐢 较慢    |

- **同步目录**：`rsync -avz --delete /source/ /dest/`（严格同步）
- **排除文件**：`rsync -avz --exclude="*.log" /source/ /dest/`
- **限速传输**：`rsync -avz --bwlimit=1000 /source/ user@host:/dest/`


### 编译相关
```shell
##===================== c系语言 ========================
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

##======================其他======================
javac test.java #编译java
java test #运行java
```

###  网络相关
```shell
sudo apt install net-tools #安装ifconfig等工具（不用了，这个已经过时了，好多年不维护了，系统默认已改为iproute2 & netplan查询和设置网络）
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

netstat -nr // 显示路由表 

## ======= https://wsgzao.github.io/post/tcpdump/ =======
# 抓取包含 172.16.1.122 的数据包  
tcpdump -i eth0 -vnn host 172.16.1.122  
# 抓取包含 172.16.1.0/24 网段的数据包  
tcpdump -i eth0 -vnn net 172.16.1.0/24  
# 抓取包含端口 22 的数据包  
tcpdump -i eth0 -vnn port 22  
# 抓取 udp 协议的数据包  
tcpdump -i eth0 -vnn  udp  
# 抓取 icmp 协议的数据包  
tcpdump -i eth0 -vnn icmp  
# 抓取 arp 协议的数据包  
tcpdump -i eth0 -vnn arp  
# 抓取 ip 协议的数据包  
tcpdump -i eth0 -vnn ip  
# 抓取源 ip 是 172.16.1.122 数据包。  
tcpdump -i eth0 -vnn src host 172.16.1.122  
# 抓取目的 ip 是 172.16.1.122 数据包  
tcpdump -i eth0 -vnn dst host 172.16.1.122  
# 抓取源端口是 22 的数据包  
tcpdump -i eth0 -vnn src port 22  
```

#### DNS问题
1. **`/etc/resolv.conf` 的作用**
    - 这个文件是 Linux/macOS 系统中 **DNS 解析的配置文件**，指定了系统使用的 DNS 服务器地址。
    - 默认情况下，系统会使用网络接口（如路由器、ISP）提供的 DNS，但有时这些 DNS 可能不稳定或无法解析某些域名（如 Docker Hub）。
2. **`nameserver 8.8.8.8` 和 `nameserver 8.8.4.4` 的作用**
    - `8.8.8.8` 和 `8.8.4.4` 是 **Google 的公共 DNS 服务器**，它们通常比 ISP 提供的 DNS 更稳定、响应更快。
    - 修改后，系统会优先使用 Google DNS 解析域名，从而可能解决 Docker Hub 连接超时的问题。

这种修改是否影响全局网络？ **是的，会影响整个系统的 DNS 解析**
- 修改 `/etc/resolv.conf` 后，**所有网络请求**（不仅仅是 Docker）都会使用新的 DNS 服务器。
- 但通常不会有负面影响，因为 Google DNS (`8.8.8.8`) 是广泛使用的公共 DNS，稳定性和速度都较好。

⚠️ **注意**：
- 在 macOS 上，`/etc/resolv.conf` 可能是由 `systemd-resolved` 或 `NetworkManager` 动态管理的，手动修改可能会被覆盖。
- **在 macOS 上修改全局 DNS（推荐）**
	1. 打开 **系统偏好设置 > 网络**。
	2. 选择当前网络（如 Wi-Fi），点击 **高级 > DNS**。
	3. 添加 `8.8.8.8` 和 `8.8.4.4`，并拖到列表顶部。


### screen/tmux/zellij

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

### curl

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

### python 依赖
- [python build requirements](https://docs.python.org/3/using/configure.html#build-requirements)
#### linux python 依赖
见《 Linux - 小问题 - 安装pyenv &本地标准python》

#### mac python 依赖
```bash
# python依赖
# brew install tcl-tk # 有问题
brew install readline
brew install gdbm

# 这几个是brew 安装 python就会安装的
brew install mpdecimal
brew install openssl@3
brew install xz
brew install sqlite

pyenv install --force $(pyenv global)
```

#### mac tcl-tk python问题
- [python不兼容tcl-tk9](https://github.com/python/cpython/issues/112672)
```bash
# brew install tcl-tk # 有问题
brew install tcl-tk@8
# 因为@8不是默认，就需要加入环境变量（按照brew的指示）

# 或者，本质上跟上述一样，还是要tcl-tk@8
brew install python-tk@3.11
```
### pip
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


 #### python和pip包的版本/环境管理
这部分见
### git

---

单独写了一个git的描述文档在`learn-code/learn-tools/learn-git.md`里。

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

### vim

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

# Mac

## remove rosetta2
- [uninstall-rosetta-2](https://iboysoft.com/tips/uninstall-rosetta-2.html)
1. Reboot your Mac into Recovery Mode by restarting your computer and holding down Command+R until the Apple logo appears on your screen.
2. Click Utilities > Terminal.
3. In the Terminal window, type in `csrutil disable` and press Enter.
4. Restart your Mac.


## system data large
一般30G以内是正常，超过的话，基本都是缓存或者其他系统未识别的文件太多。
### user library
这部分可以删除全部的cache，和部分的container，不要再finder去找，从设置-储存 - documents - file browser来看，因为这里是自动搜索按照大小排序的。
###  ios backup
mac在iphone或ipad插上数据线时会自动备份。如果不需要可以删除，或者移到apfs的硬盘。

### time machine snapshots
- [How to delete Time Machine snapshots on your Mac](https://www.macworld.com/article/231067/how-to-delete-time-machine-snapshots-on-your-mac.html)

```bash
tmutil listlocalsnapshots /

# 显示com.apple.TimeMachine.2018-03-01-002010.local，只需要下面这个指令加上这个日期
sudo tmutil deletelocalsnapshots 2018-03-01-002010
```
## 系统设置

### 默认字小

> 默认字太小，分辨率缩放之后字体模糊

这个问题我同样遇到了， 结论就是最好不调缩放比例。因为非整数缩放几乎无法避免变模糊的问题，因为渲染像素无法点对点显示，所以我尝试的解决方案是：
1. 缩放比例使用系统默认
2. 在设置-辅助功能-显示中，调大字体，menu bar size 选large；
3. 然后系统软件字体一般都会自动调大；未适配软件，如terminal，sublime等可以自行设置字体大小；
4. 设置-外观中，sidebar icon size选large
上述几点基本上跟缩放差不多，又保证了清晰度。

### mac和windows自动切换键鼠

> ![一套键鼠跨平台、跨设备使用，除了通用控制还有哪些软硬件方案？](https://sspai.com/post/72143)

ShareMouse是一个不错的解决方案，尤其是mac和windows之间，可以使用mac的触控板，还不需要额外的设备（相比于logitech的Flow方案）

### mac取消自动备份iPhone
> [Disable automatic back up of your iOS devices](https://www.reddit.com/r/mac/?f=flair_name%3A%22Discussion%22)
If you are synchronizing on a Mac:
1. Close Music on your Mac.
2. Launch Terminal
3. Type 
```bash
defaults write com.apple.AMPDevicesAgent.plist AutomaticDeviceBackupsDisabled -bool true
```
and press Enter.
4. If you want to re-enable automatic backups, type
```bash 
defaults write com.apple.AMPDevicesAgent.plist AutomaticDeviceBackupsDisabled -bool false
```
and press Enter.
4. Reboot your Mac.
In case you need to backup, you have to do it manually now: press the "Back Up Now" button of the iOS device in Finder.

## 软件

### 开源工具


### 外接屏幕控制

#### 亮度控制
- [monitor control](https://github.com/MonitorControl/MonitorControl)

#### 开启HiDPi
- [M2 Macbook Pro外接2K显示器开启HiDPi](https://zhuanlan.zhihu.com/p/697043685)
**Github社区现有的两种为Mac开启HiDPi的工具存在问题：**

- [one-key-hidpi](https://link.zhihu.com/?target=https%3A//github.com/xzhih/one-key-hidpi) 提供的脚本不适用[M2芯片](https://zhida.zhihu.com/search?content_id=243028881&content_type=Article&match_order=1&q=M2%E8%8A%AF%E7%89%87&zhida_source=entity)，很多issue在讲这个问题
- [BetterDisplay](https://link.zhihu.com/?target=https%3A//github.com/waydabber/BetterDisplay) 虽然适用于[M芯片](https://zhida.zhihu.com/search?content_id=243028881&content_type=Article&match_order=1&q=M%E8%8A%AF%E7%89%87&zhida_source=entity)，但是它的原理是创建一个高分辨率镜像[虚拟显示器](https://zhida.zhihu.com/search?content_id=243028881&content_type=Article&match_order=1&q=%E8%99%9A%E6%8B%9F%E6%98%BE%E7%A4%BA%E5%99%A8&zhida_source=entity)。在我的使用中，会出现以下问题：（1）鼠标经常消失，需要在显示器点一下鼠标才会出现；（2）输入延迟，无论是键盘输入还是窗口拖拽，会有延迟和拖影（我一开始以为是Magic keyboard延迟或是显示器刷新率没设置对，后来发现是该软件的问题）

注意： [one-key-hidpi](https://link.zhihu.com/?target=https%3A//github.com/xzhih/one-key-hidpi) 现已解决此bug。


**官网**

* [Sublime](https://www.sublimetext.com)	        ---文本编辑器
* [localsend](https://localsend.org/)	        ---跨平台局域网文件传输
* [Itsycal](https://www.mowglii.com/itsycal/)               ---日期显示
* [Rectangle](https://rectangleapp.com)         ---窗口管理(现mac已集成)
* [FDM](https://www.freedownloadmanager.org)                  ---下载工具
* [Typaro](https://typora.io)               ---Markdown（不免费了，换mweb/vscode）
* [IINA](https://iina.io)                   ---视频播放器
* [Appcleaner](https://freemacsoft.net/appcleaner/)        ---软件卸载
* [f.lux](https://justgetflux.com)                    ---动态色温

* [Shadowsocks](https://github.com/shadowsocks/ShadowsocksX-NG)    ---代理（换ios的小火箭或clash verge 具体见小飞机部分）
* BackgroundMusic-调节声音

**App Store**

* HiddenBar         ---隐藏图标
* Unarchiver         ---解压工具
* BlackMagicDisk ---硬盘测速
* NewFileMenu    ---右键新建文件
* Cleaner Onelite  ---垃圾清理



### Edge卸载（大多Mac App完全卸载方式）

首先就是在Application文件夹中把Edge拖进Trash，然后删除其缓存、配置文件：

* ~/Library/Application Support/ 文件夹中找到并删除其中的 Microsoft Edge 文件夹
* ~/Library/Caches/ 文件夹中找到并删除其中的 Microsoft Edge 文件夹
* ~/Library/Saved Application State/ 文件夹中找到并删除其中的 com.microsoft.edgemac.savedState 文件夹
* ~/Library/WebKit/ 文件夹中找到并删除其中的 com.microsoft.edgemac 文件夹
* ~/Library/Preferences/ 文件夹中找到并删除其中的 com.microsoft.edgemac.plist 文件

- - - -


## Mac 快捷键

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

## Terminal
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

### mac系统环境变量
> Mac系统的环境变量，加载顺序为：
> /etc/profile
> /etc/paths 
> ~/.bash_profile 
> ~/.bash_login 
> ~/.profile 
> ~/.bashrc
> (etc目录下面的是系统级的配置，~目录下的是用户配置)
> /etc/profile和/etc/paths是系统级别的，系统启动就会加载，后面几个是当用户级的环境变量。后面3个按照从前往后的顺序读取.如果/.bash_profile文件存在，则后面的几个文件就会被忽略不读了;


### 终端中文支持
将下面几行代码加`.shellrc/.zshrc`。

但要注意的是，若有`ohmyzsh`，它会重置语言环境，所以需要将其添加在`source oh-my-zsh.sh`后。针对git中文乱码的情况，则需要`git config --global core.quotepath false`,关于git再单独一个文件中——`learn-code/learn-tools/learn-git.md`。

```shell
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
```

### mac terminal 标题
```shell
#加入.zshrc，取消ohmyzsh自动生成题目
DISABLE_AUTO_TITLE="true"
#再在terminal设置中window中设置显示项目
```

### mac terminal 取消login信息显示
```shell
touch ~/.hushlogin
```


### mac-terminal 指令
- [mac terminal command manual](https://www.dssw.co.uk/reference/)
#### 内存
```shell
top -l 1 | head -n 10 | grep PhysMem  #查看mac内存占用
sudo purge          #mac清理RAM  
```

#### 电源管理pmset
- `pmset -a`：调整任何条件下的睡眠计划
- `pmset -c`：调整外部供电的睡眠计划
- `pmset -b`：调整电池供电的睡眠计划
- `pmset -g`：查看计划

```bash
pmset -g custom	#显示电源设置
pmset -g log | egrep "\b(Sleep|Wake|DarkWake|Start)\s{2,}" # 查看睡眠唤醒log
sudo pmset -a tcpkeepalive 0  #关闭所有情况下睡眠是保持TCP链接的设置
man pmset

#查看电源设置的手册，比如下面这个：
	proximitywake - On supported systems, this option controls system wake from sleep based on proximity of devices using same 	iCloud id. (value = 0/1)
```
![](Unix-tips.assets/pmset.png)

#### 网络
```bash
netstat -an | grep 1080	 #查看端口号信息(lsof -i:80 也是看端口号)
>>> tcp6       0      0  ::1.1080          *.*             LISTEN     
>>> tcp4       0      0  127.0.0.1.1080    *.*             LISTEN 

```

#### mac defaults 指令
```
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

#### latex
- [Texlive 和 mactex-no-gui](https://www.reddit.com/r/LaTeX/comments/1e5nyrv/differences_between_texlive_and_mactexnogui/?tl=zh-hans)
```shell
brew install --cask mactex-no-gui

## sudo tlmgr repository set http://mirror.hust.edu.cn/CTAN/systems/texlive/tlnet #latex包设置镜像

## tlmgr update --self #更新tlmgr
```

#### 链接动态库！
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

#### mac .net core 安装位置
```shell
The following frameworks were found:
      5.0.2 at [/usr/local/share/dotnet/shared/Microsoft.AspNetCore.App]
```


### 终端软件管理
homebrew，curl，wget，pip，conda，yum，scoop……均是包管理器，也就是app store➕迅雷

决定Mac使用Homebrew+pip3来管理terminal的包下载。（pip已集成在python3里，叫pip3）

### Oh my zsh

安装插件步骤
```bash
 # 1. 终端输入
 vim ~/.zshrc

# 2. 找到 plugins=(zsh-syntax-highlighting)    #（）里增加要安装的插件

# 3. 终端输入: clone 与 $ 之间的网址就是安装文件GitHub网址，上述命令指：下载到~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 文件夹
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 4. 终端输入 更新配置文件
source ~/.zshrc

# 5. 重启终端
```


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

### Homebrew
mac上终端设置代理然后运行下面的install.sh（因为我用的是beta版系统，有时识别不出来就报错，所以把那个linux和mac的if语句删掉了，不判断直接执行）
**文件改动见`/Users/zxll/Documents/zx-profiles/teminal/homebrew改.sh`**
包下载位置一般在：**/Users/zxll/Library/Caches/Homebrew/downloads**

```shell
brew list #列出已安装的软件
brew outdated #查看哪些需要更新
brew update #更新brew
brew update-reset #“重装homebrew”
brew home #用浏览器打开brew的官方网站
brew info #显示软件信息brew deps #显示包依赖
brew upgrade #更新所有
brew upgrade  [Name] #更新指定包
brew cleanup #清理所有包的旧版本
brew cleanup  [Name] #清理指定包的旧版本
brew cleanup -n #查看可清理的旧版本包，不执行实际操作
brew deps --installed --tree #查看所有依赖关系
```

[brew清华源](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)
[brew阿里源](https://developer.aliyun.com/mirror/homebrew/)
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

### pdf2zh
- [github-PDFMathTranslate](https://github.com/Byaidu/PDFMathTranslate)
```bash
pip install pdf2zh
```

### yt-dlp

```bash
# https://github.com/yt-dlp/yt-dlp
pip install yt-dlp

# yt-dlp下载视频
yt-dlp youtube_url

# 下载的视频转换为h264编码(一般为vp9)，音频转换为aac(一般为opus), 封装为mp4(一般为mkv)
ffmpeg -i input.mkv -c:v libx264 -c:a aac output.mp4

# 只下载翻译的英文字幕，并转换为srt格式
yt-dlp --skip-download --write-auto-subs --sub-langs en --convert-sub srt https://www.youtube.com/watch?v=6vnU02PKkEs&t=2732s

# 只下载翻译的中文字幕，并转换为srt格式
yt-dlp --skip-download --write-auto-subs --sub-langs zh-Hans-en --convert-sub srt https://www.youtube.com/watch?v=6vnU02PKkEs&t=2732s
```

### pandoc
```bash
brew install pandoc

# 查看字体
fc-list :lang=zh

# mac
pandoc --pdf-engine=xelatex -V CJKmainfont="PingFang SC" input.md -o output.pdf

#windows
pandoc --pdf-engine=xelatex -V CJKmainfont="Microsoft YaHei" input.md -o output.pdf
```


### Neovim
[mac vim 配置](https://www.jianshu.com/p/923aec861af3)
```shell
#安装
brew install neovim
pip3 install neovim --upgrade
```

### ipython
```bash
import os
print (os.path.abspath('.'))      #查看python读取路径

~/.ipython/profile_default/startup  #创建一个自启默认设置https://www.pypandas.cn/docs/user_guide/options.html#overview

# pandas 多核运行 https://github.com/nalepae/pandarallel
df.parallel_apply(func) #加上这个使得命令利用多核
```

### “小飞机”
具体见小飞机笔记。
#### shadowsocks
> [shadowsocks-electron(ALL-platform)](https://github.com/nojsja/shadowsocks-electron)
* socket的pac文件

* clashx的rule(yaml文件)
![Screen Shot 2022-03-03 at 10.26.33](Unix-tips.assets/clash_rules.png)

> 配置文件需要放置在 $HOME/.config/clash/*.yaml
> 这份文件是clashX的基础配置文件，请尽量新建配置文件进行修改。
> 只有这份文件的端口设置会随ClashX启动生效
> 如果您不知道如何操作，请参阅[官方Github文档](https://github.com/Dreamacro/clash/blob/dev/README.md)


### sublime

sublime 快捷键：

* `cmd+c/v/x` 复制/粘贴/剪切 某行（不需要选中）
* `cmd+d/u`   选词/撤销上个选词（选中一个词后，多光标选同样word）
* `cmd+/`     注释本行
* `cmd+[/]`   缩进与取消缩进（选中多行可以同时）
* `cmd+k`     打开/关闭侧边文件栏
* `cmd+F`     搜索
* `cmd+G`     搜索中为搜索下一个
* `opt+Enter` 搜索中搜索并选中全部
* opt+'click'  进入列选择模式
* `cmd+Arrow` 去最上或最下
* `F12`/`cmd+opt+Arrow down`     跳转定义

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
#### 主题随主题更改
`setting` 搜索 `auto detect color scheme`
再设置好`light color scheme` 和 `dark color scheme`

#### vscode快捷键
* **`cmd+c/v/x` 复制/粘贴/剪切 某行（不需要选中）**
* **`cmd+d/u`   选词/撤销上个选词（选中一个词后，多光标选同样word）**
* **`cmd+/`       注释本行**
* **`cmd+[/]`   缩进与取消缩进（选中多行可以同时）**
* **`cmd+B`      打开/关闭侧边文件栏**
* **`ctrl+B`    运行脚本**
* **`cmd+F`     搜索**
* **`cmd+R`     打开最近**
* **`cmd+T`     打开下面分割的终端**
* **`cmd+J`     打开控制台**
* **`cmd+P`     打开文件**
* **`cmd+G`     搜索中为搜索下一个**
* **`opt+Enter` 搜索中搜索并选中全部**
* **opt+shift+'click'  进入列选择模式**
* **`cmd+Arrow` 去最上或最下**
* **`cmd+E`/`cmd+opt+Arrow down`  跳转定义**

## mac小问题

### [Mds_Stores 进程高占用](https://www.easeus.com/computer-instruction/mds-store.html#temporarily_stop_and_restart_spotlight)
Are you wondering what Mds_Stores is? If you are not too tech-savvy, seeing such a massive CPU utilization on one process can be jarring. Let's know more about this software problem. 

The Mds_Stores is an in-built indexing process integrated into the Mac Spotlight Search. Here, the MDS stands for metadata server. The MDS tracks and maintains the data present on the Mac and is used by the macOS [Spotlight](https://en.wikipedia.org/wiki/Spotlight_\(software\)). It is the responsibility of Mds_Stores to maintain and compile the data that MDS collects to make Spotlight more efficient. 

Mds_Stores facilitates quick Spotlight search results. The recommendations you get when you type something into the Spotlight are due to the Mds_Stores. That makes it easier for you to complete the task.

1. [Reboot Your Mac](https://www.easeus.com/computer-instruction/mds-store.html#reboot_your_mac)
2. [Disable Spotlight](https://www.easeus.com/computer-instruction/mds-store.html#disable_spotlight)
3. [Temporarily Stop and Restart Spotlight](https://www.easeus.com/computer-instruction/mds-store.html#temporarily_stop_and_restart_spotlight)

# 共用键鼠
## deskflow
[deskflow](https://github.com/deskflow/deskflow/)

### deskflow无法连接
```bash
# deskflow-server 权限，就在app的contents里，对应的就是mac设置-network-firewall-options界面中的权限表。
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Deskflow.app/Contents/MacOS/deskflow-server
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /Applications/Deskflow.app/Contents/MacOS/deskflow-server

# deskflow-client 权限
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Deskflow.app/Contents/MacOS/deskflow-client
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /Applications/Deskflow.app/Contents/MacOS/deskflow-client

# 重启下server和client就可以了
```

### deskflow 配置
有时候可能会出现配置错误，比如mac端换了一个名字，就无法开启server了，是因为名称不一致，这时候找到两个配置文件：`~/Library/Deskflow/deskflow-server.conf`和`~/Library/Deskflow/Deskflow.conf`
windows就是`C:\ProgramData\Deskflow\deskflow-server.conf`

### deskflow 输入法语言bug
```bash
WARNING: current server language is not installed on client
```
目前只能是mac用英语的时候切过去可以。

 

```yaml
section: screens
	zx-lls-MacBook-Pro.local:
		halfDuplexCapsLock = false
		halfDuplexNumLock = false
		halfDuplexScrollLock = false
		xtestIsXineramaUnaware = false
		switchCorners = none
		switchCornerSize = 0
	zhengxu-work:
		halfDuplexCapsLock = false
		halfDuplexNumLock = false
		halfDuplexScrollLock = false
		xtestIsXineramaUnaware = false
		switchCorners = none
		switchCornerSize = 0
end

section: aliases
end

section: links
	zx-lls-MacBook-Pro.local:
		right = zhengxu-work
	zhengxu-work:
		left = zx-lls-MacBook-Pro.local
end
```
# Linux

## 可视化软件
官网下载要注意最好搜一搜怎么添加apt源，否则更新比较麻烦，现在很多app都在ubuntu的应用商店中，优先选择这种安装方式。

| 软件名称                                        | 类型                                                      | 安装方式                                                 |
| ------------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------- |
| [Flathub](https://flathub.org/setup/Ubuntu) | 软件商店                                                    | 按照官网apt安装                                            |
| QQ                                          | 聊天                                                      | 官网下载dpkg安装                                           |
| Edge                                        | 浏览器                                                     | 官网dpkg&添加软件源                                         |
| pdfarranger                                 | PDF编辑                                                   | apt install                                          |
| VLC                                         |                                                         | Ubuntu 应用商店或官网                                       |
| Blender                                     | 3D建模/动画                                                 | Ubuntu 应用商店或官网                                       |
| GNU image                                   | 图片编辑                                                    | Ubuntu 应用商店或官网                                       |
| VScode                                      | 代码编辑器                                                   | 官网（Ubuntu 应用商店安装的有bug)                               |
| FreeCAD                                     | CAD工程图                                                  | Ubuntu 应用商店或官网                                       |
| kicad                                       | 电路&PCB                                                  | Ubuntu 应用商店或官网                                       |
| LocalSend                                   | 局域网传文件                                                  | Ubuntu 应用商店或官网                                       |
| Inkscape                                    | 矢量图做图                                                   | Ubuntu 应用商店或官网                                       |
| Krita                                       | 画画                                                      | Ubuntu 应用商店或官网                                       |
| Kdenlive                                    | 视频编辑器                                                   | Ubuntu 应用商店或官网                                       |
| Foliate                                     | 阅读器                                                     | Ubuntu 应用商店或Flathub商店                                |
| zotero                                      | 文献管理                                                    | Ubuntu 应用商店或官网                                       |
| goldendict                                  | [翻译](https://www.cnblogs.com/keatonlao/p/12702571.html) | [官网](https://github.com/goldendict/goldendict)或apt安装 |
| 欧陆词典                                        | 翻译                                                      | 官网下载Deb安装                                            |


## 小问题

### 安装unbuntu-win双系统
有iCloud Books中的pdf 文件备份
https://blog.csdn.net/NeoZng/article/details/122779035

### 安装pyenv &本地标准python
本地没法用apt 安装python，先安装系统python-pip
```bash
sudo apt install python3-pip
sudo apt install python3-virtualenv
```

编译pthon 所需要的库：
```bash
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libbz2-dev liblzma-dev sqlite3 libsqlite3-dev tk-dev uuid-dev libgdbm-compat-dev
```

安装

这些包有问题迟早要还（`sudo apt install --reinstall ？=？`来指定安装的版本），比如下面：

错误 no module named zlib：
解决：sudo apt install libffi-dev

错误 No module named '_bz2'：
解决：sudo apt install libbz2-dev，但是可能报错libbz2-1.0版本不对，这时候需要sudo apt install --reinstall libbz2-1.0=1.0.8-5.1（具体版本看报错信息）

错误：No module named '_ctypes'：
解决：sudo apt install libffi-dev 
No module named '_tkinter'解决：sudo apt install tk-dev

#### pyenv cache
pyenv 安装python需要代理，可以自己代理下载或者下载镜像文件放到pyenv的cache文件夹中，也就是`~/.pyenv/cache`。


### linux 串口无法访问（权限低）
- []()
```bash
# 临时处理
sudo chmod 777 /dev/ttyUSB0

# 永久处理(最后是自己的用户名)，然后重启
sudo usermod -aG dialout zx
```

### ubuntu 安装arm-none-eabi-gcc
Apt库里有这个交叉编译的gcc，但是没有gdb，所以需要自己安装。（不排除未来加入gdb的可能性，那就可以用apt安装了）见文链接。但是apt中的版本先用search看一下，如果版本太老（2025年还是10.3几年没更新了），就在下面两个网站下载：（建议官网，deb的需要额外库）

- [aliyun-arm-gcc-deb](https://mirrors.aliyun.com/ubuntu/pool/universe/g/gcc-arm-none-eabi/)
- [arm官方下载,不需要额外库but slow](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
```bash
sudo apt search gcc-arm-none-eabi

# 如果版本不老，就不需要下载，直接apt安装
sudo apt install gcc-arm-none-eabi
```

1. 需要安装的库
```bash
sudo apt install build-essential zlib1g-dev libexpat1-dev \
libssl-dev libc6-dev libbz2-dev libffi-dev \
libdb-dev liblzma-dev libncurses-dev \
libncursesw5-dev libsqlite3-dev libreadline-dev \
uuid-dev libgdbm-dev tk-dev libbluetooth-dev
```

2. 分三种情况
	1. 如果apt安装，无需操作
	2. 如果下载的是deb包，则`sudo dpkg -i gcc-arm-none-eabi-*名字**.deb`
	3. 如果是压缩包（建议），以`arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz`为例
```bash
# 解压可视化操作
# sudo tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz

# 复制到/usr/share/
sudo cp -r arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi /usr/share/

sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc 
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-as /usr/bin/arm-none-eabi-as
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy
sudo ln -s /usr/share/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump

#如果报错显示 /usr/bin/arm-none-eabi-gcc already exists，则：
sudo rm /usr/bin/arm-none-eabi-gcc 
sudo rm /usr/bin/arm-none-eabi-g++
sudo rm /usr/bin/arm-none-eabi-gdb
sudo rm /usr/bin/arm-none-eabi-size
sudo rm /usr/bin/arm-none-eabi-as
sudo rm /usr/bin/arm-none-eabi-objcopy
sudo rm /usr/bin/arm-none-eabi-objdump
```

3. 如果执行`arm-none-eabi-gcc -v`报错没有libncurses.so.5，则链接如下两个库
```
sudo ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5
```
[ubuntu安装arm-none-eabi-gdb问题](https://askubuntu.com/questions/1243252/how-to-install-arm-none-eabi-gdb-on-ubuntu-20-04-lts-focal-fossa)

### ubuntu 修改键盘映射
[ubuntu交换alt和ctrl](https://www.cnblogs.com/liuzhch1/p/16047019.html)
在 Ubuntu 下交换`Alt`和`Ctrl`键：

```bash
code /usr/share/X11/xkb/keycodes/evdev
```

或者用系统默认编辑器打开：

```bash
sudo xdg-open /usr/share/X11/xkb/keycodes/evdev
```

然后找到`LALT`和`LCTL`所在的行，它们的默认值应该为`<LALT>=64`, `<LCTL>=37`。把它们的值互换即可交换这两个键。

其他的按键映射同理。

最后重启使更改生效

```undefined
reboot
```

---

此外还可以用 Ubuntu 自带的软件进行更改。按下`Super`键(也就是`Win`键)，输入`Tweaks`，一个开关图标的软件就会跳出来(中文名叫`优化`)。打开它，在左边栏选择`键盘和鼠标`，在`键盘`里最后`其他布局选项`。在`Alt/Win键行为`或`Ctrl键位置`里自行修改。  
但是我自己使用`优化`进行更改有时候会失效，比如在挂起之后。更改keycodes暂时没有遇到失效的情况。

### Ubuntu安装驱动

```shell
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
#如果想安装特定项，就用apt install 
```
### Ubuntu设置中文输入法

> [引用博客](https://blog.csdn.net/weixin_44916154/article/details/124582379)
> ### 安装 Chinese 语言包
> 2. 单击桌面右上角图标，点击 Settings，在弹出的窗口中，点击 Region & Language，然后点击 Manage Installed Languages
> 3. 在 Language Support 窗口中，单击 Install/Remove Languages...
> 4. 在弹出的 Installed Languages 窗口中，找到 Chinese(simplified)，然后将其勾选，最后单击 Apply，如果进行了第4步的话，会发现 Chinese(simplified) 已经安装了
> ### 安装输入法
> 5. 终端输入`sudo apt-get install ibus-pinyin`
> ### 设置输入法
> 6. 安装好后，进入 Settings，点击 Keyboard，再点 Input Sources 下的 `+`，在 Add an Input Source 窗口中选择 Chinese，然后选择 Chinese(Intelligent Pinyin) 并单击 `Add`
> 7. shift就可以切换中英文了，win+space也可以。



### 指纹解锁?
https://github.com/Am0rphous/Shenzhen-Goodix-Fingerprint-Reader
```bash
#能看到fingerprint
lsusb

#设置uesrs密码那里如果没有，ke nengp可能是指纹解锁不是rem认证设备
# 下面指令ab一下，看看有带tod的嘛，
sudo apt install libfprint
sudo apt install libfprint-2-tod1

# 下载驱动：比如我的是gooddix fingerprint 找一找
#http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/
sudo dpkg -i ****.deb

#空格修改，enter确认
sudo pam-auth-update
fprintd-verify
fwupdmgr update                            #Updates firmware
sudo systemctl restart fprintd.service     #Restarts the fprintd service
sudo systemctl status fprintd.service      #Lets check the status
fprintd-enroll                             #Starts the enrolling process when setting up the figngerprint
journalctl -f -u fprintd.service           #any error should show here
```

### 安装whisper-cli问题
- [hf-mirror大模型网站镜像](https://hf-mirror.com)
[whisper.cpp](https://github.com/ggerganov/whisper.cpp)
问题：当编译cuda版本时，即：
```bash
cmake -B build -DGGML_CUDA=1
cmake --build build -j --config Release
```
错误如下：
```bash
nvcc warning : Cannot find valid GPU for '-arch=native', default arch is used
```
[问题](https://github.com/ggerganov/whisper.cpp/issues/876)？[解决？](https://forums.developer.nvidia.com/t/cant-compile-with-cuda-support/284731)：

- [cuda-downloads](https://developer.nvidia.com/cuda-downloads)
- [cudnn-archive](https://developer.nvidia.com/rdp/cudnn-archive)
```bash
# 之后又不行了，原因就是sudo apt install nvidia-cuda-toolkit来安装，但是版本太老，会有问题

# 以ubuntu24.04为例，一下指令参考上述nvidia官网链接

# 安装cuda-runfile方式
wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/cuda_12.6.3_560.35.05_linux.run
sudo sh cuda_12.6.3_560.35.05_linux.run

# 安装cudnn-Deb方式
wget https://developer.download.nvidia.com/compute/cudnn/9.8.0/local_installers/cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo dpkg -i cudnn-local-repo-ubuntu2404-9.8.0_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-ubuntu2404-9.8.0/cudnn-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cudnn-cuda-12

# 然后删除build文件夹（make clean）
cmake -B build -DGGML_CUDA=1
# 下面这个得加入环境变量 
export CUDA_ARCH_FLAG=sm_86
cmake --build build -j --config Release
```
要强调一下：硬件型号-驱动版本−cuda版本−cudnn版本，是有依次的依赖关系的。哪个低了都要依着低的那个版本要求来。比如同样30系显卡要560驱动就可以安装cuda12.6，但是550驱动就最高安装cuda12.4。


具体sm_86可以见[官网](https://developer.nvidia.com/cuda-gpus)。
关于whipser详细信息见computer tips中的whisper部分。

### 国内源安装docker
1. 安装
```bash
# 卸载docker
sudo apt-get remove docker docker-engine docker.io containerd runc
# 安装依赖
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
# 阿里云key
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# 阿里云ppa
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# 安装docker
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# 用户权限
sudo usermod -aG docker $USER
reboot
```

2. docker pull设置镜像
国内大部分docker镜像都失效了，但是可以登陆[阿里云账号](https://cr.console.aliyun.com)[设置镜像](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)。
好像阿里也失效了，[github-docker-镜像网站](https://github.com/DaoCloud/public-image-mirror)
```bash
sudo vim /etc/docker/daemon.json
# 然后添加如下内容
{
    "registry-mirrors": ["https://docker.m.daocloud.io"] 
}
# 然后重启该服务
sudo systemctl daemon-reload
sudo systemctl restart docker
```
具体其他问题比如设置代理等，参考`learn-code`仓库中的`learn-docker.md`笔记文件。
### 安装腾讯会议问题
1. wayland
```bash
# 有vscode或者sublime插件也可以把vi换成code/st
sudo vi /opt/wemeet/wemeetapp.sh

# 在if [ "$XDG_SESSION_TYPE" = "wayland" ]前面加上：
# force x11 instead of Wayland
export XDG_SESSION_TYPE=x11
export EGL_PLATFORM=x11 
export QT_QPA_PLATFORM=xcb
unset WAYLAND_DISPLAY 
unset WAYLAND_DISPLAYCOPY
```
2. 可以打开但是没法共享屏幕
```bash
sudo vi /etc/gdm3/custom.conf
# 把 < #WaylandEnable=false > 的注释井号去掉,然后重启，就可以解决无法屏幕共享的问题
```

### 安装openlane
- [openlane2](https://openlane2.readthedocs.io/en/latest/)
```bash
# 先安装docker（mac，ubuntu见上文）
brew install --cask docker

# 安装openlane2
pip install openlane
```

[OpenLane1](https://github.com/The-OpenROAD-Project/OpenLane)

```bash
# 这个是openlene1的安装，不如直接安装openlane2
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make

# 如果错误时没有nix，则
sudo apt install nix
# 如果还有错误：没有启用Flakes，全局用/etc/nix/nix.conf
sudo vi /etc/nix/nix.conf
# 用户：vi ~/.config/nix/nix.conf
# 文件中添加一行；experimental-features = nix-command flakes

#如果有权限问题
sudo make
```

### 安装vulkan
```bash
sudo apt install vulkan-tools libvulkan-dev
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list https://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
sudo apt update
sudo apt install vulkan-sdk
```

### 安装TI-CCS
- [CCSTUDIO](https://www.ti.com/tool/CCSTUDIO#downloads)
- [ccs_installation](https://software-dl.ti.com/ccs/esd/documents/users_guide_12.2.0/ccs_installation.html)
- [CCS-linux-support](https://software-dl.ti.com/ccs/esd/documents/ccs_theia_linux_host_support.html)

```bash
# 缺少libusb
sudo apt install libusb-dev

# 缺少libtinfo5（ubuntu24版本是6）
wget http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.3-2ubuntu0.1_amd64.deb
sudo dpkg -i libtinfo5_6.3-2ubuntu0.1_amd64.deb

# 缺少libpython3.9.so.1.0 可以不理会
```

#### 安装mspm0-openocd
目前2025年mspm0和stm32的开源流程的核心区别在于openocd官方还未支持mspm0，ti已经开发了支持mspm0的openocd。据[官方帖子](https://e2e.ti.com/support/microcontrollers/arm-based-microcontrollers-group/arm-based-microcontrollers/f/arm-based-microcontrollers-forum/1373048/mspm0l1105-flashing-mspm0l1105-using-openocd)& [openocd分支来自Nishanth Menon](https://review.openocd.org/c/openocd/+/8385)。方法就是自己[github](https://github.com/nmenon/openocd/tree/master)下载并编译：
```bash
# 0. install deps (for example on ubuntu)
sudo apt update
sudo apt install git make autoconf automake libtool pkg-config libusb-dev libftdi1-dev libhidapi-dev

# 1. clone
mkdir openocd-mspm0
cd openocd-mspm0
git clone https://github.com/nmenon/openocd.git
cd openocd

# 2. prepare (like clone and make jimtcl)
./bootstrap
git submodule init
git submodule update
cd jimtcl
./configure
make
sudo make install

# 3. make (二进制文件/指令 的地址可以按需指定)
cd ..
./configure --prefix=/home/zx/Develop/openocd-mspm0
make
sudo make install

# 4. use dap (文件 cmsis-dap.cfg 和 ti_mspm0.cfg 也要指定位置或者拷贝到项目地址)
/home/zx/Develop/openocd-mspm0/bin/openocd  -f cmsis-dap.cfg -f ti_mspm0.cfg -c init -c "reset halt" -c "wait_halt" -c "flash write_image erase Debug/try_mspm0g3507.out" -c reset -c shutdown

# 5. debug 指定好cortex-debug插件的openocd地址就可以，或者在launch文件中指定
```

### 代理
v2rayA 应用商店就可以下载（但安装有些问题，具体见小飞机章节或者官网）github也可以（推荐）。是linux中比较稳定和轻量的代理。
![](Unix-tips.assets/Ubuntu-v2rayA-setting.png)1. ubuntu-setting-network-proxy is on, 
1. and http port is 20172 by default,
2. which means export http/s proxy = http://localhost:20172
3. cursor setting: add http://localhost:20172 and turn off http2

### ubuntu 无法使用cv2.imshow()
安装contrib版本：pip install opencv-contrib-python

### 开机卡在dev/sda1: clean,… files, …blocks
有可能是[nvidia显卡驱动](https://askubuntu.com/questions/882385/dev-sda1-clean-this-message-appears-after-i-startup-my-laptop-then-it-w)问题。

```bash
#比如版本460，就把460相关的都删了，下面指令tab，自动补全找那个版本。
#比如sudo apt purge nvidia-driver-460 nvidia-kernels-common-460
sudo apt purge nvidia-

#然后自动安装显卡驱动
sudo ubuntu-drivers autoinstall

#应该就成了
```

### 增加swap
不能直接用 GParted 来调整 swap 文件的大小，因为：
- GParted 操作的是分区（block device），而你用的是swap 文件；
- swap 文件是位于某个分区中的普通文件，它的大小不受 GParted 控制。
---

你可以通过命令行方式，删除旧 swap 文件并创建新的更大的 swap 文件，步骤如下：
（将 swap 文件从 2G 改为 8G）

#### 1. 关闭并删除当前 swap
```bash
sudo swapoff /swapfile
sudo rm /swapfile
```

#### 2. 创建新的 4G swap 文件
```bash
sudo fallocate -l 8G /swapfile
# 或用 dd（速度慢一些）
# sudo dd if=/dev/zero of=/swapfile bs=1M count=4096
```

#### 3. 设置权限
```bash
sudo chmod 600 /swapfile
```

#### 4. 格式化为 swap
```bash
sudo mkswap /swapfile
```

#### 5. 启用新的 swap
```bash
sudo swapon /swapfile
```

#### 6. 确保开机自动挂载（检查 /etc/fstab）
```bash
cat /etc/fstab
```

确认有以下一行（如果没有就加上）：
```bash
/swapfile none swap sw 0 0
```

---
#### 🔍 检查是否生效
```bash
free -h
```

应该能看到 swap 变成了 8G。

---
如果用 swap 分区（更适合内存压力大的环境），也可以用 GParted 添加 swap 分区并启用它。


在 Linux 上配置 RAID（冗余磁盘阵列）可以通过 **软件 RAID（如 `mdadm`）** 或 **硬件 RAID（如主板/RAID 卡）** 实现。以下是详细步骤：

---

## Terminal：
### dircolors

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



### 指令

```shell
systemctl start sshd.service   # 开启ssh服务

systemctl enable sshd.service #ssh 开机自启

sudo apt install net-tools #安装ifconfig等工具
sudo apt install build-essential #安装gcc、g++、make等
apt-cache show gcc #Ubuntu 看软件库中软件信息
dpkg -L gcc #Ubuntu查看gcc所有文件都安装在哪里

```

## linux桌面

| **桌面环境/窗口管理器**               | **RAM used** | **% CPU used** | **类型**      |
| ---------------------------- | ------------ | -------------- | ----------- |
| KDE 4.6                      | 363 MB       | 4 %            | 桌面环境        |
| Unity                        | 271 MB       | 14%            | 桌面环境(shell) |
| GNOME 3                      | 193 MB       | 10%            | 桌面环境        |
| GNOME 2.x                    | 191 MB       | 1 %            | 桌面环境        |
| XFCE 4.8                     | 144 MB       | 10 %           | 桌面环境        |
| LXDE                         | 85 MB        | 10 %           | 桌面环境        |
| IceWM                        | 85 MB        | 2 %            | 窗口管理器       |
| Enlightenment (E17 Standard) | 72 MB        | 1 %            | 窗口管理器       |
| Fluxbox                      | 69 MB        | 1 %            | 窗口管理器       |
| OpenBox                      | 60 MB        | 1 %            | 窗口管理器       |
| JWM                          | 58 MB        | 1 %            | 窗口管理器       |

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

# reference

* **[mac 设置指南](https://github.com/macdao/ocds-guide-to-setting-up-mac)**
* **[mac dock设置](https://sspai.com/post/33493)**
* **[Linux文件系统](http://cn.linux.vbird.org/linux_basic/0210filepermission_3.php)**
* **[oh my zsh配置](https://www.zrahh.com/archives/167.html)**
* **[win-vim安装](https://segmentfault.com/a/1190000019360991)**

# zx mac 新机设置流程

## system settings

### 字体大小
 - accessbility - display - text size 设为16pt（14寸）

### 三指拖移
 - system settings - accessbility - point control - tracpad options

### firewall
- system settings - network - firewall



## iCloud

- 登陆iCloud
- system settings - general - storage - store in iCloud （select all）
- App Store 安装所需
- 登陆美区appstore，安装小飞机
- 小飞机改端口、改规则(conf)为黑名单，然后重新开关&更新一下。
- safari换成google


## 安装第三方非命令行软件

- vscode
- obisidian
- chatbox
- [AlDente](https://apphousekitchen.com/aldente-overview/pricing/): 按照设置关闭电池相关，并关上电池供电时屏幕亮度降低。
- sublime: 找到备份设置更改 sublime settings & 添加更改的breaker主题


## init shell cmd
terminal settings 加载 iCloud/github中的zxlldynamic.terminal文件，并设置为default
备份的.vimrc拷贝到

```bash
# 安装xcode clt
xcode-select --install

# 系统设置
defaults write com.apple.AMPDevicesAgent.plist AutomaticDeviceBackupsDisabled -bool true
sudo pmset -c tcpkeepalive 0
sudo pmset -b powernap 0

# 安装brew（国内）
# 从阿里云下载安装脚本并安装 Homebrew 
git clone https://mirrors.aliyun.com/homebrew/install.git brew-install
sh brew-install/install.sh 
rm -rf brew-install 
# 也可从 GitHub 获取官方安装脚本安装 Homebrew 
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 临时替换homebrew源
export HOMEBREW_INSTALL_FROM_API=1 
export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"

brew update

# macOS 现在默认是zsh了
# brew install zsh
# chsh -s $(which zsh)

# 安装ohmyzsh
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"

export ALL_PROXY=socks5://127.0.0.1:7897
# 安装ohmyzsh插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 然后再在zshrc的plug中写上这俩的名字
unset ALL_PROXY


# zshrc 加入homebrew的环境变量
echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.zshrc

## ============ 下面这些加入zshrc ============ ##

# Set homebrew mirror
# 自 brew 4.0.0 (2023 年 2 月 16 日) 起，HOMEBREW_INSTALL_FROM_API 会成为默认行为，无需设置。
# 大部分用户无需再克隆 homebrew-core 仓库，故无需设置 HOMEBREW_CORE_GIT_REMOTE 环境变量；
export HOMEBREW_INSTALL_FROM_API=1
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"

export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/"

export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"

## ============ 上面这些加入zshrc ============ ##
source ~/.zshrc

# 安装其他工具
brew install wget
brew install cmake
brew install tmux
brew install tree
brew install pandoc

brew install --cask docker
brew install kubernetes-cli
brew install --cask gcc-arm-embedded
brew install --cask monitorcontrol
brew install --cask mactex-no-gui
brew tap deskflow/homebrew-tap
brew install deskflow

brew install ffmpeg # 依赖太多，后期用可安装
brew install openocd
# brew install qt # 依赖太多，后期用可安装
# brew install rust
# brew install node # 依赖太多，后期用可安装
# brew install docker # 这个不是见learn-docker.md


# 安装python依赖（tcl-tk问题@8?）
brew install gdbm
brew install openssl@3
brew install xz
brew install sqlite
brew install tcl-tk

# 安装python虚拟环境
brew install pyenv

# pyenv settings, 这些放到zshrc中
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc 
echo 'export PATH="$PYENV_ROOT/bin:$PATH" ' >> ~/.zshrc 
echo 'export PATH=$PYENV_ROOT/shims:$PATH' >> ~/.zshrc 
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc 
source ~/.zshrc


# pyenv安装python
pyenv install -l
pyenv install 3.12.11
pyenv versions
pyenv global 3.12.11

# 设置pip国内代理
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/
pip config set install.trusted-host pypi.tuna.tsinghua.edu.cn

# 设置git账号密码https://docs.github.com/en/account-and-profile/how-tos/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address#setting-your-commit-email-address-on-github

```

上述pip源指令等同于---下面内容写入该文件：`~/.config/pip/pip.conf`
```text
[global]
index-url = https://mirrors.aliyun.com/pypi/simple

[install]
trusted-host = mirrors.aliyun.com
```

# zx ubuntu 新机设置流程

## init shell cmd

```bash
# 换源：https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
# 桌面版换源可以直接在update可视化工具中选择，也可按照上述连接操作
sudo apt update
sudo apt upgrade

# 安装驱动
sudo ubuntu-drivers autoinstall

# 官网下载vscode & Linuxqq
sudo dpkg -i ****.deb

sudo apt install build-essential
sudo apt install -y git vim zsh curl wget ffmpeg tmux cmake tree net-tools pandoc nodejs npm
chsh -s $(which zsh)
# 安装ohmyzsh
sh -c "$(wget -O- https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"

# 安装ohmyzsh插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 然后再在zshrc的plug中写上这俩的名字

# 安装输入法（先根据上述章节确定安装了中文）
sudo apt install -y ibus-pinyin

# 安装pyenv&python
sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libbz2-dev liblzma-dev sqlite3 libsqlite3-dev tk-dev uuid-dev libgdbm-compat-dev

curl -fsSL https://pyenv.run | bash

  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
  echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc

pyenv install -l
pyenv install 3.11.11
pyenv versions
pyenv global 3.11.11

# 设置pip国内代理
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/
pip config set install.trusted-host pypi.tuna.tsinghua.edu.cn

```