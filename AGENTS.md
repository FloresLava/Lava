# Lava Agent Rules

## Scope
- Agents may only edit files inside src/
- Agents may not modify git configuration
- Agents may not delete folders

## Coding Rules
- Use modular scripts
- Keep functions focused
- Prefer reusable systems

## Testing
- All gameplay systems require tests
- New systems must include error handling

## Workflow
1. Planner agent creates implementation plan
2. Builder agent writes code
3. Tester agent validates behavior
4. Reviewer agent checks quality
5. Human approves changes

## Safety
- Never rewrite default.project.json
- Never overwrite AGENTS.md
- Never modify Wally dependencies without approval
