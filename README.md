# Obsidian AI Memory Palace

**Give Claude (or any LLM) a persistent memory using your Obsidian vault.**

Instead of re-explaining yourself at the start of every session, Claude automatically loads your context from Obsidian — your profile, tech stack, active projects, and working rules. Sessions start smarter, responses are more relevant, and token usage drops by ~80–95%.

---

## How It Works

```
New Claude session starts
        │
        ▼
Claude reads your Obsidian notes (via MCP)
        │
        ▼
"Context loaded." — Claude knows who you are
        │
        ▼
You work... Claude has full context
        │
        ▼
Session ends → Claude logs key facts back to Obsidian
```

The magic is two things working together:
- **Obsidian MCP** — lets Claude read/write your vault in real time
- **`~/.claude/CLAUDE.md`** — tells Claude to auto-load your memory at every session start

---

## What Gets Stored

| Note | Contents |
|------|----------|
| `01 Who I Am` | Background, goals, communication style |
| `02 Work & Tech Stack` | Role, repos, tools, stack |
| `03 Active Projects` | Current work + session log |
| `04 AI Working Rules` | How Claude should behave |
| `05 Interests & Domains` | Knowledge areas, research context |

Each note is short and dense — bullet points, no fluff. Claude loads only what's relevant to the task.

---

## Quick Start

```bash
# 1. Install Obsidian MCP
claude mcp add obsidian -- npx @modelcontextprotocol/server-obsidian /path/to/vault

# 2. Install memory templates
chmod +x install.sh
./install.sh /path/to/your/obsidian/vault

# 3. Fill in your details in Obsidian (01 and 02 especially)

# 4. Start a new Claude Code session
```

Full instructions: [SETUP.md](SETUP.md)

---

## Token Efficiency

| Approach | ~Tokens per session |
|----------|-------------------|
| Re-explaining context manually | 2,000–10,000 |
| Pasting conversation history | 10,000–50,000+ |
| **This system (core load)** | **~700** |

---

## Requirements

- [Obsidian](https://obsidian.md/)
- [Claude Code](https://claude.ai/code)
- Node.js

---

## Customization

The system is fully yours to adapt:
- Edit any template to match your workflow
- Add custom rules to `04 AI Working Rules.md`
- Extend with new notes (just reference them in the Index)
- Works alongside any existing Obsidian structure

---

## Contributing

PRs welcome. Especially interested in:
- Templates for specific roles (designer, PM, data scientist)
- Setup guides for other AI tools (Cursor, Windsurf, etc.)
- Auto-update scripts / hooks

---

*Built with Claude Code + Obsidian MCP*
