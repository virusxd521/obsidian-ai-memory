#!/bin/bash

# Obsidian AI Memory — Install Script
# Usage: ./install.sh /path/to/your/obsidian/vault

set -e

VAULT_PATH="$1"
MEMORY_FOLDER="AI Memory"

# --- Validate input ---
if [ -z "$VAULT_PATH" ]; then
  echo "Usage: ./install.sh /path/to/your/obsidian/vault"
  exit 1
fi

if [ ! -d "$VAULT_PATH" ]; then
  echo "Error: Vault path not found: $VAULT_PATH"
  exit 1
fi

# --- Create folder ---
TARGET="$VAULT_PATH/$MEMORY_FOLDER"
mkdir -p "$TARGET"

# --- Copy templates ---
cp templates/*.md "$TARGET/"
echo "Copied templates to: $TARGET"

# --- CLAUDE.md ---
CLAUDE_GLOBAL="$HOME/.claude/CLAUDE.md"
CLAUDE_TEMPLATE="claude-global.md"

if [ -f "$CLAUDE_GLOBAL" ]; then
  echo ""
  echo "WARNING: $CLAUDE_GLOBAL already exists."
  echo "Manually add the contents of $CLAUDE_TEMPLATE to it."
else
  mkdir -p "$HOME/.claude"
  cp "$CLAUDE_TEMPLATE" "$CLAUDE_GLOBAL"
  echo "Created: $CLAUDE_GLOBAL"
fi

# --- Done ---
echo ""
echo "Done! Next steps:"
echo "  1. Open Obsidian → navigate to '$MEMORY_FOLDER' folder"
echo "  2. Fill in '01 Who I Am.md' with your details"
echo "  3. Fill in '02 Work & Tech Stack.md' with your stack"
echo "  4. Update the vault path in $CLAUDE_GLOBAL if needed"
echo "  5. Start a new Claude Code session — context loads automatically"
echo ""
echo "Full guide: SETUP.md"
