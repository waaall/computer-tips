
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
```


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

## 另一次更新导致不适配的问题

### 1. 问题现象

在启动多个 GPU Docker 服务时失败：

```bash
docker compose -f kokoro-tts-compose-zh-gpu.yml up -d
docker compose -f whisper-asr-compose.yml up -d
docker compose -f docker-compose-rtx-pro-6000_embed.yml up -d
docker compose -f docker-compose-rtx-pro-6000_1.yml up -d
````

报错类似：

```text
Error response from daemon: failed to create task for container:
failed to create shim task:
OCI runtime create failed:
runc create failed:
unable to start container process:
error during container init:
failed to fulfil mount request:
open /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.595.71.05:
no such file or directory
```

---

### 2. 根因

这不是模型目录迁移导致的问题，而是 NVIDIA 驱动组件版本混装导致的问题。

当前宿主机实际加载的 NVIDIA 驱动版本是：

```bash
nvidia-smi
```

输出显示：

```text
Driver Version: 595.71.05
CUDA Version: 13.2
```

但是系统里的 `libnvidia-gtk3` 实际文件却是：

```bash
ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so*
```

输出为：

```text
/usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.610.43.02
```

也就是说，系统变成了：

```text
NVIDIA 内核驱动 / nvidia-smi: 595.71.05
nvidia-settings / libxnvctrl0 / libnvidia-gtk3: 610.43.02
```

这种状态会导致 NVIDIA Container Runtime 在启动 GPU 容器时，按当前驱动版本 `595.71.05` 去查找并挂载：

```text
/usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.595.71.05
```

但该文件不存在，因为它已经被升级成了：

```text
/usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.610.43.02
```

最终导致所有使用 GPU 的 Docker 容器启动失败。

---

### 3. 为什么会发生

之前执行过：

```bash
sudo apt update
sudo apt upgrade
```

升级日志中包含：

```text
libxnvctrl0       610.43.02-1ubuntu1
nvidia-settings   610.43.02-1ubuntu1
```

系统中启用了 NVIDIA CUDA repo：

```text
https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64
```

该源中提供了较新的 `610.43.02` 版本，APT 看到版本号更高，就将 `nvidia-settings` 和 `libxnvctrl0` 从 `595.71.05` 升级到了 `610.43.02`。

APT 升级时不会报错，因为从包依赖角度看，这两个包可以安装成功。

但 APT 不会检查：

```text
当前运行中的 NVIDIA 内核驱动版本
是否与 Docker NVIDIA runtime 需要挂载的用户态库完全匹配
```

所以安装阶段成功，运行 GPU 容器时才暴露问题。

---

### 4. 牵引后果

该问题会导致：

```text
1. nvidia-smi 在宿主机上仍然正常
2. Docker GPU 容器无法启动
3. vLLM / Whisper / Kokoro 等依赖 GPU 的服务全部启动失败
4. docker rm -f 删除容器无效
5. 重建容器无效
6. 修改模型目录或 volumes 无法解决
7. 只要 docker run --gpus all 失败，所有 GPU compose 服务都会失败
```

验证命令：

```bash
docker run --rm --gpus all nvidia/cuda:12.9.0-base-ubuntu24.04 nvidia-smi
```

如果这个命令失败，说明问题在 NVIDIA Container Runtime / 宿主机 NVIDIA 用户态库，不在具体业务容器。

---

### 5. 当前异常包

检查命令：

```bash
dpkg -l | grep -E 'nvidia|libnvidia|cuda' | awk '{print $2, $3}' | sort
```

已确认异常包为：

```text
nvidia-settings 610.43.02-1ubuntu1
libxnvctrl0     610.43.02-1ubuntu1
```

可回退版本为：

```bash
apt-cache policy nvidia-settings libxnvctrl0
```

可用目标版本：

```text
595.71.05-1ubuntu1
```

---

### 6. 解决方案：回退 nvidia-settings 和 libxnvctrl0

执行：

```bash
sudo apt install --allow-downgrades \
  nvidia-settings=595.71.05-1ubuntu1 \
  libxnvctrl0=595.71.05-1ubuntu1
```

回退后检查：

```bash
dpkg -l | grep -E 'nvidia-settings|libxnvctrl0'
ls -lah /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so*
```

期望结果：

```text
nvidia-settings 595.71.05-1ubuntu1
libxnvctrl0:amd64 595.71.05-1ubuntu1
/usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.595.71.05
```

---

### 7. 防止下次 apt upgrade 再次升级到 610

回退成功后，锁定这两个包：

```bash
sudo apt-mark hold nvidia-settings libxnvctrl0
```

确认锁定状态：

```bash
apt-mark showhold
```

期望看到：

```text
libxnvctrl0
nvidia-settings
```

---

### 8. 重启 Docker 并验证 NVIDIA runtime

执行：

```bash
sudo systemctl restart docker
```

验证 GPU Docker：

```bash
docker run --rm --gpus all nvidia/cuda:12.9.0-base-ubuntu24.04 nvidia-smi
```

如果能正常显示 GPU 信息，说明 NVIDIA Container Runtime 已恢复。

---

### 9. 重新启动业务容器

```bash
docker compose -f kokoro-tts-compose-zh-gpu.yml up -d --remove-orphans
docker compose -f whisper-asr-compose.yml up -d --remove-orphans
docker compose -f docker-compose-rtx-pro-6000_embed.yml up -d --remove-orphans
docker compose -f docker-compose-rtx-pro-6000_1.yml up -d --remove-orphans
```

---

### 10. 不建议的临时方案

不建议通过软链接绕过：

```bash
sudo ln -s /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.610.43.02 \
  /usr/lib/x86_64-linux-gnu/libnvidia-gtk3.so.595.71.05
```

原因：

```text
这只是骗过文件路径检查
不代表 610 用户态库与 595 内核驱动 ABI 完全兼容
可能引入更隐蔽的问题
```

正确做法是保持 NVIDIA 驱动组件版本一致。

---

### 11. 后续建议

以后执行系统升级前，先查看将要升级的包：

```bash
apt list --upgradable
```

或者模拟升级：

```bash
sudo apt -s upgrade
```

如果看到以下包准备升级，需要特别小心：

```text
nvidia-*
libnvidia-*
cuda-*
libxnvctrl0
nvidia-settings
```

服务器上的 NVIDIA 驱动组件建议不要跟随日常 `apt upgrade` 自动滚动升级。

---
