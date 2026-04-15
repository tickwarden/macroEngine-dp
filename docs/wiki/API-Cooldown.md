# 🕐 Cooldown — `macro:cooldown/*`

← [Home](Home)

---

## Overview

The cooldown module provides per-player, per-key timed locks. All durations are in **game ticks** (20 ticks = 1 second). Cooldown expiry is stored as an absolute epoch tick so it persists across function calls and survives `/reload`.

---

## API

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `cooldown/set` | `{player, key, duration}` | — | Start a cooldown (`duration` ticks) |
| `cooldown/check` | `{player, key}` | `result` (1b=ready / 0b=active) | Is the cooldown expired? |
| `cooldown/remaining` | `{player, key}` | `result` (ticks left, 0=done) | How many ticks remain? |
| `cooldown/clear` | `{player, key}` | — | Cancel a specific cooldown |
| `cooldown/clear_all` | `{player}` | — | Cancel all cooldowns for a player |
| `cooldown/pause` | `{player, key}` | — | Freeze an active cooldown |
| `cooldown/resume` | `{player, key}` | — | Restore a frozen cooldown |
| `cooldown/extend` | `{player, key, amount}` | — | Extend expiry by `amount` ticks (or start new) |
| `cooldown/detail` | `{player, key}` | `{active, remaining, expires}` | Full info in one call |

---

## Examples

### Basic ability cooldown

```mcfunction
# Check before use
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "fireball"
function macro:cooldown/check with storage macro:input {}

execute if data storage macro:output {result:1b} run function mypack:ability/fireball_use
execute if data storage macro:output {result:0b} run function mypack:ability/fireball_busy

# After use — set 5-second cooldown (100 ticks)
data modify storage macro:input duration set value 100
function macro:cooldown/set with storage macro:input {}
```

### Show remaining time in actionbar

```mcfunction
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "fireball"
function macro:cooldown/remaining with storage macro:input {}
# macro:output result → remaining ticks

# Convert to seconds and display
data modify storage macro:input ticks set from storage macro:output result
function macro:string/format_ticks with storage macro:input {}
# macro:output {minutes, seconds}
```

### Pause and resume (e.g. freeze during cutscene)

```mcfunction
# Freeze
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "dash"
function macro:cooldown/pause with storage macro:input {}

# ... cutscene plays ...

# Restore with original remaining duration
function macro:cooldown/resume with storage macro:input {}
```

### Get full cooldown details in one call

```mcfunction
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "fireball"
function macro:cooldown/detail with storage macro:input {}
# macro:output: { active:1b, remaining:60, expires:3480 }
execute if data storage macro:output {active:0b} run function mypack:ability/fireball_use
```

---

## Storage Layout

```
macro:engine cooldowns
└── Steve { fireball: 2460, dash: 1870 }  ← expiry tick values
```

Expiry is compared against `$epoch macro.time` (global monotonic tick counter).
