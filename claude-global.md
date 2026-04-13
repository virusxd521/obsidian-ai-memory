# Global Claude Instructions

## Memory Palace — Auto-Load on Session Start

At the start of EVERY conversation, automatically do the following:

1. Read the Obsidian note: `AI Memory/AI Context Index.md`
   (Update this path to match where you placed the folder in your vault)
2. Always load: `01 Who I Am.md` and `04 AI Working Rules.md` (in the same folder)
3. Based on the task the user describes, also load:
   - Coding / work task → `02 Work & Tech Stack.md`
   - Project work → `03 Active Projects.md`
   - Research / learning → `05 Interests & Domains.md`
4. Confirm with one line: "Context loaded." — no summary, no list of files

Do NOT ask the user if they want context loaded. Just do it silently and confirm in one line.

## Skills — Task-Specific Instructions

When the user triggers a skill (e.g. "use code review skill", "use weekly planning skill"):
- Read the relevant file from `AI Memory/skills/`
- Apply its instructions for the rest of the session
- Skills can also load implicitly based on the task type

## After Productive Sessions

When the session involved decisions, new code, or facts worth remembering:
- Append a log entry to `03 Active Projects.md` in Obsidian
- Update any other relevant memory note if something changed
- Say: "Memory updated." (one line only)

Only do this if something genuinely worth saving happened.
