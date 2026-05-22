
## 整体过程

### 1. 最开始的问题
```bash
➜  ~ sudo apt upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Error!
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 libnvidia-gl-580 : Conflicts: libnvidia-egl-gbm1
                    Conflicts: libnvidia-egl-gbm1:i386
 libnvidia-gl-580:i386 : Conflicts: libnvidia-egl-gbm1
                         Conflicts: libnvidia-egl-gbm1:i386
E: Unable to correct problems, you have held broken packages.
### 2. 然后我们先 hold nvidia 相关的，更新了其他的
```bash
sudo apt-mark hold 'libnvidia-*580*' 'nvidia-*580*'
sudo apt update
sudo apt upgrade
```

### 3. 解封定位问题
```bash
sudo apt-mark unhold 'libnvidia-*580*' 'nvidia-*580*'
```

### 3.1 模拟移除看问题（-s 就是模拟）
```bash
sudo apt -s remove libnvidia-egl-gbm1 libnvidia-egl-gbm1:i386
```

### 3.2 进一步定位是否是源冲突
```bash
apt policy libnvidia-gl-580 libnvidia-gl-580:i386 nvidia-driver-580 libnvidia-egl-gbm1 libnvidia-egl-gbm1:i386
```

原因清晰了：
- Ubuntu 官方源 / USTC 镜像：580.159.03-0ubuntu0.24.04.1，优先级 500
- NVIDIA CUDA 官方仓库：580.159.04-1ubuntu1，优先级 600

因为 CUDA 仓库优先级更高，apt 想把当前 Ubuntu 版 NVIDIA 包升级成 CUDA 仓库版 `580.159.04-1ubuntu1`。但这个版本与 `libnvidia-egl-gbm1` 依赖冲突，导致 apt 升级失败。

### 4. 尝试给 CUDA 仓库降优先级，但失败了，又撤回
```bash
sudo vim /etc/apt/preferences.d/cuda-repository-pin-600
```

### 5. 不行，我就直接尝试
```bash
sudo apt update
sudo apt full-upgrade
sudo ubuntu-drivers install
```

### 6. 然后报错，主动干掉冲突的包
```bash
sudo dpkg --remove --force-depends libnvidia-egl-xcb1:amd64 libnvidia-egl-xcb1:i386
sudo dpkg --remove --force-depends libnvidia-egl-xlib1:amd64 libnvidia-egl-xlib1:i386
```

### 7. 执行修复

```bash
sudo apt --fix-broken install
sudo dpkg --configure -a
sudo apt install -f

# 清理现场
sudo apt autoremove
```

### 8. 重启才能生效

```bash
sudo reboot

# 检查
nvidia-smi
nvcc --version

# 如果安装了cuda版torch
python - <<'PY'
import torch
print(torch.cuda.is_available())
print(torch.version.cuda)
print(torch.cuda.get_device_name(0))
PY
```


## 后半阶段解决过程解析

### 5. 强制更新并安装驱动

`sudo ubuntu-drivers install` 大部分成功了，但最后失败了。

它做到了这些事：

- Removing nvidia-driver-580-open ...
- Removing libnvidia-gl-580 ...
- Installing nvidia-driver-595-open ...
- Installing linux-modules-nvidia-595-open-6.8.0-117-generic ...
- Installing nvidia-utils-595 ...

所以它已经把系统从 580 迁移到 595 了大半。但是它卡在这里：

```text
trying to overwrite ... libnvidia-egl-xcb.so.1.0.5
which is also in package libnvidia-egl-xcb1
```

后来又卡在：

```text
trying to overwrite ... libnvidia-egl-xlib.so.1.0.5
which is also in package libnvidia-egl-xlib1
```

### 6. 手动移除挡路包

```bash
sudo apt remove libnvidia-egl-xcb1 libnvidia-egl-xcb1:i386 libnvidia-egl-xlib1 libnvidia-egl-xlib1:i386
```

以及后来用：

```bash
sudo dpkg --remove --force-depends libnvidia-egl-xlib1:amd64 libnvidia-egl-xlib1:i386
```

这一步的作用是：清掉旧的独立 NVIDIA EGL 包，让 `libnvidia-gl-595` 可以覆盖/接管那些 `.so` 文件。

### 7. 修复问题继续安装

```bash
sudo apt --fix-broken install
```

它的作用是继续完成之前没装完的：

- libnvidia-gl-595
- nvidia-driver-595-open
- linux-modules-nvidia-595-open-generic
- ...

之后你执行：

```bash
sudo dpkg --configure -a
sudo apt install -f
```

显示没事，说明 `dpkg`/`apt` 状态已经干净。

### 8. 重启生效

第四阶段，`sudo reboot` 让真正运行中的内核模块切换到 595。

重启前：

```text
NVML library version: 595.71
```

但内核里可能还挂着旧 580 模块，所以 mismatch。

重启后：

```text
Driver Version: 595.71.05
```

说明 595 驱动完整加载成功。
### 结论

`sudo ubuntu-drivers install`
启动了 595 驱动迁移，但中途失败。

`remove / dpkg --remove` 那几个 libnvidia-egl-* 包
清掉了安装失败的障碍。

`sudo apt --fix-broken install`
完成了 595 驱动安装。

`sudo reboot`
让 595 内核模块真正生效。
