# AGENTS.md

All guidance for working in this repository — including tone, communication style, the skill workflow, and how to help students — lives in [CLAUDE.md](CLAUDE.md).

Read that file before doing anything else.

---

## Working on Skills

Skill files live at `.skillshare/skills/order-pizza/SKILL.md`. This is where you read and edit them.

**The `.skillshare/` folder is for distributing finished skills — not works in progress.** Do not run `scripts/sync-skills.sh` while a skill is still being developed or tested. Only sync when the skill is complete and ready to be published.

### How to work on a skill

- **To read or edit:** Open `.skillshare/skills/order-pizza/SKILL.md` directly.
- **To invoke it during a session:** Explicitly ask the agent to load the skill file. Do not expect it to be active automatically while you're working on it.
- **To test it properly:** Start a fresh session, then ask the agent to load the skill file.
- **To publish it when done:** Run `scripts/sync-skills.sh` to distribute it.
