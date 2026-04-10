#!/bin/bash

# Obsidian AI Memory — Token Savings Stats
# Usage: bash token-stats.sh
# Shows cumulative token savings tracked by the load-memory hook.

TOKEN_LOG="$HOME/.claude/token-log.json"
COST_PER_1M=3  # Claude Sonnet ~$3 per 1M input tokens

if [ ! -f "$TOKEN_LOG" ]; then
  echo ""
  echo "No token log found yet."
  echo "Start a few Claude Code sessions and run this again."
  echo "Log will appear at: $TOKEN_LOG"
  exit 0
fi

TOTAL_SESSIONS=$(grep -o '"total_sessions":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)
TOTAL_INJECTED=$(grep -o '"total_tokens_injected":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)
TOTAL_SAVED=$(grep -o '"total_tokens_saved":[0-9]*' "$TOKEN_LOG" | grep -o '[0-9]*' || echo 0)
COST_SAVED=$(echo "scale=4; $TOTAL_SAVED * $COST_PER_1M / 1000000" | bc 2>/dev/null || echo "N/A")
LAST_DATE=$(grep -o '"date":"[^"]*"' "$TOKEN_LOG" | head -1 | grep -o '[0-9-]*' || echo "N/A")

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     Obsidian AI Memory — Token Stats     ║"
echo "╠══════════════════════════════════════════╣"
printf "║  Sessions tracked:    %6d              ║\n" "$TOTAL_SESSIONS"
printf "║  Tokens injected:     %6d              ║\n" "$TOTAL_INJECTED"
printf "║  Tokens saved:        %6d              ║\n" "$TOTAL_SAVED"
printf "║  Est. cost saved:     \$%-20s ║\n" "$COST_SAVED"
printf "║  Last session:        %-10s          ║\n" "$LAST_DATE"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "Baseline: ~3,000 tokens to explain context manually per session."
echo "Log:      $TOKEN_LOG"
echo ""
