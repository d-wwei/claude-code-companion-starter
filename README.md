# Codex Companion Starter

[中文说明](./README.zh-CN.md)

A small prompt pack for turning Codex CLI into a more stable long-term personal assistant workflow.

This repository provides three prompt variants plus a comparison sheet, so you can choose between safer setup, balanced day-to-day use, and stronger automation.

## Files

- [codex-cli-personal-assistant-prompt-lite.md](./codex-cli-personal-assistant-prompt-lite.md)  
  Balanced version for most day-to-day use.

- [codex-cli-personal-assistant-prompt-strong.md](./codex-cli-personal-assistant-prompt-strong.md)  
  More proactive version for full initialization and faster setup.

- [codex-cli-personal-assistant-prompt-safe.md](./codex-cli-personal-assistant-prompt-safe.md)  
  Safer version for first-time setup or existing environments you want to inspect before changing.

- [codex-cli-personal-assistant-prompt-comparison.md](./codex-cli-personal-assistant-prompt-comparison.md)  
  Side-by-side comparison of the three prompt styles.

## Which One To Use

| Situation | Recommended |
| --- | --- |
| First time trying this workflow | `safe` |
| Default long-term usage | `lite` |
| New project and you want Codex to set up aggressively | `strong` |
| Existing workspace with a lot of hand-written config | `safe` |

## Recommended Order

1. Start with `safe` to inspect your current environment.
2. Move to `lite` once the structure feels right.
3. Use `strong` only when you want Codex to push setup forward with fewer confirmations.

## Practical Notes

- `~/.codex/AGENTS.md` should be treated as a default preference layer, not a permanent hard control layer.
- `.assistant/` is a local project convention for memory and collaboration context, not a built-in Codex CLI protocol.
- Actual behavior still depends on runtime instructions, tool permissions, and session context.

## Suggested Usage

Open the version you want, then send the full `text` code block to Codex CLI.

If Codex behaves too aggressively, fall back to `safe`.
If it is too conservative and does not make enough progress, switch to `strong`.

