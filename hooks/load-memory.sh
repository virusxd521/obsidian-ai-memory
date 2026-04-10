#!/bin/bash

# Obsidian AI Memory — UserPromptSubmit Hook
# Injects core memory (01 Who I Am + 04 AI Working Rules) once per hour.
# install.sh replaces VAULT_PATH_PLACEHOLDER with your actual vault path.

VAULT="VAULT_PATH_PLACEHOLDER"
FLAG="/tmp/claude_memory_session"

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

echo "=== AI MEMORY LOADED ==="
echo ""

# Core files — always inject
for file in "01 Who I Am.md" "04 AI Working Rules.md"; do
  if [ -f "$VAULT/$file" ]; then
    echo "--- $file ---"
    cat "$VAULT/$file"
    echo ""
  fi
done

echo "=== END MEMORY ==="
echo "Tip: Load '02 Work & Tech Stack', '03 Active Projects', or '05 Interests & Domains' if relevant."
