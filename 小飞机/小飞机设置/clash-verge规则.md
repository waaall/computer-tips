
[clash verge](https://github.com/clash-verge-rev/clash-verge-rev) 有默认的规则，但优先遵循机场订阅的规则，所以这跟机场有关。

# clash verge 规则说明
## 官方
### [自定义路由规则](https://www.clashverge.dev/guide/rules.html#_1)
不知道规则类型? -> [Clash Mihomo路由规则文档](https://wiki.metacubex.one/config/rules)。
不会写JavaScript? -> [菜鸟教程](https://www.runoob.com/js/js-tutorial.html)。
想要更多资料? -> [Script配置](https://www.clashverge.dev/guide/script.html)
### [途径](https://www.clashverge.dev/guide/rules.html#_2)
- 右键配置卡片编辑规则
- 使用配置页的 `全局扩展脚本` (建议)

### [右键配置卡片编辑(最为简单)](https://www.clashverge.dev/guide/rules.html#_3)

> 1. 选择匹配类型和分流策略组
> 2. 仅添加前置规则
> 3. (虽然添加后置也可以，但规则模式是 `从上至下` 匹配的，因此不建议)

### [通过全局扩展脚本](https://www.clashverge.dev/guide/rules.html#_4)

**原理**：ClashVegerRev通过暴露出可编程的API，即 `config` 对象与 `profileName` 对象，可通过 `main` 函数传入config参数来编辑配置对象。

```js
/**
 * 配置中的规则"config.rules"是一个数组，通过新旧数组合并来添加
 * @param prependRule 添加的数组
 */
const prependRule = [
  // 将百度分流到直连
  "DOMAIN-SUFFIX,baidu.com,DIRECT",
  // 将本网站分流到自动选择(前提是你的代理组当中有"自动选择")
  "DOMAIN-SUFFIX,clashverge.dev,自动选择",
];
function main(config) {
  // 把旧规则合并到新规则后面(也可以用其它合并数组的办法)
  let oldrules = config["rules"];
  config["rules"] = prependRule.concat(oldrules);
  return config;
}
```

还可以参考这个issue中讨论的做法-> [issues/1437#issuecomment-2395050752](https://github.com/clash-verge-rev/clash-verge-rev/issues/1437#issuecomment-2395050752)

### [为不同配置文件启用不同的脚本](https://www.clashverge.dev/guide/rules.html#_5)

```js
function main(config, profileName) {
    // 设订阅A
  if(profileName === "A") {
    // 对config修改
    // ......
  }
  // 不是“A”则返回未修改的配置
  return config;
}
```

## “第三方”
[本文](https://kerrynotes.com/clash-rules-guide/)介绍下 Clash 的规则以及如何配置规则。

前几天有朋友留言，觉得某个机场的规则很好，但很可惜它又跑路了（是的，说的就是 Duangcloud）。刚好今天说下自己要怎么写规则。

Clash 的规则是一套用于流量分流的配置规则，通过这些规则，Clash 能够对网络请求进行分类，并根据规则决定如何处理这些请求。简单说，这些规则决定了哪些网站或IP是使用代理访问，哪些是直接访问。例如，你开着代理软件的时候，访问bilibili就希望是直接访问，不要经过代理，不然你的流量一下就跑没了。

于是，通过规则，你就可以实现：

-   **流量分流**：区分哪些流量走代理，哪些直连。
-   **广告屏蔽**：通过特定规则屏蔽广告域名或 IP。
-   **优化流媒体和游戏**：指定流媒体（如Netflix）、游戏（如Steam）走特定代理。
Clash 规则的基本结构，每条规则包含三部分：

```bash
规则类型, 匹配目标, 路由策略
```

-   **规则类型**：指定如何匹配流量（如域名、IP、地理位置等）。
-   **匹配目标**：定义要匹配的内容（如具体的域名、IP 地址等）。
-   **路由策略**：决定匹配后的处理方式（如 `DIRECT`、`PROXY` 或 `REJECT`）。

看明白了吧，规则类型和匹配目标就是条件，当你要访问的某个域名符合你制定的条件，那么就按照你给它规定的路由策略来决定流量走不走代理。

### 常见的规则类型

| 规则类型 | 说明 | 示例 |
| --- | --- | --- |
| `DOMAIN` | 精确匹配某个域名。 | `DOMAIN, www.google.com, PROXY` |
| `DOMAIN-SUFFIX` | 匹配域名的后缀。 | `DOMAIN-SUFFIX, google.com, PROXY` |
| `DOMAIN-KEYWORD` | 匹配包含指定关键字的域名。 | `DOMAIN-KEYWORD, google, PROXY` |
| `IP-CIDR` | 匹配某个 IP 范围。 | `IP-CIDR, 8.8.8.0/24, PROXY` |
| `GEOIP` | 根据 IP 所属地理区域匹配。 | `GEOIP, CN, DIRECT` |
| `MATCH` | 匹配所有剩余流量，通常用于兜底规则。 | `MATCH, PROXY` |

### 匹配目标

匹配目标可以是域名（如 `www.google.com`）、IP 地址（如 `8.8.8.8`）、关键字（如 `ads`）或地理区域（如 `CN` 表示中国）。

### 路由策略

-   **DIRECT**：直连，不使用代理。
-   **PROXY**：使用代理。
-   **REJECT**：拦截流量，丢弃请求。

不过一般机场的路由策略会采用一些自定义的分组，下面会说。

### 规则的匹配顺序

Clash 从规则列表的顶部开始逐行匹配，直到找到第一个满足条件的规则为止。因此：

6.  高优先级规则放在顶部。
7.  常见规则放在中间。
8.  `MATCH`（兜底规则）放在底部，确保所有流量都有处理。

例如：

```json
rules:
  - DOMAIN-SUFFIX, google.com, PROXY   # 访问 *.google.com 走代理
  - GEOIP, CN, DIRECT                 # 所有中国流量直连
  - MATCH, PROXY                      # 其余流量走代理
```

这几条规则的意思是：

9.  如果访问 `www.google.com`，匹配第一条规则，走代理。
10.  如果访问中国大陆的 IP，匹配第二条规则，直连。
11.  如果没有匹配到，默认使用最后的 `MATCH` 规则，走代理。

这里用的是 `DOMAIN-SUFFIX` 的类型，会匹配所有域名后缀是 `google.com` 的网络请求。例如 `play.google.com, ads.google.com, www.google.com` 等都会匹配上。但是 `google.co.uk` 就不会匹配上。

## 规则的实际应用场景举例

#### **1\. 屏蔽广告**

```json
rules:
  - DOMAIN-SUFFIX, adservice.google.com, REJECT
  - DOMAIN-KEYWORD, ads, REJECT
```

#### **2\. 分流国内外流量**

```json
rules:
  - GEOIP, CN, DIRECT
  - MATCH, PROXY
```

#### **3\. 优化流媒体访问**

```json
rules:
  - DOMAIN-SUFFIX, netflix.com, PROXY
  - DOMAIN-SUFFIX, youtube.com, PROXY
  - GEOIP, CN, DIRECT
  - MATCH, PROXY
```

#### **4\. 局域网直连**

```json
rules:
  - IP-CIDR, 192.168.1.0/24, DIRECT
```

## 机场的配置文件举例

拿前面提到的机场的配置文件来看一下：

```json
rules:
    - 'DOMAIN,api.duangss.cloud,DIRECT'
    - 'DOMAIN-SUFFIX,acl4ssr,🎯 全球直连'
    - 'DOMAIN-SUFFIX,localhost,🎯 全球直连'
    - 'IP-CIDR,10.0.0.0/8,🎯 全球直连,no-resolve'
    - 'IP-CIDR,100.64.0.0/10,🎯 全球直连,no-resolve'
    - 'DOMAIN,router.asus.com,🎯 全球直连'
    - 'DOMAIN-SUFFIX,hiwifi.com,🎯 全球直连'
    - 'DOMAIN-KEYWORD,adservice,🛑 全球拦截'
    - 'DOMAIN-KEYWORD,adsh,🛑 全球拦截'
    - 'DOMAIN-KEYWORD,adsmogo,🛑 全球拦截'
    - 'DOMAIN-SUFFIX,a.youdao.com,🍃 应用净化'
    - 'DOMAIN-SUFFIX,adgeo.corp.163.com,🍃 应用净化'
    - 'DOMAIN-SUFFIX,analytics.126.net,🍃 应用净化'
    - 'DOMAIN-KEYWORD,1drv,Ⓜ️ 微软服务'
    - 'DOMAIN-KEYWORD,microsoft,Ⓜ️ 微软服务'
    - 'DOMAIN,apple.comscoreresearch.com,🍎 苹果服务'
    - 'DOMAIN-SUFFIX,aaplimg.com,🍎 苹果服务'
    - 'DOMAIN-SUFFIX,edgedatg.com,🌍 国外媒体'
    - 'DOMAIN-SUFFIX,go.com,🌍 国外媒体'
    - 'DOMAIN-KEYWORD,abematv.akamaized.net,🌍 国外媒体'
    - 'DOMAIN-SUFFIX,1password.com,🚀 节点选择'
    - 'GEOIP,CN,🎯 全球直连'
    - 'MATCH,🐟 漏网之鱼'
```

结合上面的内容，这时候你就能明白这些是什么意思了。但是呢，你会发现为什么他后面路由策略的地方写的是 `🎯 全球直连、 🌍 国外媒体` 这样的，而不是 `DIRECT、PROXY`。

这是因为这里用到了 `proxy-groups` 的功能。在 Clash 的配置中，`proxy-groups` 是用于管理代理节点选择的部分，它定义了一个或多个代理组，每个组包含一系列代理节点，用户可以通过这些代理组轻松切换节点或设置自动选择策略。你可以根据自己的需求，把节点分组为手动选择、自动选择、特定用途（如流媒体、聊天工具）等类型。

![clash proxy groups](https://kerrynotes.com/wp-content/uploads/2024/12/clash-proxy-groups.webp "Clash（Mihomo） 的规则怎么写？ - 2")

从上图可以看出，分组的格式一般是这样的：

```json
- { name: '🚀 节点选择', type: select, proxies: [...] }
```

-   **`name`**: 组的名称，比如 `🚀 节点选择`。这是用户在客户端界面上看到的名称。
-   **`type`**: 组的类型，有以下几种：
    -   **`select`**: 手动选择。用户可以在客户端中手动选择具体节点。
    -   **`url-test`**: 自动测试所有节点的延迟，并选择最快的节点。
    -   **`fallback`**: 备用机制。主要节点不可用时切换到可用的节点。
    -   **`load-balance`**: 负载均衡，在多个节点间分配流量。
-   **`proxies`**: 该组内包含的具体代理节点的列表。

## 总结

Clash 的规则配置乍一看好像挺复杂，密密麻麻一堆字。但你掌握了基础的语法和逻辑之后，还是很容易理解的。一般情况下，也不需要配置这些规则，因为机场都给你配置好了。默认就开规则模式，如果遇到访问不了的站，再开全局。但总有用得上的时候，谁知道你买的机场写的规则全不全面呢？

延伸阅读1：知道了基础语法，看下 [Clash Verge Rev 里在哪里设置规则](https://kerrynotes.com/clash-verge-rev-customize-rules/)。  
延伸阅读2：感兴趣的可以看看 [Mihomo 官方的规则文档](https://wiki.metacubex.one/config/rules/#rule-set)。
# clash verge 规则设置

[本文](https://kerrynotes.com/clash-verge-rev-customize-rules/)介绍在 Clash Verge Rev 中如何添加自定义规则以及使用 Merge功能配置全局规则。

打开 Clash Verge Rev，右键单击机场的配置文件，选择 `编辑文件` 或 `编辑规则`。
-   编辑文件是之前讲过的直接在配置文件上编写规则。不推荐，因为更新机场订阅的时候会被覆盖。
-   编辑规则是 Clash Verge rev 为了方便大家添加规则做的功能，如果添加的规则不多，用这个就更方便一些。而且它不会被覆盖。

![clash verge rev edit rules](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-edit-rules.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 2")

目录

12.  [编辑配置文件（不推荐）](https://kerrynotes.com/clash-verge-rev-customize-rules/#toc1)
13.  [编辑规则界面（推荐）](https://kerrynotes.com/clash-verge-rev-customize-rules/#toc2)
14.  [全局扩展配置（Merge）](https://kerrynotes.com/clash-verge-rev-customize-rules/#toc3)
15.  [全局扩展脚本](https://kerrynotes.com/clash-verge-rev-customize-rules/#toc4)

## 编辑配置文件（不推荐）
直接编辑文件，需要了解 Clash 规则的语法。规则的结构都是：`规则类型, 匹配目标, 路由策略`。如果不了解的话，先看看 [Clash 规则的基本语法](https://kerrynotes.com/clash-rules-guide/)。

注意，这里编辑的话，更新的时候会被覆盖的。
![clash verge rev edit profile](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-edit-profile.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 3")

## 编辑规则界面（推荐）
Clash Verge Rev 给了一个手动添加规则的窗口，这样修改规则更加方便。而且添加的规则不会被覆盖。

选择规则类型 > 填入规则内容 > 选择代理策略。
这里要注意的是有两个选项：`前置规则`和`后置规则`。Clash 的规则是按照从上到下的顺序匹配的。
-   `前置规则`会放在规则的最前面，可以优先匹配。如果你有明确的某个广告域名或者是网站需要代理，则选择添加前置规则。
-   `后置规则`就放在规则的最后面，用来兜底。当前面所有的规则都没有匹配到时，才会执行。

![clash verge rev edit rules ui](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-edit-rules-ui.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 4")

编辑规则是针对某一个机场来的，但如果你有很多个机场。那使用 Merge 功能会更省事。这是一个全局的配置，对所有机场都生效。之前的 Clash Verge 也是有这个功能的。

1\. 点击 `订阅` > 右键单击 `全局扩展配置` > 选择 `编辑文件`。

![clash verge rev merge settings](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-merge-settings.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 5")

2\. 然后在 `prepend rules` 里添加规则并保存。

![clash verge rev merge settings](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-merge-settings-example.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 6")

3\. 点击右上方的 🔥图标，激活当前配置，让 Merge 里的规则生效。

![clash verge activate merge profile](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-activate-merge-profile.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 7")

4\. 然后点击旁边的按钮查看当前运行的订阅配置。如果成功的话，你会看到 merge 的规则。

![clash verge rev current profile](https://kerrynotes.com/wp-content/uploads/2024/12/clash-verge-rev-current-profile.webp "Clash Verge Rev 如何自定义规则，Merge 规则设置 - 8")

## 全局扩展脚本
全局扩展脚本是基于 Clash Meta 核心（Mihomo 核心）提供的功能，它是通过 JS 来撰写规则。相比全局扩展配置，它更加灵活和强大。

脚本的优势很多且强大：

-   **动态性强**：脚本会根据代理节点动态生成区域组，适应节点变化。
-   **规则管理方便**：通过远程加载规则集，降低维护成本。
-   **功能全面**：支持延迟测试、负载均衡、倍率筛选等高级功能。

但也不是没有缺点：
-   **学习成本高**：对于我这样的非技术用户不太友好。
-   **维护成本高**：虽然可以白嫖大佬们的脚本，但是并不一定适合你。但是改的话，又耗时耗力。
-   **过度设计**：我如果只需要简单的分流规则配置，使用扩展脚本可能有点多余，静态配置效率更高。

网上有很多大佬们分享的脚本，感兴趣的可以去尝试一下。我自己用了之后就不是很舒服。比如：工作中会用到广告工具，自己还会点击一些广告，结果他们的规则直接给我屏蔽了。如果我去改，又会很麻烦。