# Codex CLI 个人助理初始化提示词合集

[English](./README.md)

这个仓库收集了一组为 Codex CLI 设计的初始化提示词，目标是把它从一次性问答工具，调整为更适合长期协作的本地个人助理。

仓库里包含三个主要版本和一个对比表，方便你按风险偏好和执行强度选择。

## 文件列表

- [codex-cli-personal-assistant-prompt-lite.md](./codex-cli-personal-assistant-prompt-lite.md)  
  平衡版，适合大多数日常使用场景。

- [codex-cli-personal-assistant-prompt-strong.md](./codex-cli-personal-assistant-prompt-strong.md)  
  更强执行版，适合希望 Codex 主动推进初始化和落盘的场景。

- [codex-cli-personal-assistant-prompt-safe.md](./codex-cli-personal-assistant-prompt-safe.md)  
  更安全保守版，适合首次试用或已有环境较复杂的情况。

- [codex-cli-personal-assistant-prompt-comparison.md](./codex-cli-personal-assistant-prompt-comparison.md)  
  三个版本的横向对比表。

## 怎么选

| 场景 | 推荐版本 |
| --- | --- |
| 第一次试这套方案 | `safe` |
| 作为长期默认方案使用 | `lite` |
| 新项目，希望一次性快速搭起来 | `strong` |
| 当前环境里已有较多手写配置 | `safe` |

## 推荐使用顺序

1. 先用 `safe` 做一次环境体检。
2. 结构跑顺后，日常默认切到 `lite`。
3. 明确想让 Codex 主动推进时，再用 `strong`。

## 使用说明

- `~/.codex/AGENTS.md` 更适合被理解为默认偏好层，不是永久强制控制层。
- `.assistant/` 是项目本地记忆约定，不是 Codex CLI 天然内建协议。
- 真实效果仍然取决于当前会话上下文、工具权限和更高优先级指令。

## 建议用法

打开你要使用的版本，把其中完整的 `text` 代码块发给 Codex CLI。

如果它在你的环境里过于激进，就退回 `safe`。
如果它推进不足、总是太保守，就切到 `strong`。

