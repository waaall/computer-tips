---
title: "SS、SSR、V2ray、Trojan、Xray 这五种代理协议与 VPN 对比有何不同？ - 小狗论坛"
source: "https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/"
author:
  - "[[小狗论坛]]"
published: 2022-09-09T18:28:26+08:00, 2022-09-09T18:28:26+08:00
created: 2024-11-21
description: "SSR 是 ShadowsocksR 的缩写，在Shadowsocks的基础上增加了一些数据混淆方式，修复了部分安全问题并提高QoS优先级。"
tags:
  - "clippings"
---
- [什么是SS/SSR(最老)](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E4%BB%80%E4%B9%88%E6%98%AFSSSSR%E6%9C%80%E8%80%81 "什么是SS/SSR(最老)")
- [什么是V2RAY(使用最多)](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E4%BB%80%E4%B9%88%E6%98%AFV2RAY%E4%BD%BF%E7%94%A8%E6%9C%80%E5%A4%9A "什么是V2RAY(使用最多)")
- [什么是Xray(目前最快，最稳的方式)](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E4%BB%80%E4%B9%88%E6%98%AFXray%E7%9B%AE%E5%89%8D%E6%9C%80%E5%BF%AB%EF%BC%8C%E6%9C%80%E7%A8%B3%E7%9A%84%E6%96%B9%E5%BC%8F "什么是Xray(目前最快，最稳的方式)")
- [什么是Trojan、Trojan-Go](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E4%BB%80%E4%B9%88%E6%98%AFTrojan%E3%80%81Trojan-Go "什么是Trojan、Trojan-Go")
- [什么是Clash](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E4%BB%80%E4%B9%88%E6%98%AFClash "什么是Clash")

- [VPN 与 SSR、V2Ray 等的区别及优缺点](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#VPN_%E4%B8%8E_SSR%E3%80%81V2Ray_%E7%AD%89%E7%9A%84%E5%8C%BA%E5%88%AB%E5%8F%8A%E4%BC%98%E7%BC%BA%E7%82%B9 "VPN 与 SSR、V2Ray 等的区别及优缺点")
- [VPN 是什么](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#VPN_%E6%98%AF%E4%BB%80%E4%B9%88 "VPN 是什么")
- [总结](https://www.xiaoglt.top/%E4%BB%A3%E7%90%86%E5%8D%8F%E8%AE%AEss%E3%80%81ssr%E3%80%81v2ray%E3%80%81trojan%E3%80%81v2ray/#%E6%80%BB%E7%BB%93 "总结")

现在最主流的科学上网的代理协议有[clash/xary/SS/SSR/V2Ray/Trojan/Trojan-Go](https://github.com/githubvpn007/proxy#1)，至于其他的上网方式暂时不做讨论

相信很多朋友都会有选择困难症，怎么才能让自己稳定快速的上外网呢？？  
每逢敏感期，都会处于失联状态，这种情况相信大家都不想出现，下面我们就对比下自建节点的常用方式及协议

![](https://www.xiaoglt.top/wp-content/uploads/2022/09/SS-SSR-V2ray-Trojan-Xray-%E5%AF%B9%E6%AF%94-VPN.jpg)

| 项目名称 | 创建时间 | 支持协议 | 速度评分 | 推荐评分 | 推荐理由 |
| --- | --- | --- | --- | --- | --- |
| Shadowsocks | 2015年前 | socks5 | 6 | 2 | 年份有点老，数据传输安全性不高 |
| Shadowsocks-R | 2016年前后 | socks5+混淆协议 | 5 | 1 | 年份有点老，数据传输安全性不高 |
| V2Ray | 2019下半年 | Blackhole   Freedom   HTTP   MTProto   Shadowsocks   Socks   VMess | 1 | 4 | V2ray比较成熟，自用1年半 支持的配套客户端是最多的，隐秘性良好 长期使用没有断过网 |
| Trojan | 2019年底 | 类似V2ray“WS+TLS”模式的精简版 | 2 | 3 | 相比V2ray，速度更快，更轻量级 相比trojan-go 比较老了，因此排名后面 |
| Trojan-Go | 2020年8月 | 类似V2ray“WS+TLS”模式的精简版 | 3 | 5 | 速度方面次于Xray、隐秘更强，客户端比较单一 |
| [Xray](https://github.com/githubvpn007/proxy#!) | 2020年11月 | V2ray的升级版（包含V2ray所有协议） VLESS协议 | 4 | 5 | Xray性能最好、速度更快，隐秘方面也是很不错 更新比较快，支持的客户端也多 |
| Clash | 2020 年末 | 支持SS/V2ray/Trojan协议 | 4 | 5 | 功能全面 性能好 |

### **==什么是SS/SSR(最老)==**

![](https://www.xiaoglt.top/wp-content/uploads/2022/09/SS-300x184-1.png)

SS 是 Shadowsocks 的缩写，中文名为影梭，是一种基于Socks5代理方式的加密传输协议，也可以指实现这个协议的各种开发包。Shadowsocks 仍然有不少国外社区成员在维护更新。后来贡献者Librehat也为Shadowsocks补上了一些数据混淆类特性，甚至增加了类似Tor的可插拔传输层功能。

SSR 是 ShadowsocksR 的缩写，在Shadowsocks的基础上增加了一些数据混淆方式，修复了部分安全问题并提高QoS优先级。

目前而两个用的人已经比较少了。

- 2017 年 10 月，伴随着十九大的开幕，大量线路被封杀，尤其以 SSR 为甚，各大机场与 tg 群一片哀嚎，所幸大会闭幕后不少 IP 被解封，不清楚具体的比例。
- 2018 年 1 月，以及后来的两会期间，执行了更大规模的 IP 封杀，涉及范围更广，基于各种算法的翻墙方法均有涉及，SS 的 Issue 中有人反映刚刚搭好十几分钟即被封杀。

### **==什么是V2RAY(使用最多)==**

![](https://www.xiaoglt.top/wp-content/uploads/2022/09/v2ray-logo.jpg)

V2Ray 是在Shadowsocks 被封杀之后，为了表示抗议而开发的，属于后起之秀，功能更加强大，为抗GFW封锁而生。V2Ray 现在已经是 Project V 项目的核心工具，而 Project V 是一个平台，其中也包括支持 Shadowsocks 协议。由于 V2Ray 早于 Project V 项目，而且名声更大，所以我们习惯称 Project V 项目为 V2Ray，所以我们平时所说的 V2Ray 其实就是 Project V 这个平台，也就是一个工具集。其中，只有 VMess协议是V2Ray社区原创的专属加密通讯协议，被广泛应用于梯子软件。

V2Ray目前支持以下协议（截止到2019年12月）：

- Blackhole：中文名称“黑洞”，是一个出站数据协议，它会阻碍所有数据的出站，配合路由（Routing）一起使用，可以达到禁止访问某些网站的效果。
- Dokodemo-door：中文名称“任意门”，是一个入站数据协议，它可以监听一个本地端口，并把所有进入此端口的数据发送至指定服务器的一个端口，从而达到端口映射的效果。
- Freedom：是一个出站协议，可以用来向任意网络发送（正常的） TCP 或 UDP 数据。
- HTTP：超文本传输协议，是传统的代理协议
- MTProto：Telegram 的开发团队开发的专用协议，是一个 Telegram 专用的代理协议。在 V2Ray 中可使用一组入站出站代理来完成 Telegram 数据的代理任务。目前只支持转发到 Telegram 的 IPv4 地址。
- Shadowsocks：最早被个人开发的科学上网梯子协议，但 V2Ray 目前不支持 ShadowsocksR。
- Socks：标准 Socks 协议实现，兼容 Socks 4、Socks 4a 和 Socks 5，也是传统的代理协议。
- 是V2Ray 专用的加密传输协议，它分为入站和出站两部分，通常作为 V2Ray 客户端和服务器之间的桥梁。因为增加了混淆和加密，据说比 Shadowsocks 更安全。现在的机场支持 V2Ray，一般是指支持 VMess 协议。VMess 依赖于系统时间，请确保使用 V2Ray 的系统 UTC 时间误差在 90 秒之内，时区无关。在 Linux 系统中可以安装ntp服务来自动同步系统时间。

截止到2019年12月，V2Ray 可选的传输层配置有：TCP、mKCP、WebSocket、HTTP/2、DomainSocket、QUIC。其中，mKCP、QUIC和TCP用于优化网络质量；WebSocket用于伪装；HTTP/2和DomainSocket用于传输以及TLS加密。

V2Ray不仅可以在传输层配置 TLS 使 HTTP 和 SOCKS 变成 HTTPS 和 SOCKS over TLS 协议，也可以使MTProto、Shadowsocks 和 VMess 通过传输层配置TLS加密伪装成 TLS 流量。所以，VMess 配置 TLS 加密是最常见的做法，但没人会对 Shadowsocks 使用 TLS 加密，因为这完全没意义。

### **==什么是Xray(目前最快，最稳的方式)==**

Xray与V2Ray完全类同，Xray 是 Project X 项目的核心模块。因为Xray和XTLS黑科技的作者rprx曾经是V2fly社区的重要成员，所以Xray直接Fork全部V2Ray的功能，然后进行性能优化，并增加了新功能，使Xray在功能上成为了V2Ray的超集，且完全兼容V2Ray。

简而言之，Xray是V2Ray的项目分支，Xray是V2Ray的超集，就跟Trojan-Go和Trojan-GFW的关系类似，而且Xray性能更好、速度更快，更新迭代也更频繁。由于自V2ray-core 4.33.0 版本起，删除了XTLS黑科技，但仍然支持VLESS，所以是否原生支持XTLS是Xray和V2Ray最大的区别之一。

### **==什么是Trojan、Trojan-Go==**

![](https://www.xiaoglt.top/wp-content/uploads/2022/09/Trojan-logo-150x150-1.png)

Trojan，原来多是指特洛伊木马，是一种计算机病毒程序。但是，我们今天所说的Trojan是一种新的科学上网技术，全称为Trojan-GFW，是目前最成功的科学上网伪装技术之一。你可以认为Trojan是V2Ray的“WS+TLS”模式的精简版，速度比V2Ray更快，伪装比V2Ray更逼真，更难以被GFW识别。

Trojan工作原理：Trojan通过监听443端口，模仿互联网上最常见的 HTTPS 协议，把合法的Trojan代理数据伪装成正常的 HTTPS 通信，并真正地完整完成的TLS 握手，以诱骗GFW认为它就是 HTTPS，从而不被识别。Trojan处理来自外界的 HTTPS 请求，如果是合法的，那么为该请求提供服务，否则将该流量转交给Caddy、Nginx等 web 服务器，由 Caddy、Nginx 等为其提供网页访问服务。基于整个交互过程，这样能让你的VPS更像一个正常的web服务器，因为Trojan的所有行为均与 Caddy、Nginx等 web 服务器一致，并没有引入额外特征，从而达到难以识别的效果。

### **==什么是Clash==**

Clash是一个跨平台、支持SS/V2ray/Trojan协议、基于规则的网络代理软件，功能强大、界面美观、支持订阅，尤其适合机场和付费服务使用。Clash功能全加颜值好看，使得Clash深受喜爱，有一大批死忠粉。

### VPN 是什么

[VPN](https://topvpn.wiki/what-is-vpn) 即指“虚拟专用网络”，提供了使用公共网络时建立受保护网络连接的机会。VPN 可以加密您的互联网流量，伪装您的在线身份。这让第三方更难追踪您的在线活动并窃取数据。加密是实时进行的。查看我们详细的 VPN 介绍。

- 原理不同：VPN 强调对公网传输过程中数据的加解密，SS/SSR/V2Ray/Xray/Trojan 都是专注于在客户端和服务器端加解密，公网传输数据过程中特征没有 VPN 明显。
- 目的不同：VPN是在公网中建的虚拟专用算法，是强大的加解密算法，用于传输性安全，数据自走性而生，被广泛应用于VPN 是走在公网中自建的虚拟专用通道，使用强大的加解密算法，为数据传输安全性、私密性而生，被广泛应用于企业、高校、科研部门等远程数据传输的领域；SS/SSR/V2Ray/Xray/Trojan/Trojan-Go 是为了数据能够安全通过 GFW 而生，更强调的是对数据的混淆和伪装，加解密只是为了更好的隐藏数据特征而顺利绕过 GFW 的检测，数据内容加密可以有效绕过关键词的检测。

**该如何选择翻墙方式？**请参考[获取科学上网服务端信息](https://www.xiaoglt.top/?p=512)

## **总结**

各项目都有它对应支持的客户端。 有的客户端同时支持多种协议(比如 v2rayN)。Shadowsocks和ShadowsocksR 协议是一种协议 同时它的官方客户端的名字也刚好叫 Shadowsocks和ShadowsocksR ！

各种协议支持的客户端请看如下：

[V2Ray客户端全集](https://www.xiaoglt.top/?p=73)

[Xray客户端](https://www.xiaoglt.top/?p=62#xray-client)

[trojan客户端下载](https://www.xiaoglt.top/?p=134)

[trojan-go客户端下载](https://www.xiaoglt.top/?p=163)

[Shadowsocks/SS客户端](https://www.xiaoglt.top/?p=143)

[ShadowsocksR/SSR客户端](https://www.xiaoglt.top/?p=153)

这里列出了几乎所有的代理客户端， 大家没有特别的需求的话只需要看 **V2Ray**客户端全集就可以了。

windows直接用**==V2rayN==**

Android直接用**==V2rayNG==**

Mac直接使用**==Qv2ray==**

linux直接使用**==Qv2ray==**

IOS比较特别，具体请看[获取ios科学上网客户端](https://www.xiaoglt.top/?p=138)。