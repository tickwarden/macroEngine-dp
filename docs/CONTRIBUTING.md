
# Contributing Guide

Thank you for considering contributing to this Minecraft Java Edition datapack.

This document defines contribution standards, architectural constraints, and review criteria.  
All contributions are evaluated based on stability, performance, security, and long-term maintainability.

---

## Project Philosophy

This datapack prioritizes:

- Deterministic and predictable behavior
- Server-side performance optimization
- Secure and auditable command architecture
- Backward compatibility within supported versions
- Minimal unnecessary tick execution

Contributions that conflict with these principles may be rejected.

---

## Before You Contribute

Ensure the following before opening a pull request:

- You are targeting a supported version (see `SECURITY.md`)
- All changes are tested in a clean world
- No debug scoreboards or temporary storage values remain
- No development-only functions are included
- No experimental snapshot-only features are used
- No performance regression is introduced

---

## Development Standards

### 1. Namespacing

- All functions must use the project namespace.
- No pollution of the `minecraft:` namespace.
- Cross-namespace execution must be justified and documented.

---

### 2. Function Design

- No infinite loops.
- No recursive `execute` chains without guaranteed termination.
- Minimize logic inside `tick` functions.
- Prefer `storage` over unnecessary scoreboards when appropriate.
- Use targeted selectors instead of broad selectors (`@a`, `@e`) whenever possible.

---

### 3. Performance Rules

Contributions must avoid:

- Unbounded `@e` scans
- Nested `execute as @a at @a` patterns
- Heavy NBT checks every tick
- Excessive scoreboard writes
- Redundant function calls per tick

Any measurable performance regression may result in rejection.

---

### 4. Security Expectations

Pull requests must NOT include:

- Hidden command execution
- Permission bypass mechanisms
- Backdoors or obfuscated logic
- Crash triggers or lag exploits
- Storage manipulation outside the defined schema

Security-sensitive changes must include a technical explanation.

---

## Pull Request Process

1. Fork the repository.
2. Create a dedicated feature branch.
3. Keep commits atomic and clearly described.
4. Open a pull request including:

   - Clear description of changes
   - Technical explanation
   - Performance impact analysis
   - Testing steps
   - Relevant logs or screenshots (if applicable)

Incomplete or low-effort pull requests may be closed without review.

---

## Code Style

- Consistent indentation
- No trailing whitespace
- Clear and descriptive function naming
- Comment complex logic
- Avoid redundant or duplicated commands

### Example Function Structure

```mcfunction
# Initialize scoreboard
scoreboard objectives add example dummy

# Controlled execution
execute as @a[scores={example=1..}] run function namespace:feature/run
````

---

## Bug Reports

When opening an issue, include:

* Datapack version
* Minecraft version
* Steps to reproduce
* Expected result
* Actual result
* Relevant logs

Vague or incomplete reports may be closed.

---

## Feature Requests

Feature requests must include:

* Clear use case
* Performance consideration
* Compatibility analysis
* Explanation of alignment with project philosophy

---

## What Will Be Rejected

* Snapshot-only features
* Performance-heavy mechanics without justification
* Overengineered abstractions
* Features outside project scope
* Low-effort or poorly tested contributions

---

## Final Review Criteria

All contributions are evaluated based on:

* Stability
* Security
* Performance
* Maintainability
* Architectural consistency

Quality over quantity.

```
