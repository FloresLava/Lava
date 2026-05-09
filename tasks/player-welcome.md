# Feature Task

## Feature Name

Player Welcome System

---

## Objective

When a player joins the game, the server logs a welcome message with the player's username.

---

## Required Pre-Work

Before making changes, agents must:
1. Inspect existing server services
2. Confirm no welcome system already exists
3. Summarize intended implementation before editing

---

## Editable Paths

Agents may ONLY edit:

- src/server/services/
- tests/

---

## Implementation Notes

- Use Players.PlayerAdded
- Server-side implementation only
- Do not create unnecessary modules for this feature

---

## Welcome Message Format

Example:
[WelcomeSystem] Player joined: Builderman

---

## Gameplay Requirements

- Detect when a player joins
- Log a clear welcome message
- Do not affect gameplay state
- Do not require client scripts

---

## Performance Constraints

- Use event-driven logic
- Do not use loops
- Disconnect events only if necessary

---

## Required Tests

- Player join event is handled
- Welcome message format is correct
- No duplicate handlers are created

---

## Deliverables

Agents must provide:

1. Modified files list
2. Summary of changes
3. Test results
4. Manual Studio testing instructions

---

## Completion Criteria

Feature is complete when:

- No runtime errors occur
- Rojo sync succeeds
- Message appears during Studio playtest
- No unauthorized files were modified

---

## Human Approval Required

YES
