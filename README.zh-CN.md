# Claude Code Companion Starter

[English](./README.md)

把你的 CLI 编程助手改造成稳定、有工作区感知、适合长期协作的个人伙伴。

这是一组为 **Claude Code**、**Codex CLI** 和 **Gemini CLI** 设计的提示词模板。与其把它们当成无状态的一次性问答工具，这些提示词能让它们：

- 跨会话保持稳定的协作风格
- 在文件系统上初始化结构化项目记忆
- 避免不必要地重写已有内容
- 通过轻量对话逐步 bootstrap 用户偏好

## 这个仓库解决什么问题

很多"个人助理型提示词"写得很完整，但在实际 CLI 使用中经常会遇到：

- 对全局配置控制能力估计过高
- 要求每次都读取过多文件
- 过度流程化，阻塞正常任务
- 对已有内容的保护不够

这些提示词就是围绕这些真实约束做的收敛版，经过三种不同 CLI 工具的实际测试。

## 支持的 CLI 工具

| CLI 工具 | 初始化提示词 | 全局配置路径 | 配置文件 |
| --- | --- | --- | --- |
| **Claude Code** | [`step1-init.md`](./step1-init.md) | `~/.claude/` | `CLAUDE.md`（支持 `@` 导入） |
| **Codex CLI** | [`step1-init-codex.md`](./step1-init-codex.md) | `~/.codex/` | `AGENTS.md`（单文件合并） |
| **Gemini CLI** | [`step1-init-gemini.md`](./step1-init-gemini.md) | `~/.gemini/` | `GEMINI.md`（单文件合并） |

三种工具共享同一套 `.assistant/` 项目级记忆结构。在同一个工作区内切换工具是无缝的。

## 核心理念：文件系统即外部记忆

这个项目借鉴了 [OpenClaw](https://docs.openclaw.ai/concepts/memory) 的一个关键思路：把文件系统当作持久化的工作记忆。

CLI 编程助手天生擅长执行指令，但不擅长跨会话保存协作上下文。这个项目通过结构化记忆层来弥补这个差距：

| 层级 | 用途 |
| --- | --- |
| `~/.claude/` / `~/.codex/` / `~/.gemini/` | 全局行为规则，适用于所有项目 |
| `.assistant/` | 项目级记忆：用户画像、风格、工作流、项目决策 |

### 它改变了什么

- 偏好和规则不再只散落在聊天记录里
- 项目决策可以跨会话保留
- 临时信息和长期偏好可以分层存放
- 重新进入工作区更有连续性，而非从零开始

### 具体例子

1. **表达风格不再每次重讲。** "先给结论、再讲风险、保持简洁" 进入 `STYLE.md`，不用反复 prompt。
2. **项目决策不会轻易重置。** "当前阶段不拆微服务" 进入 `memory/projects/architecture.md`，不用每次重新讨论。
3. **工作推进方式可以个性化。** "先检查代码、改前简述、改后说明验证结果" 沉淀到 `WORKFLOW.md`。
4. **临时信息不会污染长期记忆。** "这个接口文档还没确认" 进入 `memory/daily/YYYY-MM-DD.md`。

## 仓库内容

### 一键初始化提示词（推荐）

这些提示词会一次性完成全局规则 + 项目级记忆的初始化：

- [`step1-init.md`](./step1-init.md) — **Claude Code** 初始化提示词
- [`step1-init-codex.md`](./step1-init-codex.md) — **Codex CLI** 初始化提示词
- [`step1-init-gemini.md`](./step1-init-gemini.md) — **Gemini CLI** 初始化提示词
- [`claude-code-personal-assistant-bootstrap-prompt.md`](./claude-code-personal-assistant-bootstrap-prompt.md) — Claude Code 提示词说明文档

### Codex CLI 多强度版本

三个执行强度不同的 Codex CLI 版本：

- [`codex-cli-personal-assistant-prompt-safe.md`](./codex-cli-personal-assistant-prompt-safe.md) — 先审查、后修改。适合第一次试用。
- [`codex-cli-personal-assistant-prompt-lite.md`](./codex-cli-personal-assistant-prompt-lite.md) — 平衡版，适合日常默认使用。
- [`codex-cli-personal-assistant-prompt-strong.md`](./codex-cli-personal-assistant-prompt-strong.md) — 更强执行版，适合新项目。
- [`codex-cli-personal-assistant-prompt-comparison.md`](./codex-cli-personal-assistant-prompt-comparison.md) — 三个版本的横向对比表。

## 快速开始

### Claude Code

1. 打开 [`step1-init.md`](./step1-init.md)
2. 复制其中完整的 `text` 代码块
3. 在目标工作区里发给 Claude Code
4. Claude Code 会完成 `~/.claude/` 和 `.assistant/` 的初始化，然后自动进入 bootstrap 对话

### Codex CLI

1. 打开 [`step1-init-codex.md`](./step1-init-codex.md)
2. 复制其中完整的 `text` 代码块
3. 在目标工作区里发给 Codex CLI
4. Codex CLI 会完成 `~/.codex/AGENTS.md` 和 `.assistant/` 的初始化，然后进入 bootstrap

### Gemini CLI

1. 打开 [`step1-init-gemini.md`](./step1-init-gemini.md)
2. 复制其中完整的 `text` 代码块
3. 在目标工作区里发给 Gemini CLI
4. Gemini CLI 会完成 `~/.gemini/GEMINI.md` 和 `.assistant/` 的初始化，然后进入 bootstrap

> **只需执行一次。** 全局规则写入后永久生效。以后进入任何新项目，助手会自动初始化 `.assistant/` 并开始 bootstrap。

## 项目记忆结构

```
.assistant/
  SYSTEM.md          — 工作区级系统规则和安全边界
  USER.md            — 用户画像：姓名、角色、上下文、语言
  STYLE.md           — 沟通风格：简洁 vs 详细、语气、格式
  WORKFLOW.md        — 工作方式：报告结构、决策偏好
  TOOLS.md           — 工具偏好：常用目录、首选工具、边界
  MEMORY.md          — 精炼的长期可复用记忆
  BOOTSTRAP.md       — Bootstrap 状态追踪
  memory/
    daily/           — 短期日常上下文（YYYY-MM-DD.md）
    projects/        — 项目级跨会话记忆
  templates/         — 可复用的模板
  runtime/
    inbox.md         — 短期待办事项
    last-session.md  — 上次会话摘要
```

## 设计原则

- 把全局配置当成默认偏好层，而不是强控制层
- 优先增量编辑，而不是破坏性重写
- 强调项目本地记忆，而不是假设全局"全知"
- 用轻量 bootstrap 代替冗长问卷
- 尽量贴近每种 CLI 工具的真实行为边界

## FAQ

### 为什么不直接只用一个配置文件（`CLAUDE.md` / `AGENTS.md`）？

配置文件更适合放行为规则，不适合承载不断演化的协作上下文。用一个小型记忆结构把规则、偏好、项目历史、临时信息分层存放，更清晰也更好维护。

### `.assistant/` 会不会让工作区变得太重？

不会，如果控制得当。这套提示词刻意把结构保持很小，强调按需、增量补充。目标不是制造流程负担，而是用尽量少的本地记忆减少重复磨合。

### 可以在同一个项目里使用多种 CLI 工具吗？

可以。三种工具共享同一套 `.assistant/` 结构。你可以在同一个工作区内自由切换 Claude Code、Codex CLI、Gemini CLI——它们都会读写同一份项目记忆。

### 这套方案适合谁？

适合在同一个项目里反复使用 CLI 编程助手、希望跨会话保持连续性的人。如果你只是偶尔发几个一次性 prompt，这套结构就不太必要。

## 许可证

[MIT](./LICENSE)
