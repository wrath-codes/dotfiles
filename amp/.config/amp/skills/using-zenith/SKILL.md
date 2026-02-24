---
name: using-zenith
description: "Manages projects with the Zenith CLI (znt). Use when initializing projects, managing sessions, installing packages, searching docs, tracking research/findings/hypotheses/insights, managing issues/tasks/PRDs, running studies, checking compatibility, logging implementation details, auditing trails, or wrapping up sessions."
---

# Zenith CLI (`znt`) — Complete Usage Guide

Zenith is an LLM-driven project knowledge management toolbox. The `znt` binary provides commands for project lifecycle, knowledge capture, research workflows, issue/task tracking, and team collaboration.

## Global Options (available on ALL commands)

| Flag | Short | Description |
|------|-------|-------------|
| `--format <FORMAT>` | `-f` | Output format: `json` (default), `table`, `raw` |
| `--limit <LIMIT>` | `-l` | Max results to return |
| `--quiet` | `-q` | Suppress non-essential output |
| `--verbose` | `-v` | Debug logging |
| `--project <PROJECT>` | `-p` | Project root path (defaults to auto-detect via `.zenith`) |

## Workflow: Starting a New Project

```bash
# 1. Initialize zenith in a new project
znt init --name "my-project" --ecosystem rust

# 2. Start a working session
znt session start

# 3. Install and index dependencies you need docs for
znt install tokio --ecosystem rust --version 1.49

# 4. Do your work, track research/findings/tasks...

# 5. End session with wrap-up
znt wrap-up --summary "Implemented auth module" --auto-commit
```

## Workflow: Onboarding an Existing Project

```bash
# Onboard with workspace detection and hook installation
znt onboard --workspace --install-hooks

# Or onboard a specific root, skip indexing
znt onboard --root /path/to/project --skip-indexing --ecosystem python
```

## Workflow: Research → Finding → Hypothesis → Insight

```bash
# 1. Create a research topic
znt research create --title "Evaluate vector DB options"

# 2. Record findings as you research
znt finding create --content "LanceDB supports DuckDB integration" \
  --source "lancedb docs" --confidence high --research <research-id>

# 3. Form hypotheses based on findings
znt hypothesis create --content "LanceDB + DuckDB will outperform Pinecone for our use case" \
  --research <research-id> --finding <finding-id>

# 4. Validate or reject hypotheses
znt hypothesis update <id> --status confirmed --reason "Benchmarks show 3x throughput"

# 5. Capture validated insights
znt insight create --content "Use LanceDB for vector storage with DuckDB analytical queries" \
  --confidence high --research <research-id>
```

## Workflow: PRD → Tasks → Completion

```bash
# 1. Create a PRD (creates an epic issue)
znt prd create --title "User Authentication System"

# 2. Set the PRD content
znt prd update <epic-id> --content "## Goals\n- OAuth2 support\n- JWT tokens..."

# 3. Generate parent tasks
znt prd tasks <epic-id> --tasks '["Design auth schema", "Implement OAuth2 flow", "Add JWT middleware"]'

# 4. Break parent tasks into subtasks
znt prd subtasks <parent-task-id> --epic <epic-id> \
  --tasks '["Create users table", "Add password hashing", "Write migration"]'

# 5. Work through tasks
znt task complete <task-id>

# 6. View PRD progress
znt prd get <epic-id>

# 7. Complete the PRD
znt prd complete <epic-id>
```

## Workflow: Studies (Structured Experimentation)

```bash
# 1. Create a study
znt study create --topic "Connection pooling strategies" --library sqlx --methodology "benchmark"

# 2. Add assumptions to test
znt study assume <study-id> --content "Pool size of 10 is optimal for our load"

# 3. Record test results
znt study test <study-id> <assumption-id> --result confirmed --evidence "p99 latency 12ms at pool=10 vs 45ms at pool=5"

# 4. Conclude the study
znt study conclude <study-id> --summary "Pool size 10 optimal; diminishing returns above 15"
```

## Command Quick Reference

| Command | Purpose |
|---------|---------|
| `znt init` | Initialize zenith for a project |
| `znt onboard` | Onboard existing project |
| `znt session start/end/list` | Session lifecycle |
| `znt install <pkg>` | Install and index a package |
| `znt search <query>` | Search indexed docs/knowledge |
| `znt grep <pattern>` | Regex grep over package cache |
| `znt cache list/clean/stats` | Cache management |
| `znt research create/update/list/get/registry` | Research entities |
| `znt finding create/update/list/get/tag/untag` | Findings |
| `znt hypothesis create/update/list/get` | Hypotheses |
| `znt insight create/update/list/get` | Insights |
| `znt issue create/update/list/get` | Issues |
| `znt task create/update/list/get/complete` | Tasks |
| `znt prd create/update/get/tasks/subtasks/complete/list` | PRD workflow |
| `znt log <location>` | Log implementation details |
| `znt compat check/list/get` | Compatibility checks |
| `znt study create/assume/test/get/conclude/list` | Studies |
| `znt link` | Create entity link |
| `znt unlink <id>` | Remove entity link |
| `znt audit` | View audit trail |
| `znt whats-next` | Project state and next steps |
| `znt wrap-up` | End session with wrap-up |
| `znt rebuild` | Rebuild DB from JSONL trail |
| `znt schema <type>` | Dump JSON schema for a type |
| `znt hook install/status/uninstall` | Git hook management |
| `znt auth login/logout/status/switch-org` | Authentication |
| `znt team invite/list` | Team management |
| `znt index` | Index project for cloud search |

For full argument details on every subcommand, read `reference/commands.md`.

## Key Concepts

- **Sessions**: Every work period should be wrapped in `session start` / `wrap-up`. Sessions track what happened.
- **Trail files**: All state is persisted as JSONL trail files in `.zenith/trail/`. These are git-tracked and can rebuild the DB via `znt rebuild`.
- **Entity links**: Connect any entities together (research↔finding, task↔issue, etc.) via `znt link`.
- **Audit trail**: Everything is auditable via `znt audit`. Filter by entity, action, session, or free-text search.
- **Hooks**: Git hooks validate trail files on commit, react to checkouts/merges. Install via `znt hook install`.

## Tips

- Use `--format table` for human-readable output, `--format json` for programmatic use.
- Use `znt whats-next` to get an AI-friendly summary of project state and suggested next actions.
- Use `znt search` with `--show-ref-graph` to see how documentation chunks relate.
- Use `znt grep` with `--all-packages` to search across all cached packages at once.
- Use `znt audit --merge-timeline --files` for a combined timeline of entity changes and file modifications.
