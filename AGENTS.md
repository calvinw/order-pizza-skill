# AGENTS.md — Working in pizza-skill

This is the technical reference for all agents working in this repository. Read this before doing anything else.

> **Tone and voice:** The students you are working with are not programmers. See the communication style rules in [CLAUDE.md](CLAUDE.md) — follow them regardless of which AI tool you are.

---

## What This Repo Is For

This repository is a learning environment where **students help the AI build and refine a skill together**. The skill lives in `.skillshare/skills/` — look there to understand what exists. Do not assume you already know the full workflow. Let the student guide what gets built or changed.

Your job is to be a collaborator, not a script-follower. Be verbose, explain what you are doing, and make the student feel like a co-author.

---

## The Skill

The skill definition lives here:

```
.skillshare/skills/
└── pizza-ordering/
    └── SKILL.md    ← read this to understand the current state of the skill
```

The `SKILL.md` frontmatter includes a `name` and `description`. The description is what the AI uses to decide when to invoke the skill. When you and the student update the skill, edit this file.

### After Updating the Skill — Run the Sync

When `SKILL.md` is changed, you must sync it so every AI tool in the codespace picks up the new version. Run:

```bash
bash scripts/sync-skills.sh
```

This copies the skill files from `.skillshare/skills/` out to each tool's config directory. If you skip this step, other tools will still be running the old version of the skill.

---

## Running with Full Permissions

Each agent has a launch script in `permissions/` that starts it with all confirmations disabled. This is safe because the codespace is a self-contained container — there is nothing to accidentally wipe out.

| Script | What it does |
|--------|-------------|
| `permissions/claude.sh` | Launches Claude with `--dangerously-skip-permissions` |
| `permissions/crush.sh` | Launches Crush with `--yolo` |
| `permissions/copilot.sh` | Launches Copilot with `--allow-all` |
| `permissions/opencode.sh` | Injects read/write/execute allow into config, launches OpenCode, then restores the original config on exit |

Students should use these scripts so the agent can read and write files freely without stopping to ask for permission on every step.

---

## MCP Server

All tools connect to the Dolt database server defined in `configs/mcp-urls.conf`.

| Server | Purpose |
|--------|---------|
| **dolt** | Read/write the BusMgmtBenchmarks Dolt database |

### Example calls

```
mcp__dolt__read_query(db_string="calvinw/BusMgmtBenchmarks/main", sql="SELECT * FROM company_info")
mcp__dolt__write_query(db_string="calvinw/BusMgmtBenchmarks/main", sql="INSERT INTO ...")
mcp__dolt__list_tables(db_string="calvinw/BusMgmtBenchmarks/main")
```

To add more MCP servers, add a line to `configs/mcp-urls.conf` in `name=url` format, then re-run `bash .devcontainer/post-create.sh`.

---

## Key Files

```
.
├── CLAUDE.md                          # Tone and voice rules (Claude auto-loads this)
├── AGENTS.md                          # This file
├── configs/mcp-urls.conf              # ← Edit to add/change MCP servers
├── .skillshare/skills/pizza-ordering/
│   └── SKILL.md                       # ← The skill — read and edit this with the student
├── scripts/sync-skills.sh             # ← Run this after editing the skill
├── permissions/                       # ← Launch scripts with full permissions
└── .devcontainer/post-create.sh       # Re-run to rebuild all configs from scratch
```
