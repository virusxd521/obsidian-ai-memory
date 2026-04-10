#!/bin/bash

# Obsidian AI Memory — Install Script
# Usage: ./install.sh /path/to/your/obsidian/vault

set -e

VAULT_PATH="$1"
MEMORY_FOLDER="AI Memory"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_GLOBAL="$CLAUDE_DIR/CLAUDE.md"
HOOK_SCRIPT="$CLAUDE_DIR/load-memory.sh"
SETTINGS="$CLAUDE_DIR/settings.json"

# --- Validate input ---
if [ -z "$VAULT_PATH" ]; then
  echo "Usage: ./install.sh /path/to/your/obsidian/vault"
  exit 1
fi

if [ ! -d "$VAULT_PATH" ]; then
  echo "Error: Vault path not found: $VAULT_PATH"
  exit 1
fi

mkdir -p "$CLAUDE_DIR"

# --- Copy memory templates to vault ---
TARGET="$VAULT_PATH/$MEMORY_FOLDER"
mkdir -p "$TARGET"
cp templates/*.md "$TARGET/"
echo "✓ Memory notes copied to: $TARGET"

# --- CLAUDE.md (global auto-load instructions) ---
if [ -f "$CLAUDE_GLOBAL" ]; then
  echo ""
  echo "⚠️  $CLAUDE_GLOBAL already exists — skipping."
  echo "   Manually merge contents of claude-global.md into it."
else
  cp claude-global.md "$CLAUDE_GLOBAL"
  echo "✓ Created: $CLAUDE_GLOBAL"
fi

# --- Hook script (reads vault files directly for guaranteed auto-load) ---
ESCAPED_VAULT=$(echo "$TARGET" | sed 's/[\/&]/\\&/g')
sed "s|VAULT_PATH_PLACEHOLDER|$TARGET|g" hooks/load-memory.sh > "$HOOK_SCRIPT"
chmod +x "$HOOK_SCRIPT"
echo "✓ Created hook script: $HOOK_SCRIPT"

# --- Register hook in settings.json ---
if [ -f "$SETTINGS" ]; then
  echo ""
  echo "⚠️  $SETTINGS already exists — hook not auto-added."
  echo "   Manually add this to your settings.json hooks section:"
  echo '   "UserPromptSubmit": [{"matcher":"","hooks":[{"type":"command","command":"bash '"$HOOK_SCRIPT"'"}]}]'
else
  cat > "$SETTINGS" <<EOF
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash $HOOK_SCRIPT"
          }
        ]
      }
    ]
  }
}
EOF
  echo "✓ Created: $SETTINGS (hook registered)"
fi

# --- Token stats script ---
cp token-stats.sh "$CLAUDE_DIR/token-stats.sh"
chmod +x "$CLAUDE_DIR/token-stats.sh"
echo "✓ Token stats script: $CLAUDE_DIR/token-stats.sh"

# --- Done ---
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅  Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Open Obsidian → '$MEMORY_FOLDER' folder"
echo "  2. Fill in '01 Who I Am.md'"
echo "  3. Fill in '02 Work & Tech Stack.md'"
echo "  4. (Optional) Drop 'project-CLAUDE.md' into any repo as CLAUDE.md"
echo "  5. Start a new Claude Code session — context loads automatically"
echo ""
echo "Check token savings anytime:"
echo "  bash ~/.claude/token-stats.sh"
echo ""
echo "Full guide: SETUP.md"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
