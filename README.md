# Claude Code Companion Starter

[中文说明](./README.zh-CN.md)

Turn your CLI coding assistant into a consistent, workspace-aware, long-term personal companion.

This is a collection of prompt templates for **Claude Code**, **Codex CLI**, and **Gemini CLI**. Instead of treating these tools as stateless Q&A bots, these prompts help them:

- maintain a stable collaboration style across sessions
- initialize structured project memory on the file system
- avoid unnecessary rewrites of existing content
- bootstrap user preferences through lightweight conversation

## Why This Exists

Raw prompts often assume an idealized agent with perfect memory. In practice, CLI coding assistants work better when instructions are:

- explicit about file operations and safety
- careful about preserving existing content
- realistic about what global config can and cannot do
- lightweight enough to stay out of the way during normal work

These prompts are written around that reality, tested across three different CLI tools.

## Supported CLI Tools

| CLI Tool | Init Prompt | Global Config Path | Config File |
| --- | --- | --- | --- |
| **Claude Code** | [`step1-init.md`](./step1-init.md) | `~/.claude/` | `CLAUDE.md` (with `@` imports) |
| **Codex CLI** | [`step1-init-codex.md`](./step1-init-codex.md) | `~/.codex/` | `AGENTS.md` (single file) |
| **Gemini CLI** | [`step1-init-gemini.md`](./step1-init-gemini.md) | `~/.gemini/` | `GEMINI.md` (single file) |

All three share the same `.assistant/` project-level memory structure. Switching between tools in the same workspace is seamless.

## Core Idea: File System as External Memory

This project borrows a key idea from [OpenClaw](https://docs.openclaw.ai/concepts/memory): treating the file system as durable working memory.

CLI coding assistants are strong at instruction execution. But they are not naturally good at preserving collaboration context over time. This project bridges that gap by adding a structured memory layer:

| Layer | Purpose |
| --- | --- |
| `~/.claude/` / `~/.codex/` / `~/.gemini/` | Global behavior rules that apply to all projects |
| `.assistant/` | Per-project memory: user profile, style, workflow, project decisions |

### What This Changes

- Preferences and rules stop living only in chat history
- Project decisions survive across sessions
- Temporary notes and stable preferences are cleanly separated
- Re-entering a workspace feels continuous instead of starting from scratch

### Concrete Examples

1. **Style stays stable.** "Be concise, give conclusions first, then risks" lives in `STYLE.md`, not repeated prompts.
2. **Decisions persist.** "Don't split the service yet" lives in `memory/projects/architecture.md`, not re-debated each session.
3. **Workflow is personalized.** "Inspect first, explain briefly, then edit, then verify" lives in `WORKFLOW.md`.
4. **Temporary context stays temporary.** "This API doc is unverified" goes to `memory/daily/YYYY-MM-DD.md`, not permanent memory.

## What's Included

### One-Click Init Prompts (Recommended)

These prompts set up both global rules and project-level memory in a single shot:

- [`step1-init.md`](./step1-init.md) — **Claude Code** init prompt
- [`step1-init-codex.md`](./step1-init-codex.md) — **Codex CLI** init prompt
- [`step1-init-gemini.md`](./step1-init-gemini.md) — **Gemini CLI** init prompt
- [`claude-code-personal-assistant-bootstrap-prompt.md`](./claude-code-personal-assistant-bootstrap-prompt.md) — Claude Code prompt overview and usage guide

### Codex CLI Prompt Variants

Three strength levels for Codex CLI, depending on how proactive you want it to be:

- [`codex-cli-personal-assistant-prompt-safe.md`](./codex-cli-personal-assistant-prompt-safe.md) — Inspect first, change later. Best for first-time setup.
- [`codex-cli-personal-assistant-prompt-lite.md`](./codex-cli-personal-assistant-prompt-lite.md) — Balanced default for day-to-day use.
- [`codex-cli-personal-assistant-prompt-strong.md`](./codex-cli-personal-assistant-prompt-strong.md) — Proactive setup for greenfield projects.
- [`codex-cli-personal-assistant-prompt-comparison.md`](./codex-cli-personal-assistant-prompt-comparison.md) — Side-by-side comparison of all three variants.

## Quick Start

### Claude Code

1. Open [`step1-init.md`](./step1-init.md).
2. Copy the full `text` code block.
3. Send it to Claude Code in your target workspace.
4. Claude Code will set up `~/.claude/` and `.assistant/`, then start a bootstrap conversation.

### Codex CLI

1. Open [`step1-init-codex.md`](./step1-init-codex.md).
2. Copy the full `text` code block.
3. Send it to Codex CLI in your target workspace.
4. Codex CLI will set up `~/.codex/AGENTS.md` and `.assistant/`, then start bootstrap.

### Gemini CLI

1. Open [`step1-init-gemini.md`](./step1-init-gemini.md).
2. Copy the full `text` code block.
3. Send it to Gemini CLI in your target workspace.
4. Gemini CLI will set up `~/.gemini/GEMINI.md` and `.assistant/`, then start bootstrap.

> **One-time setup.** You only need to run the init prompt once. Global rules persist permanently. For each new project, the assistant will automatically initialize `.assistant/` and start bootstrap.

## Project Memory Structure

```
.assistant/
  SYSTEM.md          — workspace-level rules and safety boundaries
  USER.md            — who the user is: name, role, context, language
  STYLE.md           — communication style: concise vs detailed, tone
  WORKFLOW.md        — how work is done: report structure, decision preferences
  TOOLS.md           — tool preferences: common dirs, preferred tools
  MEMORY.md          — concise long-term reusable memory
  BOOTSTRAP.md       — bootstrap state tracking
  memory/
    daily/           — short-lived daily context (YYYY-MM-DD.md)
    projects/        — project-level cross-session memory
  templates/         — reusable starter templates
  runtime/
    inbox.md         — short-lived action items
    last-session.md  — last session summary
```

## Design Principles

- Default preference layer, not hard control layer
- Incremental edits over destructive rewrites
- Project-local memory over assumed global omniscience
- Lightweight bootstrap over long onboarding forms
- Realistic compatibility with each CLI tool's actual behavior

## FAQ

### Why not just use a single config file (`CLAUDE.md` / `AGENTS.md`)?

Config files are best for behavior rules, not evolving collaboration context. A small memory structure keeps rules, preferences, project history, and temporary notes cleanly separated.

### Does `.assistant/` make the workspace too heavy?

Not if kept small. These prompts intentionally keep the structure minimal and fill it incrementally. The goal is just enough local memory to reduce repeated friction.

### Can I use multiple CLI tools in the same project?

Yes. All three tools share the same `.assistant/` structure. You can switch between Claude Code, Codex CLI, and Gemini CLI in the same workspace — they will all read from and write to the same project memory.

### Who is this for?

People who use CLI coding assistants repeatedly in the same projects and want more continuity across sessions. If you only use them for quick one-off prompts, this adds unnecessary structure.

## License

[MIT](./LICENSE)
