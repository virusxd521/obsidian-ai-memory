# Setup Guide

## Prerequisites

- [Obsidian](https://obsidian.md/) installed with a vault
- [Claude Code](https://claude.ai/code) CLI installed
- Node.js (for the Obsidian MCP server)

---

## Step 1 — Install the Obsidian MCP Server

The MCP server lets Claude read and write your Obsidian vault.

```bash
npm install -g @modelcontextprotocol/server-obsidian
```

> If that package name differs, check the latest at: https://github.com/anthropics/mcp-servers

---

## Step 2 — Connect MCP to Claude Code

Add the Obsidian MCP server to your Claude Code config:

```bash
claude mcp add obsidian -- npx @modelcontextprotocol/server-obsidian /path/to/your/vault
```

Replace `/path/to/your/vault` with the actual path to your Obsidian vault.

**Verify it's connected:**
```bash
claude mcp list
```
You should see `obsidian` listed.

---

## Step 3 — Install Memory Templates

Run the install script, pointing it at your vault:

```bash
chmod +x install.sh
./install.sh /path/to/your/obsidian/vault
```

This will:
- Copy the 5 memory note templates into an `AI Memory/` folder in your vault
- Create `~/.claude/CLAUDE.md` (the auto-load instruction for Claude)

---

## Step 4 — Fill In Your Details

Open Obsidian and navigate to the `AI Memory/` folder. Fill in:

1. **`01 Who I Am.md`** — Your background, goals, how you like AI to communicate
2. **`02 Work & Tech Stack.md`** — Your role, tech stack, key repos
3. **`05 Interests & Domains.md`** — Your knowledge areas and interests

Notes 03 and 04 are ready to use as-is.

---

## Step 5 — Test It

Open a **new** Claude Code session and say anything. Claude should respond with "Context loaded." before answering.

---

## Folder Structure After Setup

```
Your Obsidian Vault/
└── AI Memory/
    ├── AI Context Index.md    ← Entry point (tiny, always read first)
    ├── 01 Who I Am.md         ← Your profile
    ├── 02 Work & Tech Stack.md
    ├── 03 Active Projects.md  ← Session log (Claude updates this)
    ├── 04 AI Working Rules.md ← How Claude should behave
    └── 05 Interests & Domains.md

~/.claude/
└── CLAUDE.md                  ← Auto-load instruction (global)
```

---

## How It Works After Setup

| What | How |
|------|-----|
| Session start | Claude reads your Obsidian notes automatically |
| During session | Claude has your full context — no re-explaining |
| Session end | Claude logs key decisions to `03 Active Projects.md` |

**Token cost:** ~700 tokens to load core context (vs. 10,000–50,000+ for conversation replay)

---

## Customizing

- **Add your own rules** in `04 AI Working Rules.md`
- **Change what auto-loads** by editing `~/.claude/CLAUDE.md`
- **Place the folder anywhere** in your vault — just update the path in `CLAUDE.md`
