#!/bin/bash

# Obsidian AI Memory — UserPromptSubmit Hook
# Injects core memory (01 Who I Am + 04 AI Working Rules) once per hour.
# Logs token usage to ~/.claude/token-log.json for savings tracking.
# install.sh replaces VAULT_PATH_PLACEHOLDER with your actual vault path.

VAULT="VAULT_PATH_PLACEHOLDER"
FLAG="/tmp/claude_memory_session"
TOKEN_LOG="$HOME/.claude/token-log.json"
BASELINE_TOKENS=3000  # Estimated tokens to explain context manually

# Only inject once per hour — avoids token bloat on every message
if [ -f "$FLAG" ]; then
  AGE=$(( $(date +%s) - $(stat -f %m "$FLAG" 2>/dev/null || stat -c %Y "$FLAG" 2>/dev/null || echo 0) ))
  if [ "$AGE" -lt 3600 ]; then
    exit 0
  fi
fi

# Check vault is accessible
if [ ! -d "$VAULT" ]; then
  exit 0
fi

touch "$FLAG"

OUTPUT=""
OUTPUT+="=== AI MEMORY LOADED ===\n\n"

for file in "01 Who I Am.md" "04 AI Working Rules.md"; do
  if [ -f "$VAULT/$file" ]; then
    OUTPUT+="--- $file ---\n"
    OUTPUT+="$(cat "$VAULT/$file")\n\n"
  fi
done

OUTPUT+="=== END MEMORY ===\n"
OUTPUT+="Tip: Load '02 Work & Tech Stack', '03 Active Projects', or '05 Interests & Domains' if relevant."

printf "$OUTPUT"

# --- Token tracking ---
CHARS=$(printf "$OUTPUT" | wc -c | tr -d ' ')
TOKENS=$(( CHARS / 4 ))
SAVED=$(( BASELINE_TOKENS - TOKENS ))
DATE=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%s)

NEW_ENTRY="{\"date\":\"$DATE\",\"timestamp\":$TIMESTAMP,\"chars_injected\":$CHARS,\"tokens_injected\":$TOKENS,\"baseline_tokens\":$BASELINE_TOKENS,\"tokens_saved\":$SAVED}"

if [ ! -f "$TOKEN_LOG" ]; then
  echo "{\"sessions\":[$NEW_ENTRY],\"total_sessions\":1,\"total_tokens_injected\":$TOKENS,\"total_tokens_saved\":$SAVED}" > "$TOKEN_LOG"
else
  TOTAL_SESSIONS=$(grep -o '"total_sessions":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)
  TOTAL_INJECTED=$(grep -o '"total_tokens_injected":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)
  TOTAL_SAVED=$(grep -o '"total_tokens_saved":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)

  NEW_TOTAL_SESSIONS=$(( TOTAL_SESSIONS + 1 ))
  NEW_TOTAL_INJECTED=$(( TOTAL_INJECTED + TOKENS ))
  NEW_TOTAL_SAVED=$(( TOTAL_SAVED + SAVED ))

  UPDATED=$(cat "$TOKEN_LOG" \
    | sed "s/\"sessions\":\[/\"sessions\":[$NEW_ENTRY,/" \
    | sed "s/\"total_sessions\":[0-9]*/\"total_sessions\":$NEW_TOTAL_SESSIONS/" \
    | sed "s/\"total_tokens_injected\":[0-9]*/\"total_tokens_injected\":$NEW_TOTAL_INJECTED/" \
    | sed "s/\"total_tokens_saved\":[0-9]*/\"total_tokens_saved\":$NEW_TOTAL_SAVED/")
  echo "$UPDATED" > "$TOKEN_LOG"
fi
