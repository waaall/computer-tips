
## Nvidia GPU 型号
首先，Nvidia分成几大系列（Tesla、Quadro、GeForce、Jetson）。

	1. GeForce定位是消费级；
	2. Quadro定位是专业图形卡；
	3. Tesla定位是专业计算卡，现被称为Data Center系列；
	4. Jetson定位是嵌入式计算卡。

每一代都调整微架构（可以理解成CPU的单核架构的更新，一般是两年更新一代）。微架构都有对应的名字和代号（都是用科学家的名字起名），具体见下表。
- 对于GeForce：5、6、7...10、20、30、40、50开头都对应每个版本号。
- 对于Tesla/Data Center的命名：开头字母代表的是架构代号，具体见下表；最后00代表高端、0代表终端，纯非零数字代表低端；开头非零数字代表细分定位？


### cuda-version对照表

| **Compute Capability (硬件)** | **支持的最低 CUDA Toolkit 版本** | Tesla/Data Center 型号 |
| --------------------------- | ------------------------- | -------------------- |
| 1.x (Tesla)                 | CUDA 1.0 – CUDA 6.5       |                      |
| 2.x (Fermi)                 | CUDA 3.0 – CUDA 8.0       |                      |
| 3.x (Kepler)                | CUDA 5.0 – CUDA 10.2      | K10                  |
| 5.x (Maxwell)               | CUDA 6.5 – CUDA 11.0      | M10                  |
| 6.x (Pascal)                | CUDA 8.0 – CUDA 11.x      | P100                 |
| 7.0 (Volta)                 | CUDA 9.0 – CUDA 11.x      | V100                 |
| 7.5 (Turing)                | CUDA 10.0 – CUDA 11.x     | T4                   |
| 8.0 (Ampere)                | CUDA 11.0 – CUDA 12.x     | A100                 |
| 8.6 (Ampere)                | CUDA 11.1 – CUDA 12.x     | A40                  |
| 8.9 (Ada Lovelace)          | CUDA 12.0+                | L4                   |
| 9.0 (Hopper)                | CUDA 12.0+                | H200                 |
| 10.0 (Blackwell)            | CUDA 12.4+                | B100                 |


### [型号-版本对照表](https://developer.nvidia.com/cuda-gpus)
下表没有包含Jetson系列（嵌入式平台），[官网](https://developer.nvidia.com/cuda-gpus)有。

| 计算能力（版本） | 微架构                                             | GPU                               | GeForce 系列                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Quadro NVS 系列                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Tesla / Data Center 系列                                        | Tegra 系列, Jetson 系列, DRIVE 系列                                                                           |
| :------- | :---------------------------------------------- | :-------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------ |
| 1.0      | Tesla                                           | G80                               | GeForce 8800 Ultra, GeForce 8800 GTX, GeForce 8800 GTS(G80)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Quadro FX 5600, Quadro FX 4600, Quadro Plex 2100 S4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Tesla C870, Tesla D870, Tesla S870                            |                                                                                                         |
| 1.1      | G92, G94, G96, G98, G84, G86                    |                                   | GeForce GTS 250, GeForce 9800 GX2, GeForce 9800 GTX, GeForce 9800 GT, GeForce 8800 GTS(G92), GeForce 8800 GT, GeForce 9600 GT, GeForce 9500 GT, GeForce 9400 GT, GeForce 8600 GTS, GeForce 8600 GT, GeForce 8500 GT, GeForce G110M, GeForce 9300M GS, GeForce 9200M GS, GeForce 9100M G, GeForce 8400M GT, GeForce G105M                                                                                                                                                                                                                                                                                                                                                                                                                                    | Quadro FX 4700 X2, Quadro FX 3700, Quadro FX 1800, Quadro FX 1700, Quadro FX 580, Quadro FX 570, Quadro FX 470, Quadro FX 380, Quadro FX 370, Quadro FX 370 Low Profile, Quadro NVS 450, Quadro NVS 420, Quadro NVS 290, Quadro NVS 295, Quadro Plex 2100 D4, Quadro FX 3800M, Quadro FX 3700M, Quadro FX 3600M, Quadro FX 2800M, Quadro FX 2700M, Quadro FX 1700M, Quadro FX 1600M, Quadro FX 770M, Quadro FX 570M, Quadro FX 370M, Quadro FX 360M, Quadro NVS 320M, Quadro NVS 160M, Quadro NVS 150M, Quadro NVS 140M, Quadro NVS 135M, Quadro NVS 130M, Quadro NVS 450, Quadro NVS 420[18] |                                                               |                                                                                                         |
| 1.2      | GT218, GT216, GT215                             |                                   | GeForce GT 340*, GeForce GT 330*, GeForce GT 320*, GeForce 315*, GeForce 310*, GeForce GT 240, GeForce GT 220, GeForce 210, GeForce GTS 360M, GeForce GTS 350M, GeForce GT 335M, GeForce GT 330M, GeForce GT 325M, GeForce GT 240M, GeForce G210M, GeForce 310M, GeForce 305M                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Quadro FX 380 Low Profile, Quadro FX 1800M, Quadro FX 880M, Quadro FX 380M, Nvidia NVS 300, NVS 5100M, NVS 3100M, NVS 2100M, ION                                                                                                                                                                                                                                                                                                                                                                                                                                                              |                                                               |                                                                                                         |
| 1.3      | GT200, GT200b                                   |                                   | GeForce GTX 295, GTX 285, GTX 280, GeForce GTX 275, GeForce GTX 260                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Quadro FX 5800, Quadro FX 4800, Quadro FX 4800 for Mac, Quadro FX 3800, Quadro CX, Quadro Plex 2200 D2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Tesla C1060, Tesla S1070, Tesla M1060                         |                                                                                                         |
| 2.0      | Fermi                                           | GF100, GF110                      | GeForce GTX 590, GeForce GTX 580, GeForce GTX 570, GeForce GTX 480, GeForce GTX 470, GeForce GTX 465, GeForce GTX 480M                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Quadro 6000, Quadro 5000, Quadro 4000, Quadro 4000 for Mac, Quadro Plex 7000, Quadro 5010M, Quadro 5000M                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | Tesla C2075, Tesla C2050/C2070, Tesla M2050/M2070/M2075/M2090 |                                                                                                         |
| 2.1      | GF104, GF106, GF108, GF114, GF116, GF117, GF119 |                                   | GeForce GTX 560 Ti, GeForce GTX 550 Ti, GeForce GTX 460, GeForce GTS 450, GeForce GTS 450*, GeForce GT 640 (GDDR3), GeForce GT 630, GeForce GT 620, GeForce GT 610, GeForce GT 520, GeForce GT 440, GeForce GT 440*, GeForce GT 430, GeForce GT 430*, GeForce GT 420*, GeForce GTX 675M, GeForce GTX 670M, GeForce GT 635M, GeForce GT 630M, GeForce GT 625M, GeForce GT 720M, GeForce GT 620M, GeForce 710M, GeForce 610M, GeForce 820M, GeForce GTX 580M, GeForce GTX 570M, GeForce GTX 560M, GeForce GT 555M, GeForce GT 550M, GeForce GT 540M, GeForce GT 525M, GeForce GT 520MX, GeForce GT 520M, GeForce GTX 485M, GeForce GTX 470M, GeForce GTX 460M, GeForce GT 445M, GeForce GT 435M, GeForce GT 420M, GeForce GT 415M, GeForce 710M, GeForce 410M | Quadro 2000, Quadro 2000D, Quadro 600, Quadro 4000M, Quadro 3000M, Quadro 2000M, Quadro 1000M, NVS 310, NVS 315, NVS 5400M, NVS 5200M, NVS 4200M                                                                                                                                                                                                                                                                                                                                                                                                                                              |                                                               |                                                                                                         |
| 3.0      | Kepler                                          | GK104, GK106, GK107               | GeForce GTX 770, GeForce GTX 760, GeForce GT 740, GeForce GTX 690, GeForce GTX 680, GeForce GTX 670, GeForce GTX 660 Ti, GeForce GTX 660, GeForce GTX 650 Ti BOOST, GeForce GTX 650 Ti, GeForce GTX 650, GeForce GTX 880M, GeForce GTX 780M, GeForce GTX 770M, GeForce GTX 765M, GeForce GTX 760M, GeForce GTX 680MX, GeForce GTX 680M, GeForce GTX 675MX, GeForce GTX 670MX, GeForce GTX 660M, GeForce GT 750M, GeForce GT 650M, GeForce GT 745M, GeForce GT 645M, GeForce GT 740M, GeForce GT 730M, GeForce GT 640M, GeForce GT 640M LE, GeForce GT 735M, GeForce GT 730M                                                                                                                                                                                 | Quadro K5000, Quadro K4200, Quadro K4000, Quadro K2000, Quadro K2000D, Quadro K600, Quadro K420, Quadro K500M, Quadro K510M, Quadro K610M, Quadro K1000M, Quadro K2000M, Quadro K1100M, Quadro K2100M, Quadro K3000M, Quadro K3100M, Quadro K4000M, Quadro K5000M, Quadro K4100M, Quadro K5100M, NVS 510, Quadro 410                                                                                                                                                                                                                                                                          | Tesla K10, GRID K340, GRID K520                               |                                                                                                         |
| 3.2      |                                                 | GK20A                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                               | Tegra K1, Jetson TK1                                                                                    |
| 3.5      |                                                 | GK110, GK208                      | GeForce GTX Titan Z, GeForce GTX Titan Black, GeForce GTX Titan, GeForce GTX 780 Ti, GeForce GTX 780, GeForce GT 640 (GDDR5), GeForce GT 630 v2, GeForce GT 730, GeForce GT 720, GeForce GT 710, GeForce GT 740M (64-bit, DDR3), GeForce GT 920M                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Quadro K6000, Quadro K5200                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Tesla K40, Tesla K20x, Tesla K20                              |                                                                                                         |
| 3.7      |                                                 | GK210                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | Tesla K80                                                     |                                                                                                         |
| 5.0      | Maxwell                                         | GM107, GM108                      | GeForce GTX 750 Ti, GeForce GTX 750, GeForce GTX 960M, GeForce GTX 950M, GeForce 940M, GeForce 930M, GeForce GTX 860M, GeForce GTX 850M, GeForce 845M, GeForce 840M, GeForce 830M, GeForce GTX 870M                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | Quadro K1200, Quadro K2200, Quadro K620, Quadro M2000M, Quadro M1000M, Quadro M600M, Quadro K620M, NVS 810                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Tesla M10                                                     |                                                                                                         |
| 5.2      |                                                 | GM200, GM204, GM206               | GeForce GTX Titan X, GeForce GTX 980 Ti, GeForce GTX 980, GeForce GTX 970, GeForce GTX 960, GeForce GTX 950, GeForce GTX 750 SE, GeForce GTX 980M, GeForce GTX 970M, GeForce GTX 965M                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Quadro M6000 24GB, Quadro M6000, Quadro M5000, Quadro M4000, Quadro M2000, Quadro M5500, Quadro M5000M, Quadro M4000M, Quadro M3000M                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Tesla M4, Tesla M40, Tesla M6, Tesla M60                      |                                                                                                         |
| 5.3      |                                                 | GM20B                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                               | Tegra X1, Jetson TX1, Jetson Nano, DRIVE CX, DRIVE PX                                                   |
| 6.0      | Pascal                                          | GP100                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Quadro GP100                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Tesla P100                                                    |                                                                                                         |
| 6.1      |                                                 | GP102, GP104, GP106, GP107, GP108 | Nvidia TITAN Xp, Titan X, GeForce GTX 1080 Ti, GTX 1080, GTX 1070 Ti, GTX 1070, GTX 1060, GTX 1050 Ti, GTX 1050, GT 1030, MX350, MX330, MX250, MX230, MX150                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Quadro P6000, Quadro P5000, Quadro P4000, Quadro P2200, Quadro P2000, Quadro P1000, Quadro P400, Quadro P500, Quadro P520, Quadro P600, Quadro P5000(Mobile), Quadro P4000(Mobile), Quadro P3000(Mobile)                                                                                                                                                                                                                                                                                                                                                                                      | Tesla P40, Tesla P6, Tesla P4                                 |                                                                                                         |
| 6.2      |                                                 | GP10B[19]                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                               | Tegra X2, Jetson TX2, DRIVE PX 2                                                                        |
| 7.0      | Volta                                           | GV100                             | NVIDIA TITAN V                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | Quadro GV100                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | Tesla V100, Tesla V100S                                       |                                                                                                         |
| 7.2      |                                                 | GV10B[20]                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                               | Tegra Xavier, Jetson Xavier NX, Jetson AGX Xavier, DRIVE AGX Xavier, DRIVE AGX Pegasus                  |
| 7.5      | Turing                                          | TU102, TU104, TU106, TU116, TU117 | NVIDIA TITAN RTX, GeForce RTX 2080 Ti, RTX 2080 Super, RTX 2080, RTX 2070 Super, RTX 2070, RTX 2060 Super, RTX 2060, GeForce GTX 1660 Ti, GTX 1660 Super, GTX 1660, GTX 1650 Super, GTX 1650, GeForce MX450                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Quadro RTX 8000, Quadro RTX 6000, Quadro RTX 5000, Quadro RTX 4000, Quadro T2000, Quadro T1000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Tesla T4                                                      |                                                                                                         |
| 8.0      | Ampere                                          | GA100                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | A100, A30                                                     |                                                                                                         |
| 8.6      |                                                 | GA102, GA103, GA104, GA106, GA107 | GeForce RTX 3090 Ti, RTX 3090, RTX 3080 Ti, RTX 3080 12GB, RTX 3080, RTX 3070 Ti, RTX 3070, RTX 3060 Ti, RTX 3060, RTX 3050, RTX 3050 Ti (mobile), RTX 3050 (mobile), RTX 2050 (mobile), MX570                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | RTX A6000, RTX A5500, RTX A5000, RTX A4500, RTX A4000, RTX A2000, RTX A5000 (mobile), RTX A4000 (mobile), RTX A3000 (mobile), RTX A2000 (mobile)                                                                                                                                                                                                                                                                                                                                                                                                                                              | A40, A16, A10, A2                                             |                                                                                                         |
| 8.7      |                                                 | GA10B                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |                                                               | Jetson Orin Nano, Jetson Orin NX, Jetson AGX Orin, DRIVE AGX Orin, DRIVE AGX Pegasus OA, Clara Holoscan |
| 8.9      | Ada Lovelace                                    | AD102, AD103, AD104, AD106, AD107 | GeForce RTX 4090, RTX 4080 Super, RTX 4080, 4070*, RTX 4060*, RTX 4050                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | RTX 6000 Ada, RTX 5880 Ada, RTX 5000 Ada, RTX 4500 Ada, RTX 4000 Ada, RTX 4000 SFF,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | L40S, L40, L20, L4, L2                                        |                                                                                                         |
| 9.0      | Hopper                                          | GH100                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | H200, H100                                                    |                                                                                                         |
| 10.0     | Blackwell                                       | GB100                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | B200, B100                                                    |                                                                                                         |
| 12.0     |                                                 | GB202, GB203, GB205, GB206, GB207 | GeForce RTX 5090, RTX 5080, RTX 5070 Ti, RTX 5070                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | B40                                                           |                                                                                                         |

## Nvidia功耗墙
当然可以。对于无界面的 Ubuntu 服务器，使用命令行工具是标准做法。为 NVIDIA RTX 4090 设置永久性功耗墙是解决噪音和散热问题的绝佳方案。

### 功耗限制设置为多少合适？

对于 NVIDIA GeForce RTX 4090，这是一个性能猛兽，但其默认的 450W（某些型号可达 600W）功耗也是噪音和热量的根源。

· 默认值：标准 TDP (Total Design Power) 为 450W。
· 建议值：通过大量测试，公认的“甜点”值在 320W 到 380W 之间。
  · 320W-350W：在这个范围内，性能损失通常极小（约 3-5%），但温度和噪音会显著下降。这是平衡效率与性能的最佳起点，非常适合需要长时间稳定运行的训练任务。

如果电源不够，可以限制到270W，有峰值85%的性能。

### 功耗限制方法(新)
2025年，网上的方法全部过时！就下载最新的`nvidia app`，然后UI界面就有限制功率，点一下就永久生效。


## Nvidia Onnxruntime 


### 将ONNX模型推理迁移到NVIDIA

将ONNX模型推理从CPU迁移到NVIDIA 4090显卡上来提升性能。4090作为消费级旗舰显卡，凭借其大量的CUDA核心和Tensor Core，在模型推理上能带来显著的加速效果。

下面我为你梳理一下操作步骤，并对性能提升幅度做一个大致预估。

#### 迁移到GPU的步骤

确保开发环境、模型和代码都做好适配，是成功迁移和发挥GPU性能的基础。以下是主要步骤：

1. 环境配置与检查
   · 安装GPU版ONNX Runtime：你需要安装onnxruntime-gpu包，而不是默认的CPU版本。

```bash
pip install onnxruntime-gpu
```
   · 确保CUDA/cuDNN兼容性：这是最关键的一步。onnxruntime-gpu版本必须与系统安装的CUDA及cuDNN版本严格匹配。4090显卡通常需要CUDA 12.x版本。你可以通过ONNX Runtime官方文档查询推荐的版本组合。
   · 验证GPU可用性：安装后，运行以下Python代码确认ONNX Runtime能否识别到GPU：
  
```python
import onnxruntime as ort
print(ort.get_available_providers()) # 输出应包含 'CUDAExecutionProvider'
```
   
2. 代码修改 在你的推理代码中，需要显式指定使用CUDA执行提供者（Execution Provider）来创建推理会话（InferenceSession）：

```python
import onnxruntime as ort
# 创建会话时指定CUDAProvider
sess_options = ort.SessionOptions()
# 如果需要，可以在这里设置一些会话选项，例如图优化级别、线程数等
session = ort.InferenceSession('your_model.onnx', sess_options=sess_options, providers=['CUDAExecutionProvider'])
```

   如果你的代码中之前没有指定providers，默认会使用CPU。修改后，ONNX Runtime会自动将计算图上的操作分配到GPU上执行。
   
3. 数据传输优化
   · 为了减少数据在CPU和GPU之间传输的开销，最好将输入数据直接创建在GPU上，或者使用IoBinding功能来显式绑定输入/输出设备。
   · 对于图像处理，常见的做法是使用OpenCV等库在CPU上读取和预处理图像，然后将处理后的NumPy数组通过.to('cuda')（如果使用PyTorch Tensor）或直接在创建OrtValue时指定设备，来转移到GPU。ONNX Runtime的IoBinding可以更精细地控制数据传输。

4. 性能调优（可选但重要）
   · 卷积算法搜索策略：对于卷积神经网络，cuDNN提供了不同的卷积算法搜索策略（cudnn_conv_algo_search）。默认的`EXHAUSTIVE`（穷举搜索）会在首次遇到新输入尺寸时测试所有算法以选择最快的，但这可能导致首次推理延迟极高。对于需要低延迟或输入尺寸变化的场景，可考虑设置为HEURISTIC（启发式）或DEFAULT（默认算法），以牺牲微量吞吐换取稳定且低延迟。这个设置通常通过session_options配置。
   · 线程设置：你可以通过SessionOptions调整线程数（intra_op_num_threads和inter_op_num_threads），但在GPU推理中，这个的影响通常不如在CPU上显著。
   · 精度：4090显卡对FP16（半精度浮点数）有很好的支持。如果模型精度允许，将模型转换为FP16精度可以大幅提升吞吐量并减少显存占用。

#### 性能提升预估

将推理从CPU迁移到NVIDIA 4090显卡上，性能提升通常会非常显著，但具体的加速比受多种因素影响。

影响因素 说明
模型结构 包含大量可并行计算（如卷积、矩阵乘法）的模型（如CNN、Transformer）在GPU上加速效果最明显。串行操作多的模型提升可能有限。
输入数据&批量大小 增大批量大小（Batch Size） 能更好地利用GPU的并行计算能力，从而提高吞吐量。但批量过大会增加延迟，需根据场景权衡。
CPU/GPU硬件基础 相比的CPU型号和性能。如果你原来的CPU性能较弱，那么切换到4090的加速比会显得更高。
预处理/后处理 如果你的流水线中图像预处理/后处理（数据解码、Resize、结果解析等）也在CPU上耗时很长，那么仅优化模型推理部分可能无法带来整体耗时的大幅下降。这部分CPU操作通常无法受益于GPU。

· 粗略估计：对于典型的视觉模型（如ResNet, YOLO），从CPU迁移到4090后，模型推理部分本身的速度提升（即加速比）达到10倍以上是很常见的，有些场景甚至可能更高。
· 整体考量：你需要关注端到端（End-to-End）的延迟，即从收到请求到返回结果的总时间。如果预处理和后处理耗时占比较大，即便模型推理降为0，总耗时下降也不会那么极端。你的300ms耗时中，需要区分开模型推理本身和前后处理的耗时，才能更准确地预估GPU能带来的整体提升。

请注意：理论推测不如实际测试。最可靠的方法是在4090上实际运行你的模型，并使用相同的输入数据与CPU版本进行对比基准测试。你可以参考上文“代码修改”部分的代码，并利用time模块进行精确计时。

#### 总结

总的来说，将ONNX模型推理从CPU迁移到NVIDIA 4090显卡：

1. 操作上：主要是安装兼容的onnxruntime-gpu库、确保CUDA环境正确，并在代码中指定使用CUDAExecutionProvider。
2. 性能上：模型推理部分预计会有数量级级的提升（10倍+），但整体端到端延迟的优化幅度还取决于你的数据处理流水线。

# Nvidia GPU和CPU的关系进化

**nvcc 是运行在主机（CPU）上的编译器驱动；GPU 不能完全脱离 CPU／主机独立工作，但现代技术正把大量数据搬运、通信和常见控制路径从 CPU 上下移（例如 [GPUDirect RDMA](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf)/GDS、CUDA Graphs、Dynamic Parallelism、DPU/SmartNIC 等），因此“对 CPU 依赖”在若干工作流上显著降低，但不会被完全消除。** 

## 1)  nvcc 在"CPU" & 编译流程

- nvcc 本质上是一个**主机端的编译器驱动**（compiler driver）：它分析源文件，把 host（CPU）部分交给本机 C/C++ 编译器（gcc/clang/MSVC）去编译，把 device（GPU）内核编译成 PTX 或 cubin（架构指令）并与 host 代码链接或封装成 module。最终产物里包含主机可执行代码和为 GPU 准备的设备二进制/中间码。nvcc 本身在主机运行并依赖主机的 toolchain。

- [运行时加载过程](https://www.lrde.epita.fr/~carlinet/cours/GPGPU/j2-part3-compilation-runtime.slides.pdf)：程序执行时，CUDA 驱动/运行时负责把 device 模块加载到 GPU 上；如果模块是 PTX，driver 可能在加载时或首次运行时将 PTX JIT 编译成具体 GPU 的 SASS（二进制指令）。所以设备上的执行载体（SM）运行的是由 driver/firmware 准备好的二进制指令，而这些准备工作由主机（或驱动）触发。


## 2) GPU 还不能独立于 CPU

- **外围 / 系统资源管理**：文件系统、网络栈、进程/线程管理、用户态驱动、设备固件升级、权限、安全策略、系统启动等都是由主机 CPU（或至少一个支撑的控制域，如 DPU）来管理，GPU 不具备完整的 I/O 子系统与操作系统运行环境。即便 GPU 内部有管理微核（firmware/微控制器），那类微核负责初始化、固件、安全与电源管理，不相当于[通用 OS](https://docs.kernel.org/gpu/nova/core/falcon.html)。
    
- **控制与调度入口在主机**：典型 [CUDA 编程](https://docs.nvidia.com/cuda/cuda-c-programming-guide/?utm_source=chatgpt.com)模型里（host → device），是主机发起内核调用、管理内存分配、负责错误处理与同步。GPU 本身缺乏一个普适的、对外管理外设与文件系统的用户态环境来完全替代主机（或者说这不是它的设计目标）。因此“完全脱离主机”在通用计算/系统层面上不可行。


## 3) 逐步独立于CPU的工作


### A. CUDA Dynamic Parallelism

- **作用**：GPU 内核在运行时可以直接从设备端发起子内核、创建 streams/events、做部分设备端内存管理——不必回到主机再发起新 kernel，从而实现嵌套并行或更动态的 device 内部工作流。
    
- **利**：减少往返主机的控制开销，适合需要在设备端根据数据决定下一步计算的场景（递归/自适应细化等）。
    
- **弊**：有额外的硬件/调度开销（性能并不总是更好），只有部分 GPU 架构/驱动上表现良好；编程与调试复杂度高。
    
- **参考**：官方 [Tech Brief](https://developer.download.nvidia.cn/assets/cuda/files/CUDADownloads/TechBrief_Dynamic_Parallelism_in_CUDA.pdf)（Dynamic Parallelism）。
  

### B. CUDA Graphs

- **作用**：把一系列 kernel、memcpy、stream 操作“捕获”为一张图，之后可以一次性以非常低的 CPU 开销提交/重放（或instantiate）这段工作流。
    
- **利**：对于训练循环、推理 pipeline、重复性很强的算子序列，能显著降低每次迭代的 CPU 启动/调度开销、提高吞吐。
    
- **弊**：图的捕获/调优需要设计；对动态控制流（高度数据依赖）不总是方便。
    
- **参考**：[CUDA Graphs 官方文档与博客入门](https://developer.nvidia.com/blog/cuda-graphs/)。


### C. GPUDirect RDMA

- **作用**：允许网卡（或第三方设备）直接把数据 DMA 到 GPU 内存或从 GPU 内存读出，**无需 CPU 在主机内存中做“bounce buffer”拷贝**。
    
- **适用**：分布式训练/推理中跨节点 GPU-GPU 通信、低延迟服务场景。
    
- **注意**：需要硬件/驱动/交换机/OS 协同（不是“软件开关”就能开）。
    
- **参考**：[GPUDirect RDMA](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf) 文档。
    

  

### D. GPU Direct Storage

- **作用**：GPU 可通过支持的栈直接从 NVMe（或远端存储）把数据 DMA 到显存，省去主机内存拷贝与 CPU 占用，适合大型数据集直读训练/推理。
    
- **利**：减轻主机负载、提高 I/O 带宽与一致性延迟。
    
- **条件**：需要支持的文件系统/驱动与 PCIe 拓扑（不是所有主板/PCIe switch 都支持 P2P），还要使用 cuFile / GDS API。
    
- **参考**：[GPUDirect Storage](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf) 文档与配置指南。

### E. NVLink / NVSwitch

- **作用**：在节点内部（或 NVLink Multi-node）实现 GPU->GPU 的极高带宽和低延迟互联，许多通信可以在 GPU 之间直接完成而无需 CPU 干预（或者仅作极少控制）。
    
- **利**：提高多GPU 数据并行/模型并行扩展效率。
    
- **参考**：[NVLink / NVSwitch 官方说明](https://www.nvidia.com/en-us/data-center/nvlink/)与技术概述。

### F. NVIDIA MPS

NVIDIA Multi-Process Service
- **作用**：将多个进程的 CUDA 调用合并到一个服务进程执行，减少上下文切换与驱动开销，从而降低 CPU 与 GPU 交互的延迟与开销。适合多进程推理或 MPI 工作负载。

- **参考**：[MPS 官方文档](https://docs.nvidia.com/deploy/mps/index.html)。
  

### G. DPU / SmartNIC / NVIDIA BlueField

- **作用**：DPU（Data Processing Unit）具备独立 CPU 核（通常是 Arm）、网络/存储硬件加速与可编程栈，可以在 DPU 上跑容器、做 RDMA 路径管理、存储协议处理、甚至在 DPU 上运行某些服务，从而把网络与存储控制对主机 CPU 的依赖降低。结合 GPUDirect，数据平面可实现“CPU 很少参与”的流水线。
    
- **参考**：[BlueField DPU](https://www.nvidia.com/en-us/networking/products/data-processing-unit/) 产品与文档。

### H. 设备端内存 API: cudaMallocAsync等

- **现状**：CUDA 近年加入了异步/流序列内存分配（cudaMallocAsync、memory pools）与设备端的 malloc（设备 heap）等功能，能在一定程度上把内存管理更靠近设备但**分配请求的控制仍由 host/运行时或 device heap 策略管控**（并非完全自由）。这些 [API](https://docs.nvidia.com/cuda/cuda-runtime-api/group__CUDART__DEVICE.html?utm_source=chatgpt.com) 可以减少同步开销，但要注意并发控制与碎片化。

## 4) 工程实践: 降低 CPU 瓶颈

1. **先量化瓶颈**：用 nvprof / nsight / DCGM + Prometheus 量测 kernel 启动延迟、PCIe 带宽、CPU 占用、内存拷贝时间。不要盲目换技术。
    
2. **如果 kernel-launch 频繁且重复性强 → 使用 CUDA Graphs**（捕获后重放，极大降低每次迭代的 CPU 调度成本）。
    
3. **多进程共享 GPU 且有上下文切换开销 → 尝试 MPS 或 vGPU、MIG（如果卡支持）**。
    
4. **跨节点大模型训练 → 配置 [GPUDirect RDMA](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf) + NCCL 优化拓扑**（避免 host copies）。务必做 RDMA 测试、交换机配置（PFC/MTU）与驱动兼容性测试。
    
5. **若 I/O 成为瓶颈 → 评价并启用 GPUDirect Storage（GDS）与合适的 PCIe/交换拓扑**，或采用 DPU 将 I/O 平面下沉。
    
6. **考虑 persistent kernels / kernel fusion**：把多次小 kernel 合并成一个大 kernel，能显著减少调度开销（但开发复杂度上升）。
    
7. **硬件拓扑与 BIOS/PCIe 配置**：并非所有主板/PCIe switch 支持 peer-to-peer DMA；在设计服务器时，拓扑（CPU ↔ PCIe 槽、桥接、交换）决定能否实现“零拷贝”路径。务必在采购/上板前确认交换机/PEX 支持。
    

## 5) 局限、风险与误区

- **并非“开了某个 API 就自动零 CPU”**：[GPUDirect RDMA](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf)/GDS、CDP 等都依赖硬件、驱动、交换机与文件系统支持；缺一不可。某些 PCIe Gen5 switches 不支持 P2P，仍需 CPU bounce。
    
- **调试与可观测性变差**：把更多逻辑下沉会增加调试难度（device-side bugs 更难查）；工具链支持也相对较弱。
    
- **安全与隔离**：例如 [GPUDirect](https://docs.nvidia.com/cuda/pdf/GPUDirect_RDMA.pdf) 要求驱动/固件与 OS 的合适配置，错误配置有安全/稳定风险。
    
- **并非所有算法适合 [Dynamic Parallelism**](https://developer.download.nvidia.cn/assets/cuda/files/CUDADownloads/TechBrief_Dynamic_Parallelism_in_CUDA.pdf)：CDP 可用但在多数训练/推理场景下，比起优化 host-side orchestration + kernel fusion，其收益并不总是显著。


## 6) 未来趋势

- **DPU/SmartNIC（[BlueField](https://www.nvidia.com/en-us/networking/products/data-processing-unit/) 等）推动把网络/存储控制放到一个独立可编程域**，进而减小主机 CPU 在数据平面中的参与。
    
- **更好的 PCIe / NVLink 拓扑与厂商级支持（企业级 switch / [NVSwitch](https://www.nvidia.com/en-us/data-center/nvlink/)）**，让 GPU 之间以及 GPU↔存储的 P2P 更可靠、更快，从架构上减少主机转发。
    
- **软件层（[CUDA Graphs](https://developer.nvidia.com/blog/cuda-graphs/)、GDS、NCCL 优化）持续完善**，把常见工作流的 CPU 成本不断压低。



# cuda programming

- [reddit learn cuda](https://www.reddit.com/r/MachineLearning/comments/w52iev/d_what_are_some_good_resources_to_learn_cuda/)
- [cuda-c-programming-guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/)


# AI servers

## 总述

太好了 — 这是一个很有深度也很实用的主题。我把回答分成**路线图（必须知道的技术点） + 实战清单（选型/采购/部署/运维） + 学习资源（权威文档、书籍、网站） + 推荐的学习/实践顺序与下一步行动**。我尽量把每一部分都写得可直接落地，且在关键论断后给出权威文档引用，方便你马上去读原始资料。


### 1) 总体架构
  

构建 AI 加速计算服务器集群，核心要素是：**加速器（GPU/其它）、主机（CPU/内存/PCIe）、高速互联（NVLink/NVSwitch(是NVLink的升级版)/InfiniBand/RoCE）、高速/可扩展存储（NVMe/Lustre/Ceph/对象存储）、集群和作业调度层（[Kubernetes](https://github.com/kubernetes/kubernetes)/Slurm/MPICH/Ray/Kubeflow）、驱动/运行时/库（CUDA/cuDNN/NCCL/Triton等）、监控/管理（DCGM/Prometheus/Grafana）、机房/电力/散热/安全与运维自动化**。这是构造现代 AI POD（例如[ NVIDIA DGX SuperPOD](https://docs.nvidia.com/dgx-superpod/reference-architecture-scalable-infrastructure-b200/latest/_downloads/4b3d3302fa4fc6854b595ccff50b9932/RA11334001-DSPB200-ReferenceArch.pdf?utm_source=chatgpt.com)）的基本图谱（参考厂商参考架构）。

### 2) 关键技术

1. **加速器与互联拓扑**：GPU之间的带宽/延迟决定分布式训练效率（NVLink, [NVSwitch](https://images.nvidia.com/content/pdf/nvswitch-technical-overview.pdf?utm_source=chatgpt.com) 在节点内部高速互联，跨节点靠 InfiniBand/RoCE + GPUDirect/NCCL）。了解 NVSwitch / NVLink 的带宽设计与拓扑对性能调优非常关键。
    
2. **RDMA / RoCE / InfiniBand / GPUDirect**：跨节点通信需绕过主机内核/CPU开销以降低延迟，使得多GPU训练能扩展。RDMA 与 [RoCE](https://network.nvidia.com/pdf/whitepapers/roce_in_the_data_center.pdf) 的配置（MTU、QoS、PFC）直接影响训练稳定性与延迟。
    
3. **分布式通信库（NCCL / Horovod / MPI）**：NCCL 做集合通信优化（all-reduce 等），理解其拓扑感知（ring/trees）和调优参数是多卡多节点性能关键。
    
4. **集群调度与资源分配**：Slurm（HPC场景）与 [Kubernetes](https://github.com/kubernetes/kubernetes)（云原生/弹性场景）是主流选择；需理解 GPU 亲和性、拓扑染色、隔离（CPU/GPU/NIC）等调度策略. [Gaining more control over node scheduling with the Topology/Block Plugin](https://slurm.schedmd.com/SLUG24/NVIDIA-Craig_Tierney.pdf)。
    
5. **存储与数据流**：训练对 I/O 的吞吐和并发读写要求高：本地 NVMe 用于高速缓存，集中式并行文件系统（Lustre）或分布式对象/文件系统（Ceph）做共享训练数据与检查点。做 I/O 性能分析（profile）很重要。
    
6. **容器化与驱动/运行时**：理解 NVIDIA 驱动、CUDA、cuDNN、NCCL、以及容器运行时（nvidia-container-toolkit / device-plugin / containerd）如何配合，避免版本冲突。
    
7. **可观测性与管理**：GPU 级 telemetry --- NVIDIA DCGM ([NVIDIA Data Center GPU Manager](https://docs.nvidia.com/datacenter/dcgm/latest/index.html)) 、Prometheus/Grafana、日志、告警、节点/作业级指标，是长期运营的命脉。
    
8. **推理服务栈**：线上推理要与训练分开优化（批处理、并发模型、Triton/ONNXRuntime/TensorRT），了解 [Triton](https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/index.html) 以及推理延迟/吞吐调优实践。
  

### 3) 实战清单


#### **设计与选型（Research & Procure）**

- 明确目标工作负载：训练（大模型？多节点？混合精度？）还是大量在线推理？
    
- 加速器选型：NVIDIA H100/A100/GB200，或 AMD MI/Intel/Graphcore/Cerebras/Habana ——每种有不同软件生态（CUDA vs ROCm vs Habana Synapse）。
    
- 节点规格：CPU 核心数（避免成为瓶颈）、内存容量、PCIe 通道数、主板支持 NVLink / SR-IOV 是否需要。
    
- 网络：至少 100Gb/s Mellanox InfiniBand / 200/400GbE RoCE；考虑是否需要 NVLink across nodes（如 NVL）。理解 rack-level power/cooling 需求。参考大型参考架构（例如 DGX SuperPOD）。
  

#### **数据中心/机房准备**

- 电力（PDU/供电冗余）、冷却（冷通道/热通道）、机柜功率预算（单机/机柜可达几十千瓦）。参考厂商机柜布局图。
  

#### **网络与存储**

- 配置 RDMA（RoCE/InfiniBand）并测试（iperf、ib_write_bw、osu_latency）。留意 MTU / flow control / PFC。
    
- 存储：本地 NVMe 做缓存 / checkpoint；并行文件系统（Lustre）或 Ceph 提供共享数据湖；评估带宽和 IOPS。可以参考学术/白皮书对 Ceph vs Lustre 的对比研究。
  

#### **软件栈与调度**

- OS：选择兼容驱动的 Linux（通常是 Ubuntu / RHEL）。设定内核参数（hugepages、NUMA、C-states/CPU governor 等）。
    
- GPU 驱动 + CUDA + cuDNN + NCCL（版本匹配）— 使用厂商文档做 matrix 检查。
    
- 集群管理：Slurm（HPC 作业队列）或 [Kubernetes](https://github.com/kubernetes/kubernetes) + device-plugin（云原生部署）。实现 GPU 拓扑感知调度（避免将同一 job 分散到带高互联延迟的节点）。
    
- 容器与镜像：基于 NGC 镜像或自建镜像，确保驱动、CUDA、Python 库版本一致。
    
- CI / infra：Ansible/Puppet/Terraform + PXE 引导 + 镜像管理（metal-as-a-service）。

  

#### **性能验证与基准**

- 使用 [MLPerf](https://mlcommons.org/benchmarks/training/)（training & inference）作为业界基准评估系统设计优劣，阅读最新提交与结果报告。
    
- 做端到端 profile：NCCL 性能测试、网络延迟、I/O 带宽、GPU 利用率（dcgm-exporter + nvidia-smi）。

  

#### **运行与运维**

- 监控：Prometheus + Grafana + [DCGM](https://docs.nvidia.com/datacenter/dcgm/latest/index.html) exporter；告警与容量规划。
    
- 安全：镜像签名、容器隔离、网络 ACL、机柜物理安全。
    
- 备份与恢复：模型 checkpoint、元数据备份、灾备流程。
    
- 成本与费用模型：电费、折旧、维护人力。参考同类公有云价格做比对（对成本敏感的决策点：是否上云/混合云）。

  

### 4) 参考文档

- **大型参考架构 / 生产部署**：NVIDIA DGX SuperPOD reference architecture（DGX B200 / H100 文档） — 对机柜布局、电力、网络、软件栈等给出详尽参考。
    
- **GPU 互联 / NVSwitch / NVLink**：NVSwitch technical overview — 理解节点内高带宽互联。
    
- **RDMA / RoCE 白皮书**：Mellanox / NVIDIA RoCE in the Data Center — 理解 RDMA 的价值与配置要点。
    
- **调度与多节点管理**：Slurm 官方文档与实践演讲（例如 SchedMD 与 NVIDIA 的整合实践）。
    
- **基准测试**：MLCommons / MLPerf（Training 和 Inference）— 评估平台与比对的重要工具。
  

#### 参考书籍

- **《Programming Massively Parallel Processors: A Hands-on Approach》 — David Kirk & Wen-mei Hwu**（GPU 并行计算与 CUDA 基础与实践）
    
- **《CUDA By Example / CUDA Programming》 — Jason Sanders & Edward Kandrot**（入门 CUDA）
    
- **《Computer Architecture: A Quantitative Approach》 — Hennessy & Patterson**（机架/CPU/内存/互联的架构原理，对设计服务器硬件很有帮助）
    
- **《Designing Data-Intensive Applications》 — Martin Kleppmann**（分布式存储、消息队列与系统设计实践，对数据流与存储架构帮助极大）
    
- **HPC / 分布式系统经典资料和厂商白皮**（NVIDIA、Mellanox 文档，厂商参考架构常更新且实战性强）。
  

### 5) 实际案例

第0–2周（奠基）**：阅读 DGX SuperPOD 参考架构（理解机柜/电力/冷却/网络）；安装小型单节点 GPU（本地）。

**第3–6周（底层）**：学 CUDA/并行原理（Kirk&Hwu / CUDA By Example），做简单 kernel，理解内存层次与带宽。

**第7–10周（网络与分布式）**：读 RoCE/InfiniBand + GPUDirect 白皮书，搭建两节点 InfiniBand 测试环境并跑 NCCL benchmarks。

**第11–14周（调度与部署）**：部署 Slurm 小集群或 [Kubernetes](https://github.com/kubernetes/kubernetes) + device-plugin，运行分布式 PyTorch/Horovod 示例，学习作业调优。

**第15–20周（存储/监控/性能）**：试用 Ceph/Lustre 或本地 NVMe+NFS，集成 DCGM、Prometheus、Grafana 做监控并进行 MLPerf 小规模测试。


- **NVIDIA DGX SuperPOD / DGX B200 参考架构**（直接拿来当采购/电力/冷却/网络 blueprint）。
    
- **MLPerf 提交报告与系统描述**（看别人如何布置节点/网络/存储以达到成绩）。

  

### 6) 风险、坑与建议

- **版本地狱**：驱动/CUDA/cuDNN/NCCL/容器版本必须严格匹配；建议用厂商官方镜像或内部受控镜像仓库。
    
- **网络配置常是性能隐患**：MTU、PFC、RoCE QoS、交换机设置很容易被忽视。做小规模 RDMA 测试再扩容。
    
- **I/O 成为瓶颈**：大模型训练常不是算力瓶颈而是 I/O；设计 NVMe 缓存策略与并行文件系统。
    
- **成本/运维**：一套高密度机柜的电费和冷却成本很快超过硬件折旧，建议做 TCO 评估（云 vs on-prem 对比）。


