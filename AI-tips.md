
# claude code & codex


## claude code


### 一、配置 claude code

#### 1. 安装claude code

- [claude code docs](https://code.claude.com/docs/zh-CN/overview)

##### 1.1 linux/mac

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

##### 1.2 windows

```bash
irm https://claude.ai/install.ps1 | iex
```

#### 2. 如果有claude pro 订阅

就在terminal 输入 claude登录就可以，下面步骤不需要。

#### 3. 如果没有订阅，需要添加自己的订阅

以silicon为例：

##### 3.1 添加环境变量

unix(linux/mac) 就 export 放到.zshrc/.bashrc, windows 就加一个环境变量

```text
ANTHROPIC_BASE_URL=https://api.siliconflow.cn/
ANTHROPIC_API_KEY=你的sk-key
ANTHROPIC_MODEL=zai-org/glm-4.6
ANTHROPIC_SMALL_FAST_MODEL=zai-org/glm-4.6
```

##### 3.2 编辑~/.claude.json 添加：

```json
"hasCompletedOnboarding": true,
```

##### 3.3 使用

终端输入claude 或者 vscode 安装插件打开


### 二、Skill & subagents

- [官方的skills](https://github.com/anthropics/skills/tree/main)
- [官方文档](https://code.claude.com/docs/en/skills)

|**维度**|**Skill**|**Sub Agent**|**Plugin**|
|---|---|---|---|
|本质|可复用的“任务知识 + 工作流”|专职的 AI 角色 / 小助手|打包分发的一整套扩展|
|典型内容|说明文档、脚本、模板、示例|system prompt、工具权限、上下文配置|多个 agents、skills、命令、hooks、MCP|
|生命周期|面向“某类任务”，可跨项目、跨产品使用|面向“某个角色”，通常绑定某个项目或用户|面向“团队 / 生态”，作为产品分发|
|调用方式|Claude 自动选用，或显式指定用某 Skill|Claude 自动派工，或你点名某 agent|先安装插件，然后里面的东西在 Claude 中可见并使用|
|适合做什么|规范化、可重复的任务步骤|复杂任务拆工、并行处理、大上下文分工|把一整套最佳实践分享到多项目、多成员|


- “我想让 Claude 记住某个**做事步骤**，以后自动按这个套路做” → 做成一个 Skill。
    
- “我想把任务拆给几个不同的**虚拟角色**协同完成” → 配多个 subagents。
    
- “我想把这套东西**打包给团队**或多个项目用” → 做成一个 Plugin。
    


> 在 Claude Code 里：**Skill = 可复用的小工作流能力**，**Sub Agent = 专职“小同事”**，**Plugin = 打包好的一整套工具箱（里头可以带 skills 和 sub-agents）**。

#### 1. Skill定义

  
官方定义：Skill 是一个文件夹，里面放说明文档、脚本、资源等，Claude 在需要时会动态加载，用来把某类任务做得更稳定、更可控、更“有记忆”。

  
特点大概是：

- 形态：一个目录（通常有 SKILL.md 或类似的说明文件，加上一堆示例、脚本、模板等）。
    
- 作用：教 Claude 按固定套路做一件事，变成“标准化动作”——不用每次聊天都重新讲一遍。
    
- 触发：Claude 会根据当前对话自动决定要不要用某个 Skill，也可以在指令里点名用。
    
- 范围：不仅 Claude Code，用 Claude 网页端、API、Agent SDK 时也能用同一套 Skill。
    

##### **在代码开发里的典型用法**

1. **统一代码规范 + 重构 Skill**
    
    - 说明里写死：你们项目用哪套 ESLint/Prettier 规则、命名风格、分层结构。
    - 可以附一个脚本：自动跑 linter / formatter，把结果喂给 Claude 再做解释和重构建议。
    - 效果：每次说“帮我按团队规范整理这个文件”，Claude 会自动套同一套流程。
        
    
2. **“自动写单元测试” Skill**
    
    - 说明：只针对某语言 + 某测试框架（比如 Jest / Vitest / pytest），给出测试结构模板。
    - 脚本：扫描当前 diff 或函数签名，帮你生成待测函数列表，再请 Claude 按模板写测试。
    - 以后你只要说“用测试生成 Skill 覆盖这次改动”，就走一遍固定流程。
        
    
3. **“提交信息生成 + 变更日志” Skill**
    
    - 说明：规定 commit message 格式（Conventional Commits 等）和 changelog 样式。
    - 脚本：读取 git diff，让 Claude 先结构化归类，再生成符合规范的 commit / changelog。
        
    
4. **“代码评审助手” Skill**
    
    - 固定评审 checklist：安全、性能、可读性、抽象是否过度等。
    - 附指引：优先给出 summary，再给出分点建议，不要直接写“替换版代码”避免 noisy diff。
        
    

这些 Skill 写好之后，不管是在 Claude Code 里还是网页端，只要场景对上，Claude 都能自动调用。

---

#### 2. Sub Agent

  - [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)

官方文档把 subagent 描述成：**预先配置好的专职 AI 助手**，有自己的系统提示词、工具权限、独立上下文窗口，Claude 会在合适的时候把任务分派给它。
  
核心特性：

- 每个 sub agent 有：
    
    - 独立的“人设 / 角色”和解决问题的风格（通过 system prompt 定义）。
    - 自己的上下文窗口，与主对话隔离。
    - 一组特定工具权限（能不能改文件、能不能访问 MCP server 等）。
    
- 存放位置：
    - 项目级：.claude/agents/ → 只对当前 repo 生效。
    - 用户级：~/.claude/agents/ → 所有项目通用。
        
- 使用方式：
    - 自动：Claude 觉得这个任务更适合某个 subagent，会自行“派工”过去。
    - 手动：你可以在命令里点名，比如“让 test-runner 子 agent 修这个挂掉的测试”。


##### **在代码开发里的典型用法**

1. **架构师 agent**
    - 职责：只负责需求分析与架构设计。
    - 权限：只读代码库，不能修改文件。
    - 产出：架构草图、模块划分、接口设计、技术选型建议。
        
2. **实现工程师 agent**
    - 职责：按照架构说明具体写代码。
    - 权限：可以创建/修改源码文件；可以调用某些生成脚手架的命令。
    - 产出：实现代码 + 基本注释。
    
3. **测试工程师 agent**
    - 职责：为目标模块或 PR 写/补测试。
    - 权限：只改 test 目录；可以运行测试命令并解析输出。
    - 产出：测试代码 + 覆盖率建议。
    
4. **文档撰写 agent**
    - 职责：从代码注释、接口定义生成 README / ADR / API 文档。
    - 权限：读代码、docs 目录；可以写 markdown 文档。


再往上，你还可以用一个“协调器 agent”把任务拆给多个 subagents 并行运行（比如对大代码库做文档化或重构），社区里很多人就是这么干的。

目前社区反馈：子 agent 还不能“直接”调用 Skills，只能由主 Claude 先调用相关 Skill 再把结果转给子 agent 使用。

---

#### 3. Plugin

Plugin 是 **一个可安装/分享的扩展包**，里面可以打包很多东西：命令、subagents、Skills、hooks、MCP servers 等，然后你或你的团队可以一键安装复用。


特点：

- 形态：一个插件包（通常是仓库中的 plugins/ 目录），通过 Claude Code 的插件系统加载。
    
- 内容可以包括：
    
    - Slash 命令（例如 /pr-review、/setup-ci）。
        
    - 自定义 agents / subagents。
        
    - 一组 Skills（比如“文档工具包”）。
        
    - Hook：在“git commit 前”、“测试失败后”之类的时机自动触发某些动作。
        
    - MCP servers：连接数据库、CI、外部 API 等。
        
    
- 分发方式：
    
    - 从公共 marketplace 安装（社区已经有很多针对开发、DevOps、数据等场景的插件集）。
        
    - 你们公司自己维护一个私有 marketplace，给全公司发统一的插件套装。
        
    
##### **在代码开发里的典型用法**

1. **“团队标准开发环境”插件**
    
    - 内含：
        
        - 项目常用 subagents（架构师、测试、文档）。
            
        - 一组 Skills（规范 PR、生成 changelog、内部 API 调用方法等）。
            
        - 几个 slash 命令（如 /setup-project 自动拉好依赖、脚手架、基础配置）。
            
        
    - 好处：新同事装一个插件，就拥有和老同事一样的 AI 开发环境。
        
    
2. **Git / CI / issue 系统集成插件**
    
    - MCP tools：连到 GitHub / GitLab、CI/CD（GitHub Actions、CircleCI 等）、Jira/Linear 等。
        
    - Subagents：例如“Release Manager agent”专门负责看 CI 状态、生成 release note、更新 issue 状态。
        
    
3. **安全/质量插件**
    
    - 自带安全扫描工具的 MCP server 和对应 agent，专门看依赖风险、Secrets 泄露、常见漏洞模式。
        
    

---


#### 4. 代码开发工作流用法示例

  
假设一个比较普通的场景：你用 GitHub + CI，做 Web/后端开发，用 VS Code / JetBrains，已经装了 Claude Code 插件。

##### **第一步：先用现成插件解决 80% 的问题**


从 marketplace 里选一些成熟插件，比如：

- PR 审查 / 提交工作流插件
    
- 测试生成 / 重构插件
    
- 项目模板 / 脚手架插件
    


效果：不用自己立刻写 skills 和 agents，就能有一套像“智能コードレビュー+自动 changelog + CI 状态分析”的流水线。

  

##### **第二步：为你自己项目配一套 Sub Agents**

  

在 .claude/agents/ 里定义几个角色，例如：

- architect.md：只读代码 + 负责设计。
    
- implementer.md：负责编码和重构。
    
- tester.md：负责针对 diff 写测试。
    
- doc-writer.md：负责整理文档和 ADR。
    

  

之后你的工作流可以是：

1. 跟主 Claude 说“让 architect agent 设计一下我们要加的这个 feature 的模块划分”。
    
2. 拿到设计后，再说“让 implementer agent 按这个设计实现接口和 service 层”。
    
3. 完成后，“让 tester agent 给新功能写测试并修掉挂掉的 test”。
    

  

对于大改动，还可以让主 Claude 自动把一堆文件分给多个 subagents 并行处理，然后集中汇总结果。

  

##### **第三步：把你们经常做的“套路”沉淀成 Skills**


等用一段时间后，你会发现一些 Chat/指令是高度重复的，比如：

- 每次都要解释一遍“我们项目 code style 是怎样的”。
    
- 每次都要告诉它“写 PR 描述时需要包含：背景、变更内容、风险、回滚策略”。
    
- 每次生成 release note 的结构都一样。
    


这时就很适合抽成 Skills：

- project-style.skill/：记录代码规范 + 用例风格 + 不允许做的事。
    
- pr-template.skill/：编码规范 + PR 描述模板 + 常见检查项。
    
- release-note.skill/：从 tag 间的 commits 中提取变更、分模块、按受众生成不同版本说明。
    

##### **第四步：成熟后打包成内部 Plugin**

  
当你们团队：

- 有几套稳定的 Skills（规范、测试、CI、文档）。
    
- 有几类好用的 subagents（设计、实现、测试、运维）。
    
- 还有几个 integration（GitHub、CI、issue tracker）。
    


就可以：

- 把这些东西打成一个团队内部 Plugin。
    
- 放进自建的 plugin marketplace，团队新人只要执行一行命令就能装上。
    

### MCP

