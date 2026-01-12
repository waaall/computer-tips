## HBA330 尝试

### 硬件信息

- 服务器：dell OEMR XL PowerEdge T640
- 宿主机操作系统： vmware ESXi

- iDRAC9 硬盘相关硬件信息：

```text
Dell HBA330 Adp (Embedded)  Integrated Storage Controller 1 Not Applicable  16.17.00.05 Information Not Available   0 MB

Status  Name    State   Slot Number Size    Bus Protocol    Media Type  Hot Spare   Actions Pending Actions
Physical Disk 0:1:4 Non-RAID    4   7452.04 GB  SATA    HDD No      
Physical Disk 0:1:5 Non-RAID    5   7452.04 GB  SATA    HDD No  
```

### 实际操作

按照《Lifecycle Controller 用户指南》

先开机 F10 进入 Lifecycle Controller, 然后进入RAID 配置。

```text
Lifecycle Controller RAID 配置 显示：
    无法启动Launch RAID 配置向导 Launch RAID Configuration Wizard（STOP0502）
    建议采取措施：
    请确保已安装RAID控制器。随后：
    1. 重新引导系统
    2. F10 重新进入Lifecycle Controller
    3. 重试RAID配置
```

### debug: HBA330不是raid卡

这不是raid卡...

- [HBA330 Dell info](https://www.dell.com/support/manuals/zh-cn/dell-sas-hba-12gbps/dell_hba_ug_publication/dell-hba-card-specifications?guid=guid-06cb2c46-07fb-4f69-b558-fa0a275d1d51)
- [dell 论坛](https://www.dell.com/community/en/conversations/poweredge-hddscsiraid/change-of-raid-from-hba330-to-h730p-and-warranty/647f6e59f4ccf8a8debb430f)

## 现有raid卡兼容性

### YZCA-00582-102 卡的详细信息

这是浪潮（Inspur）SAS3108 YZCA-00582-102，相当于 LSI 9361-8i 阵列卡，带 2G 缓存。

#### 核心规格（基于 LSI MegaRAID SAS 9361-8i）

| 参数 | 规格 |
|------|------|
| 芯片 | SAS3108 12 Gb/s dual-core ROC |
| 接口 | x8 lane PCI Express 3.0 compliant |
| 端口 | Eight-port internal 12 Gb |
| 缓存 | 2 GB DDR3（浪潮版本） |
| 连接器 | Two mini-SAS SFF8643 internal connectors |
| 支持设备数 | Up to 128 SAS and/or SATA devices |
| RAID 级别 | RAID levels 0, 1, 5, and 6, RAID spans 10, 50, and 60 |
| 缓存保护 | Optional CacheVault Flash Module (LSICVM02) |

---

### 与 Dell T640 的兼容性

#### 硬件兼容性
- Dell T640 有 PCIe 3.0 x8/x16 插槽，物理上可以安装这张卡
- SAS-RAID Device; VID: 1000; DID: 005D（即 LSI 9361-8i）在 VMware ESXi 7.0/8.0 兼容性列表中
- Dell T640 officially support VMware ESXi 7 and 8

#### 潜在问题

1. 非 Dell 原装卡：YZCA-00582-102 是浪潮的 OEM 版本，不是 Dell 认证的卡。Dell iDRAC 和 Lifecycle Controller 可能无法完全识别或管理它
2. 固件差异：浪潮 OEM 固件可能与原版 LSI 固件有差异，可能需要刷写原版 Broadcom/LSI 固件
3. 线缆适配：需要 SFF-8643 转 SATA 的线缆连接的 SATA 硬盘

---

### 官方文档

#### Broadcom (LSI) 官方文档：

| 文档 | 链接 |
|------|------|
| Product Brief | https://docs.broadcom.com/docs/BC00-0478EN |
| User Guide | https://docs.broadcom.com/doc/pub-005183 |
| Quick Installation Guide | [Thomas-Krenn PDF](https://www.thomas-krenn.com/redx/tools/mb_download.php/mid.y147c845a12a0cc84/QIG_LSI_9361-4i_SAS_9361-8i_RevC_20140721.pdf) |

注意：浪潮 OEM 版本（YZCA-00582-102）没有独立的官方文档，但由于它基于 LSI SAS3108 芯片，可以参考 Broadcom MegaRAID 9361-8i 的文档。

---

## 建议

如果已经有这张卡理论上也能用，就是比较折腾：
1. 需要购买 SFF-8643 转 SATA 线缆
3. 建议刷写最新的 Broadcom/LSI 原版固件
4. 可能需要通过 Ctrl+R 或 WebBIOS 配置 RAID，而不是通过 Dell Lifecycle Controller

如果追求稳定性和官方支持：
- 建议购买 Dell PERC H330/H730/H730P，完全兼容 T640 和 iDRAC 管理
