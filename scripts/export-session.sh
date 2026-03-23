#!/usr/bin/env bash
# export-session.sh — Auto-archive Claude Code session summaries
#
# Usage:
#   1. Manual: bash ~/.claude/scripts/export-session.sh
#   2. As a Claude Code hook (settings.json):
#      { "hooks": { "Stop": [{ "type": "command", "command": "~/.claude/scripts/export-session.sh" }] } }
#
# What it does:
#   - Finds the most recent Claude Code JSONL session file
#   - Extracts user and assistant messages (strips tool calls and system prompts)
#   - Writes a clean markdown summary to .assistant/memory/sessions/
#   - Appends an entry to sessions/INDEX.md
#
# Requirements: bash, jq
# No external dependencies beyond what macOS ships with.

set -euo pipefail

# --- Config ---
CLAUDE_PROJECTS_DIR="$HOME/.claude/projects"
ASSISTANT_DIR=".assistant"
SESSIONS_DIR="$ASSISTANT_DIR/memory/sessions"
INDEX_FILE="$SESSIONS_DIR/INDEX.md"
TIMESTAMP=$(date +"%Y-%m-%d-%H%M")
DATE_DISPLAY=$(date +"%Y-%m-%d %H:%M")
SESSION_FILE="$SESSIONS_DIR/${TIMESTAMP}.md"

# --- Preflight ---
if ! command -v jq &>/dev/null; then
  echo "[export-session] jq not found. Install with: brew install jq" >&2
  exit 1
fi

if [ ! -d "$ASSISTANT_DIR" ]; then
  echo "[export-session] No .assistant/ directory found in $(pwd). Skipping." >&2
  exit 0
fi

# --- Find latest session JSONL ---
# Claude Code stores sessions under ~/.claude/projects/<project-hash>/
# We look for the most recently modified .jsonl file
LATEST_JSONL=$(find "$CLAUDE_PROJECTS_DIR" -name "*.jsonl" -type f 2>/dev/null | xargs ls -t 2>/dev/null | head -1)

if [ -z "$LATEST_JSONL" ]; then
  echo "[export-session] No session files found." >&2
  exit 0
fi

# --- Extract messages ---
# Pull user and assistant text messages, skip tool_use and tool_result
MESSAGES=$(jq -r '
  select(.type == "human" or .type == "assistant") |
  if .type == "human" then
    if (.message | type) == "string" then
      "**User**: " + .message
    elif (.message | type) == "array" then
      .message[] | select(.type == "text") | "**User**: " + .text
    else empty end
  elif .type == "assistant" then
    if (.message.content | type) == "string" then
      "**Assistant**: " + .message.content
    elif (.message.content | type) == "array" then
      .message.content[] | select(.type == "text") | "**Assistant**: " + .text
    else empty end
  else empty end
' "$LATEST_JSONL" 2>/dev/null | head -200)

if [ -z "$MESSAGES" ]; then
  echo "[export-session] No extractable messages in latest session." >&2
  exit 0
fi

# Count message pairs for rough duration estimate
MSG_COUNT=$(echo "$MESSAGES" | grep -c "^\*\*User\*\*:" || true)

# --- Ensure directories exist ---
mkdir -p "$SESSIONS_DIR"

# --- Write session file ---
cat > "$SESSION_FILE" << EOF
# Session: ${DATE_DISPLAY}
project: $(basename "$(pwd)")
messages: ${MSG_COUNT}

## Conversation
${MESSAGES}
EOF

# --- Update INDEX.md ---
if [ ! -f "$INDEX_FILE" ]; then
  cat > "$INDEX_FILE" << 'HEADER'
# Session Index

| Date | Messages | Project | Summary | File |
|---|---|---|---|---|
HEADER
fi

# Grab first user message as summary (truncate to 80 chars)
FIRST_MSG=$(echo "$MESSAGES" | grep "^\*\*User\*\*:" | head -1 | sed 's/\*\*User\*\*: //' | cut -c1-80)
PROJECT_NAME=$(basename "$(pwd)")

echo "| ${DATE_DISPLAY} | ${MSG_COUNT} | ${PROJECT_NAME} | ${FIRST_MSG} | ${TIMESTAMP}.md |" >> "$INDEX_FILE"

echo "[export-session] Archived session to ${SESSION_FILE} (${MSG_COUNT} messages)"
