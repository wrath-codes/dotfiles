# Zenith CLI — Full Command Reference

Every subcommand with all arguments and options. Global options (`-f`, `-l`, `-q`, `-v`, `-p`) are omitted for brevity — they apply to all commands.

---

## `znt init`

Initialize zenith for a project.

```
znt init [--name <NAME>] [--ecosystem <ECOSYSTEM>] [--no-index] [--skip-hooks]
```

| Option | Description |
|--------|-------------|
| `--name <NAME>` | Project name |
| `--ecosystem <ECOSYSTEM>` | Ecosystem (e.g., `rust`, `python`, `node`) |
| `--no-index` | Skip initial indexing |
| `--skip-hooks` | Don't install git hooks |

---

## `znt onboard`

Onboard an existing project.

```
znt onboard [--workspace] [--root <ROOT>] [--skip-indexing] [--ecosystem <ECOSYSTEM>] [--install-hooks]
```

| Option | Description |
|--------|-------------|
| `--workspace` | Detect workspace layout |
| `--root <ROOT>` | Explicit project root path |
| `--skip-indexing` | Skip indexing step |
| `--ecosystem <ECOSYSTEM>` | Ecosystem type |
| `--install-hooks` | Install git hooks during onboard |

---

## `znt session`

Session lifecycle management.

### `znt session start`

Start a new active session. No additional options.

### `znt session end`

End the active session.

| Option | Description |
|--------|-------------|
| `--summary <SUMMARY>` | Human summary to store with session wrap-up |

### `znt session list`

List sessions.

| Option | Description |
|--------|-------------|
| `--status <STATUS>` | Filter by status |
| `--limit <LIMIT>` | Max sessions to return |

---

## `znt install`

Install and index a package.

```
znt install <PACKAGE> [--ecosystem <ECOSYSTEM>] [--version <VERSION>] [--include-tests] [--force]
```

| Argument/Option | Description |
|--------|-------------|
| `<PACKAGE>` | Package name (required) |
| `--ecosystem <ECOSYSTEM>` | Package ecosystem |
| `--version <VERSION>` | Specific version |
| `--include-tests` | Include test files in index |
| `--force` | Force re-install |

---

## `znt search`

Search indexed documentation and knowledge.

```
znt search <QUERY> [OPTIONS]
```

| Option | Description |
|--------|-------------|
| `--package <PACKAGE>` | Restrict to a package |
| `--ecosystem <ECOSYSTEM>` | Filter by ecosystem |
| `--kind <KIND>` | Filter by kind |
| `--mode <MODE>` | Search mode |
| `--version <VERSION>` | Filter by version |
| `--context-budget <N>` | Context budget |
| `--max-depth <N>` | Max depth |
| `--max-chunks <N>` | Max chunks |
| `--max-bytes-per-chunk <N>` | Max bytes per chunk |
| `--max-total-bytes <N>` | Max total bytes |
| `--show-ref-graph` | Show reference graph |

---

## `znt grep`

Regex grep over package cache or local paths.

```
znt grep <PATTERN> [PATHS...] [OPTIONS]
```

| Option | Short | Description |
|--------|-------|-------------|
| `--package <PACKAGES>` | `-P` | Restrict to specific packages |
| `--ecosystem <ECOSYSTEM>` | | Filter by ecosystem |
| `--version <VERSION>` | | Filter by version |
| `--all-packages` | | Search all cached packages |
| `--fixed-strings` | `-F` | Treat pattern as literal |
| `--ignore-case` | `-i` | Case-insensitive |
| `--smart-case` | `-S` | Smart case (case-insensitive unless uppercase used) |
| `--word-regexp` | `-w` | Match whole words only |
| `--context <N>` | `-C` | Lines of context |
| `--include <GLOB>` | | Include file pattern |
| `--exclude <GLOB>` | | Exclude file pattern |
| `--max-count <N>` | `-m` | Max matches per file |
| `--count` | `-c` | Show match counts only |
| `--files-with-matches` | | Show filenames only |
| `--skip-tests` | | Skip test files |
| `--no-symbols` | | Exclude symbol files |

---

## `znt cache`

Cache management.

### `znt cache list`

List indexed packages in local cache. No additional options.

### `znt cache clean`

Clean local cache.

| Option | Description |
|--------|-------------|
| `--package <PACKAGE>` | Specific package to clean |
| `--ecosystem <ECOSYSTEM>` | Ecosystem for package clean |
| `--version <VERSION>` | Version for package clean |
| `--all` | Remove all cached data |

### `znt cache stats`

Show cache statistics. No additional options.

---

## `znt research`

Research entity management.

### `znt research create`

```
znt research create --title <TITLE> [--description <DESCRIPTION>]
```

### `znt research update`

```
znt research update <ID> [--title <TITLE>] [--description <DESCRIPTION>] [--status <STATUS>]
```

### `znt research list`

```
znt research list [--status <STATUS>] [--search <SEARCH>] [--limit <N>]
```

### `znt research get`

```
znt research get <ID>
```

### `znt research registry`

Query package registries.

```
znt research registry <QUERY> [--ecosystem <ECOSYSTEM>] [--limit <N>]
```

---

## `znt finding`

Findings management.

### `znt finding create`

```
znt finding create --content <CONTENT> [--source <SOURCE>] [--confidence <CONFIDENCE>] [--research <RESEARCH_ID>] [--tag <TAG>]
```

### `znt finding update`

```
znt finding update <ID> [--content <CONTENT>] [--source <SOURCE>] [--confidence <CONFIDENCE>]
```

### `znt finding list`

```
znt finding list [--search <SEARCH>] [--research <RESEARCH_ID>] [--confidence <CONFIDENCE>] [--tag <TAG>] [--limit <N>]
```

### `znt finding get`

```
znt finding get <ID>
```

### `znt finding tag`

```
znt finding tag <ID> <TAG>
```

### `znt finding untag`

```
znt finding untag <ID> <TAG>
```

---

## `znt hypothesis`

Hypothesis management.

### `znt hypothesis create`

```
znt hypothesis create --content <CONTENT> [--research <RESEARCH_ID>] [--finding <FINDING_ID>]
```

### `znt hypothesis update`

```
znt hypothesis update <ID> [--content <CONTENT>] [--reason <REASON>] [--status <STATUS>]
```

### `znt hypothesis list`

```
znt hypothesis list [--status <STATUS>] [--research <RESEARCH_ID>] [--search <SEARCH>] [--limit <N>]
```

### `znt hypothesis get`

```
znt hypothesis get <ID>
```

---

## `znt insight`

Insight management.

### `znt insight create`

```
znt insight create --content <CONTENT> [--confidence <CONFIDENCE>] [--research <RESEARCH_ID>]
```

### `znt insight update`

```
znt insight update <ID> [--content <CONTENT>] [--confidence <CONFIDENCE>]
```

### `znt insight list`

```
znt insight list [--search <SEARCH>] [--confidence <CONFIDENCE>] [--research <RESEARCH_ID>] [--limit <N>]
```

### `znt insight get`

```
znt insight get <ID>
```

---

## `znt issue`

Issue tracking.

### `znt issue create`

```
znt issue create --title <TITLE> [--type <ISSUE_TYPE>] [--priority <PRIORITY>] [--description <DESCRIPTION>] [--parent <PARENT_ID>]
```

### `znt issue update`

```
znt issue update <ID> [--title <TITLE>] [--type <ISSUE_TYPE>] [--description <DESCRIPTION>] [--status <STATUS>] [--priority <PRIORITY>]
```

### `znt issue list`

```
znt issue list [--status <STATUS>] [--type <ISSUE_TYPE>] [--search <SEARCH>] [--limit <N>]
```

### `znt issue get`

```
znt issue get <ID>
```

---

## `znt task`

Task management.

### `znt task create`

```
znt task create --title <TITLE> [--description <DESCRIPTION>] [--issue <ISSUE_ID>] [--research <RESEARCH_ID>]
```

### `znt task update`

```
znt task update <ID> [--title <TITLE>] [--description <DESCRIPTION>] [--status <STATUS>] [--research <RESEARCH_ID>] [--issue <ISSUE_ID>]
```

### `znt task list`

```
znt task list [--status <STATUS>] [--issue <ISSUE_ID>] [--research <RESEARCH_ID>] [--search <SEARCH>] [--limit <N>]
```

### `znt task get`

```
znt task get <ID>
```

### `znt task complete`

```
znt task complete <ID>
```

---

## `znt prd`

PRD (Product Requirements Document) workflow. PRDs are implemented as epic issues.

### `znt prd create`

```
znt prd create --title <TITLE> [--description <DESCRIPTION>]
```

### `znt prd update`

```
znt prd update <EPIC_ID> --content <CONTENT>
```

| Argument | Description |
|----------|-------------|
| `<EPIC_ID>` | Epic issue ID |
| `--content` | PRD markdown content |

### `znt prd get`

Get full PRD with tasks, progress, findings, and open questions.

```
znt prd get <EPIC_ID>
```

### `znt prd tasks`

Generate parent tasks for a PRD.

```
znt prd tasks <EPIC_ID> --tasks <JSON_ARRAY>
```

| Argument | Description |
|----------|-------------|
| `<EPIC_ID>` | Epic issue ID |
| `--tasks` | JSON array of task title strings |

### `znt prd subtasks`

Generate sub-tasks for a parent task.

```
znt prd subtasks <PARENT_TASK_ID> --epic <EPIC_ID> --tasks <JSON_ARRAY>
```

### `znt prd complete`

```
znt prd complete <EPIC_ID>
```

### `znt prd list`

```
znt prd list [--status <STATUS>] [--search <SEARCH>] [--limit <N>]
```

---

## `znt log`

Log implementation details for file locations.

```
znt log <LOCATION> [--task <TASK_ID>] [--description <DESCRIPTION>]
```

| Argument/Option | Description |
|--------|-------------|
| `<LOCATION>` | File location (required) |
| `--task <TASK_ID>` | Associated task |
| `--description <DESCRIPTION>` | Description of what was done |

---

## `znt compat`

Compatibility checks between packages.

### `znt compat check`

Create or update compatibility status for a package pair.

```
znt compat check <PACKAGE_A> <PACKAGE_B> [--status <STATUS>] [--conditions <CONDITIONS>] [--finding <FINDING_ID>]
```

### `znt compat list`

```
znt compat list [--status <STATUS>] [--package <PACKAGE>] [--limit <N>]
```

### `znt compat get`

```
znt compat get <ID>
```

---

## `znt study`

Structured experimentation workflow.

### `znt study create`

```
znt study create --topic <TOPIC> [--library <LIBRARY>] [--methodology <METHODOLOGY>] [--research <RESEARCH_ID>]
```

### `znt study assume`

Add an assumption to a study.

```
znt study assume <STUDY_ID> --content <CONTENT>
```

### `znt study test`

Record a test result for an assumption.

```
znt study test <STUDY_ID> <ASSUMPTION_ID> --result <RESULT> [--evidence <EVIDENCE>]
```

### `znt study get`

Get full study state.

```
znt study get <STUDY_ID>
```

### `znt study conclude`

```
znt study conclude <STUDY_ID> --summary <SUMMARY>
```

### `znt study list`

```
znt study list [--status <STATUS>] [--library <LIBRARY>] [--limit <N>]
```

---

## `znt link`

Create an entity link between any two entities.

```
znt link <SOURCE_TYPE> <SOURCE_ID> <TARGET_TYPE> <TARGET_ID> <RELATION>
```

| Argument | Description |
|----------|-------------|
| `<SOURCE_TYPE>` | Source entity type (e.g., `research`, `finding`, `task`) |
| `<SOURCE_ID>` | Source entity ID |
| `<TARGET_TYPE>` | Target entity type |
| `<TARGET_ID>` | Target entity ID |
| `<RELATION>` | Relation label |

---

## `znt unlink`

Remove an entity link.

```
znt unlink <LINK_ID>
```

---

## `znt audit`

View the audit trail.

```
znt audit [OPTIONS]
```

| Option | Description |
|--------|-------------|
| `--entity-type <TYPE>` | Filter by entity type |
| `--entity-id <ID>` | Filter by entity ID |
| `--action <ACTION>` | Filter by action |
| `--session <SESSION>` | Filter by session |
| `--search <SEARCH>` | Free-text search |
| `--files` | Include file modifications |
| `--merge-timeline` | Merge entity and file timelines |

---

## `znt whats-next`

Show project state and suggested next steps. No additional options.

---

## `znt wrap-up`

End session and perform wrap-up flow.

```
znt wrap-up [--summary <SUMMARY>] [--auto-commit] [--message <MESSAGE>] [--require-sync]
```

| Option | Description |
|--------|-------------|
| `--summary <SUMMARY>` | Session summary |
| `--auto-commit` | Auto-commit trail changes |
| `--message <MESSAGE>` | Commit message |
| `--require-sync` | Require cloud sync before ending |

---

## `znt rebuild`

Rebuild database from JSONL trail files.

```
znt rebuild [--trail-dir <DIR>] [--strict] [--dry-run]
```

| Option | Description |
|--------|-------------|
| `--trail-dir <DIR>` | Path to trail directory |
| `--strict` | Fail on any invalid trail entry |
| `--dry-run` | Preview without writing |

---

## `znt schema`

Dump JSON schema for a registered type.

```
znt schema <TYPE_NAME>
```

---

## `znt hook`

Git hook management.

### `znt hook install`

Install Zenith hook scripts and wire git hooks.

| Option | Description |
|--------|-------------|
| `--strategy <STRATEGY>` | `chain` (default) or `refuse`. Chain runs existing hooks first; refuse fails if hooks exist. |

### `znt hook status`

Show hook installation status. No additional options.

### `znt hook uninstall`

Remove Zenith-managed hook wiring. No additional options.

### `znt hook pre-commit`

Validate staged `.zenith/trail/*.jsonl` files. (Called by git hook, not typically run manually.)

### `znt hook post-checkout`

React to checkout trail diffs. (Called by git hook.)

### `znt hook post-merge`

React to merge trail updates. (Called by git hook.)

---

## `znt auth`

Authentication management.

### `znt auth login`

Log in via browser or API key.

| Option | Description |
|--------|-------------|
| `--api-key` | Use API key for CI/headless auth |
| `--user-id <USER_ID>` | Clerk user ID (required with `--api-key`) |

### `znt auth logout`

Clear stored credentials. No additional options.

### `znt auth status`

Show current auth status. No additional options.

### `znt auth switch-org`

```
znt auth switch-org <ORG_SLUG>
```

---

## `znt team`

Team management.

### `znt team invite`

```
znt team invite <EMAIL> [--role <ROLE>]
```

| Option | Description |
|--------|-------------|
| `--role <ROLE>` | Role to assign (default: `org:member`) |

### `znt team list`

List members of the current organization. No additional options.

---

## `znt index`

Index the current project for private cloud search.

```
znt index [PATH] [--force]
```

| Option | Description |
|--------|-------------|
| `[PATH]` | Path to index (defaults to `.`) |
| `--force` | Force re-index |
