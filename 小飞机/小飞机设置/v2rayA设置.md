v2rayA是个软件，v2ray或者xray是它支持的内核。

# 安装
### 方法一：通过软件源安装[](https://v2raya.org/docs/prologue/installation/debian/#%E6%96%B9%E6%B3%95%E4%B8%80%E9%80%9A%E8%BF%87%E8%BD%AF%E4%BB%B6%E6%BA%90%E5%AE%89%E8%A3%85)

#### 添加公钥[](https://v2raya.org/docs/prologue/installation/debian/#%E6%B7%BB%E5%8A%A0%E5%85%AC%E9%92%A5)

```bash
wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/keyrings/v2raya.asc
```

#### 添加 V2RayA 软件源[](https://v2raya.org/docs/prologue/installation/debian/#%E6%B7%BB%E5%8A%A0-v2raya-%E8%BD%AF%E4%BB%B6%E6%BA%90)

```bash
echo "deb [signed-by=/etc/apt/keyrings/v2raya.asc] https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
sudo apt update
```

#### 安装 V2RayA[](https://v2raya.org/docs/prologue/installation/debian/#%E5%AE%89%E8%A3%85-v2raya-1)

```bash
sudo apt install v2raya v2ray ## 也可以使用 xray 包
```

### 方法二：手动安装 deb 包[](https://v2raya.org/docs/prologue/installation/debian/#%E6%96%B9%E6%B3%95%E4%BA%8C%E6%89%8B%E5%8A%A8%E5%AE%89%E8%A3%85-deb-%E5%8C%85)

[从 Release 下载 v2rayA 的 deb 包](https://github.com/v2rayA/v2rayA/releases) 后可以使用 Gdebi、QApt 等图形化工具来安装，也可以使用命令行：

```bash
sudo apt install /path/download/installer_debian_xxx_vxxx.deb ### 自行替换 deb 包所在的实际路径
```

V2Ray / Xray 的 deb 包可以在 [APT 软件源中](https://github.com/v2rayA/v2raya-apt/tree/master/pool/main/) 找到。

## 启动 v2rayA / 设置 v2rayA 自动启动[](https://v2raya.org/docs/prologue/installation/debian/#%E5%90%AF%E5%8A%A8-v2raya--%E8%AE%BE%E7%BD%AE-v2raya-%E8%87%AA%E5%8A%A8%E5%90%AF%E5%8A%A8)

> 从 1.5 版开始将不再默认为用户启动 v2rayA 及设置开机自动。

- 启动 v2rayA
    
    ```bash
    sudo systemctl start v2raya.service
    ```
    
- 设置开机自动启动
    
    ```bash
    sudo systemctl enable v2raya.service
    ```

## 错误1 内核安装失败
也就是没有安装好v2ray或者xray。按照上述安装步骤（snap商店的可能会因为网络问题导致错误1或错误2）

## 错误2 geosite.dat not found
geosite.dat是更新的防火墙网址文件。
https://github.com/Loyalsoldier/v2ray-rules-dat
往往是网络问题导致下载不成功，所以需要另一个小飞机或者能上GitHub的网站下载了，放在指定的位置。
有人说放在/usr/local/share/v2ray/；有人说/usr/share/v2ray/；（前两个如果是xray要改一下）还有人说是/etc/v2raya/，我查看了log发现都不对，应该是/root/.local/share/
但是不用管，开始不设置GWF而是Except CN就行，然后更新GWF list。
