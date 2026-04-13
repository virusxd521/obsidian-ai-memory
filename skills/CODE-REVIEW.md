# SKILL: Code Review

> Load this when reviewing code, PRs, or asking Claude to audit a file.
> Trigger: "Review this — use code review skill"

---

## Review Focus (in priority order)
1. Correctness — does it do what it's supposed to?
2. Security — any obvious vulnerabilities?
3. Readability — will future-me understand this?
4. Performance — any obvious bottlenecks?

## What I care about
- [ ] Add your conventions (e.g. "we use named exports only")
- [ ] Add your non-negotiables (e.g. "no console.log in production code")
- [ ] Add your team standards (e.g. "all async functions must handle errors")

## Output Format
- Lead with a verdict: LGTM / Minor issues / Needs work
- Bullet list of issues — most critical first
- For each issue: what's wrong, why it matters, suggested fix
- Skip commenting on style if a linter handles it

## What NOT to flag
- Personal style preferences with no functional impact
- Things already handled by the linter/formatter
- Hypothetical future problems that aren't present yet

---

*Customize this file with your team's actual conventions*
*Place in your Obsidian AI Memory/skills/ folder*
