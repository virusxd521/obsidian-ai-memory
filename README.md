# Obsidian AI Memory Palace

**Give Claude a persistent, automatic memory using your Obsidian vault.**

Instead of re-explaining yourself every session, Claude reads your context from Obsidian automatically — your profile, working rules, active projects, and tech stack. Sessions start smarter. Token usage drops by ~80–95%.

---

## How It Works

```
New Claude session starts
        │
        ▼
Hook fires → reads vault files from disk (guaranteed, no MCP needed)
        │
        ▼
CLAUDE.md loads Obsidian notes via MCP for deeper context
        │
        ▼
"Context loaded." — Claude knows who you are
        │
        ▼
Ask domain question → Claude searches vault first (smart search)
        │
        ▼
Session ends → Claude logs key facts back to Obsidian automatically
```

---

## Features

| Feature | How |
|---------|-----|
| **Auto-load on session start** | `UserPromptSubmit` hook reads vault files from disk |
| **Deep context on demand** | CLAUDE.md + Obsidian MCP loads full notes selectively |
| **Smart search** | Searches vault before loading full notes — saves tokens |
| **Auto session log** | Claude writes decisions back to Obsidian after each session |
| **Memory compression** | Compresses old session logs monthly to keep notes lean |
| **Per-project context** | Drop `project-CLAUDE.md` into any repo for project-specific memory |
| **Token savings tracking** | Hook logs every session — run `token-stats.sh` to see cumulative savings |

---

## Memory Files

| Note | Contents |
|------|----------|
| `01 Who I Am` | Background, goals, communication style |
| `02 Work & Tech Stack` | Role, repos, tools, stack |
| `03 Active Projects` | Current work + session log (auto-updated) |
| `04 AI Working Rules` | How Claude should behave |
| `05 Interests & Domains` | Knowledge areas, research context |

---

## Quick Start

```bash
# 1. Install Obsidian MCP
claude mcp add obsidian -- npx @modelcontextprotocol/server-obsidian /path/to/vault

# 2. Install memory templates + hook
chmod +x install.sh
./install.sh /path/to/your/obsidian/vault

# 3. Fill in your details (01 and 02 especially)

# 4. Start a new Claude Code session — done
```

Full instructions: [SETUP.md](SETUP.md)

---

## Token Efficiency

| Approach | ~Tokens per session |
|----------|-------------------|
| Re-explaining context manually | 2,000–10,000 |
| Pasting conversation history | 10,000–50,000+ |
| **This system (hook, core load)** | **~700** |
| **Smart search (targeted)** | **~200–400** |

**Track your actual savings:**

```bash
bash ~/.claude/token-stats.sh
```

```
╔══════════════════════════════════════════╗
║     Obsidian AI Memory — Token Stats     ║
╠══════════════════════════════════════════╣
║  Sessions tracked:        42             ║
║  Tokens injected:       29400            ║
║  Tokens saved:          96600            ║
║  Est. cost saved:       $0.2898          ║
║  Last session:        2026-04-10         ║
╚══════════════════════════════════════════╝
```

Every session is logged to `~/.claude/token-log.json` automatically.

---

## Per-Project Memory

Drop `templates/project-CLAUDE.md` into any repo as `CLAUDE.md`:

```bash
cp templates/project-CLAUDE.md ~/my-project/CLAUDE.md
```

Claude will load global memory + project-specific context automatically when working in that repo.

---

## Requirements

- [Obsidian](https://obsidian.md/)
- [Claude Code](https://claude.ai/code)
- Node.js

---

## Contributing

PRs welcome. Especially interested in:
- Templates for specific roles (designer, PM, data scientist)
- Setup guides for other AI tools (Cursor, Windsurf, etc.)
- Hooks for other Claude Code events

---

*Built with Claude Code + Obsidian MCP*
