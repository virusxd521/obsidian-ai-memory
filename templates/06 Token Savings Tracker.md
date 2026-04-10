# 06 — Token Savings Tracker

> Auto-populated by the load-memory hook. Run `token-stats.sh` to see the full summary.

---

## Quick Stats

Run this in terminal anytime:
```bash
bash ~/.claude/token-stats.sh
```

Or check the raw log:
```bash
cat ~/.claude/token-log.json
```

---

## How Savings Are Calculated

| Metric | How |
|--------|-----|
| **Tokens injected** | Actual chars output by hook ÷ 4 |
| **Baseline** | ~3,000 tokens (estimated manual re-explanation per session) |
| **Saved** | Baseline − tokens injected |
| **Cost saved** | Saved tokens × $3 per 1M (Claude Sonnet rate) |

---

## Saving Sources

| Source | Est. tokens saved per session |
|--------|-------------------------------|
| Hook auto-inject (01 + 04) | ~2,300 |
| Smart search vs. full load | ~400–800 |
| Memory compression (lean notes) | ~200 |
| **Total per session** | **~2,900–3,300** |

---

## Log Location

`~/.claude/token-log.json` — JSON file updated after every session.

---

*Tracking starts on first Claude Code session after install.*
