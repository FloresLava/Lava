# Feature Task

## Feature Name
Example: Lava Damage System

---

## Objective
Describe exactly what the feature should do.

Example:
Players standing on lava take 10 damage every second until leaving the lava.

---

## Required Pre-Work

Before making changes, agents must:
1. Inspect relevant existing systems
2. Identify reusable modules/services
3. Confirm no conflicting system already exists
4. Summarize the intended implementation plan before editing

---

## Failure Handling

If requirements are unclear, agents must:
- stop implementation
- explain ambiguity
- request clarification

Agents must never invent missing gameplay requirements.

---

## Editable Paths

Agents may ONLY edit:

- src/server/services/
- src/shared/modules/
- tests/

Agents may NOT edit:

- default.project.json
- AGENTS.md
- rokit.toml
- wally.toml

---

## Architecture Constraints

- Prefer extending existing systems over creating new frameworks
- Reuse existing services/modules when possible
- New modules must have a single responsibility
- Avoid circular dependencies
- Shared logic belongs in src/shared/modules/
- Server authority belongs in src/server/services/

---

## Technical Requirements

- Use modular architecture
- Use clear variable names
- Avoid duplicated logic
- Include error handling
- Keep functions under 50 lines where possible
- Use type annotations where practical
- Prefer early returns over deeply nested conditionals

---

## Gameplay Requirements

- Damage occurs once per second
- Damage stops immediately after leaving lava
- Supports multiple players simultaneously
- Behavior must remain stable if a player resets, dies, or leaves the game

---

## Networking Rules

- Do not trust client-side damage values
- Server must validate all health changes
- Clients may only request actions
- Server owns authoritative gameplay state
- RemoteEvents must validate all inputs

---

## Performance Constraints

- Avoid unnecessary while loops
- Do not create duplicate damage loops
- Disconnect all event connections properly
- Prefer event-driven logic over polling where possible
- Minimize per-frame work

---

## Forbidden Behaviors

Agents must NOT:

- Rewrite unrelated systems
- Rename existing APIs unless required
- Remove existing tests
- Introduce new dependencies without approval
- Hardcode player names or user IDs
- Silently suppress warnings or errors

---

## Rollback Safety

Before major changes:
- summarize affected systems
- avoid overwriting unrelated changes
- preserve unrelated existing functionality
- do not modify unrelated files or systems
- avoid large multi-system rewrites in a single task
- recommend a git checkpoint if the task is risky
- never run git add, git commit, git reset, git checkout, or git clean without human approval

---

## Debugging Requirements

- Include useful warning messages
- Avoid silent failures
- Log unexpected states where appropriate

---

## Required Tests

- Player takes damage in lava
- Player stops taking damage outside lava
- Multiple players work correctly
- No duplicate damage loops are created
- Damage stops when a player leaves, dies, or resets

---

## Deliverables

Agents must provide:

1. Modified files list
2. Summary of changes
3. Test results
4. Known limitations
5. Any manual Studio test steps required

---

## Completion Criteria

Feature is complete when:

- All tests pass
- No runtime errors occur
- Rojo sync succeeds
- System behaves correctly in Studio playtest
- No unauthorized files were modified

---

## Human Approval Required

YES
