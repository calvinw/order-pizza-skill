# AGENTS.md — Working in ai-codespace-skill-and-mcp

This document is the technical reference for agents working in this repository.

> **Student communication:** Claude Code reads [CLAUDE.md](CLAUDE.md) automatically for tone and student-facing behavior rules. All agents working with students should read that file too.

## Project Overview

This repository is a minimal working template for a GitHub Codespace that:

1. **Connects every AI tool to a remote MCP server** — via a single shared config file (`configs/mcp-urls.conf`) that all setup scripts read
2. **Pre-loads a skill across all tools** — via `.skillshare/` so any AI tool can run `/pizza-ordering`
3. **Boots automatically** — `.devcontainer/post-create.sh` runs all setup on Codespace start

The design goal is simplicity: one MCP, one skill, all tools wired up from a single source of truth.

---

## MCP Server

All AI tools connect to the MCP server defined in `configs/mcp-urls.conf`:

| Server | URL | Purpose |
|--------|-----|---------|
| **dolt** | `https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse` | Read/write the BusMgmtBenchmarks Dolt database |

### Using the Dolt MCP

**In Claude Code / Codex / other tools with MCP tools exposed in-session:**

```
mcp__dolt__read_query(db_string="calvinw/BusMgmtBenchmarks/main", sql="SELECT * FROM company_info")
mcp__dolt__write_query(db_string="calvinw/BusMgmtBenchmarks/main", sql="INSERT INTO ...")
mcp__dolt__list_tables(db_string="calvinw/BusMgmtBenchmarks/main")
```

**In Crush:**

```
mcp_dolt_read_query(sql="SELECT * FROM company_info", db_string="calvinw/BusMgmtBenchmarks/main")
```

### Adding More MCP Servers

Edit `configs/mcp-urls.conf` — add one line per server in `name=url` format:

```
my-server=https://my-server.example.com/mcp/sse
```

All setup scripts read this file. On the next Codespace boot (or after running `bash .devcontainer/post-create.sh` manually), every AI tool will have the new server registered.

---

## Skill

### `/pizza-ordering`

**Purpose:** Run an interactive pizza ordering session as "The Order Technician".

**Full workflow:** See `.skillshare/skills/pizza-ordering/SKILL.md`

**Inputs:** None — just type `/pizza-ordering` to start.

**What it does:**
1. Greets the customer as "The Order Technician"
2. Takes the order conversationally, prompting for size and toppings
3. Shows a running order summary after each item
4. Collects customer name, phone number, and delivery/pickup preference
5. Applies tiered discounts (and senior discount if applicable)
6. Displays a final itemized order with full discount arithmetic

**Example:**
```
/pizza-ordering
```

### Adding More Skills

Create a new folder under `.skillshare/skills/` with a `SKILL.md` file:

```
.skillshare/skills/
└── my-skill/
    └── SKILL.md    ← skill definition with frontmatter + workflow steps
```

The `SKILL.md` frontmatter must include `name` and `description`. The `description` is what the AI uses to decide when to invoke the skill.

---

## How the MCP Setup Works

This is the core pattern of the repository. Understanding it lets you add MCPs or adapt the setup to other tools.

### Single Source of Truth

`configs/mcp-urls.conf` is the only file you need to edit to add or change MCP servers:

```
# name=url format, one per line
dolt=https://bus-mgmt-databases.mcp.mathplosion.com/mcp-dolt-database/sse
```

### Per-Tool Setup Scripts

Each AI tool has a setup script in `scripts/` that reads `mcp-urls.conf` and generates a tool-specific config:

| Script | What it generates |
|--------|------------------|
| `setup-claude.sh` | `.claude/settings.json` (SSE transport) |
| `setup-codex.sh` | `.codex/config.toml` (stdio via supergateway bridge) |
| `setup-copilot.sh` | `.copilot/mcp-config.json` |
| `setup-gemini.sh` | `.gemini/settings.json` |
| `setup-opencode.sh` | `.opencode/opencode.json` |
| `setup-crush.sh` | `.crush.json` |

Generated configs are gitignored — they are rebuilt on every Codespace boot from the checked-in source files.

### Why Codex is Different

Codex cannot use SSE endpoints directly. `setup-codex.sh` installs `supergateway` (an npm package) locally at `.codex-tools/supergateway/` and generates a config that wraps each SSE URL as a stdio subprocess. This happens automatically — you do not need to do anything special.

### Reference Configs

`configs/` contains checked-in reference versions of each tool's config. These are used by the setup scripts as templates and are the source of truth for what MCP servers are configured:

```
configs/
├── mcp-urls.conf          ← SOURCE OF TRUTH — edit this to add MCPs
├── claude/settings.json   ← Reference Claude config
├── copilot/mcp-config.json
├── gemini/settings.json
└── opencode/opencode.json
```

### Boot Sequence

`.devcontainer/post-create.sh` runs on Codespace start:

1. `setup-env.sh` — environment bootstrap
2. `sync-skills.sh` — copy skills from `.skillshare/` to each tool
3. `setup-codex.sh` — install supergateway + generate Codex config
4. `setup-claude.sh` — generate Claude config + register MCPs via CLI
5. `setup-crush.sh` — generate Crush config
6. `setup-copilot.sh` — Copilot setup
7. `setup-gemini.sh` — Gemini setup
8. `setup-opencode.sh` — OpenCode setup

To re-run manually after making changes:

```bash
bash .devcontainer/post-create.sh
```

---

## File Organization

```
.
├── README.md                          # Project overview
├── AGENTS.md                          # This file — technical reference
├── CLAUDE.md                          # Claude Code behavior rules
├── configs/
│   ├── mcp-urls.conf                  # ← EDIT THIS to add/change MCP servers
│   ├── claude/settings.json           # Reference Claude config
│   ├── copilot/mcp-config.json        # Reference Copilot config
│   ├── gemini/settings.json           # Reference Gemini config
│   └── opencode/opencode.json         # Reference OpenCode config
├── .skillshare/
│   ├── config.yaml                    # Skillshare targets (all tools)
│   └── skills/
│       └── pizza-ordering/
│           └── SKILL.md               # Pizza ordering skill definition
├── .devcontainer/
│   ├── devcontainer.json              # Codespace config
│   └── post-create.sh                 # Boot orchestrator
├── scripts/
│   ├── setup-env.sh
│   ├── setup-claude.sh
│   ├── setup-codex.sh
│   ├── setup-copilot.sh
│   ├── setup-crush.sh
│   ├── setup-gemini.sh
│   ├── setup-opencode.sh
│   └── sync-skills.sh
├── .claude/                           # Generated by setup-claude.sh (gitignored)
├── .codex/                            # Generated by setup-codex.sh (gitignored)
├── .codex-tools/                      # supergateway local install (gitignored)
├── .copilot/                          # Generated by setup-copilot.sh (gitignored)
├── .gemini/                           # Generated by setup-gemini.sh (gitignored)
├── .opencode/                         # Generated by setup-opencode.sh (gitignored)
└── .crush.json                        # Generated by setup-crush.sh (gitignored)
```

---

## Quick Reference for New Agents

- [ ] Read this file (AGENTS.md)
- [ ] Check `configs/mcp-urls.conf` to confirm which MCP servers are active
- [ ] Verify MCP tools are available in the session before calling them
- [ ] Use `/pizza-ordering` to start a pizza ordering session
- [ ] To add an MCP: add a line to `configs/mcp-urls.conf`, then run `bash .devcontainer/post-create.sh`
- [ ] To add a skill: create `.skillshare/skills/your-skill/SKILL.md`
