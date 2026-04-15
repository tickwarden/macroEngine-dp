# 👤 Player — `macro:player/*`

← [Home](Home)

---

## Overview

The player module manages per-player persistent data stored in `macro:engine players.<name>`. All functions accept `{player}` as the player name string. PID-based targeting ensures correctness on offline-mode servers.

---

## API

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `player/init` | `{player}` | — | Initialize player entry (auto-called on first use) |
| `player/reset` | `{player}` | — | **Dangerous** — delete all player data |
| `player/list_vars` | `{player}` | — | Show all stored variables to `macro.debug` |
| `player/add_default` | `{player, key, value}` | `result:1b` (new) / `0b` (existed) | Set default only if key doesn't exist |
| `player/increment` | `{player, key}` | — | Increase variable by 1 |
| `player/decrement` | `{player, key}` | — | Decrease variable by 1 |
| `player/get_pos` | `{player}` | `{x, y, z, found}` | Get block coordinates |
| `player/get_dimension` | `{player}` | `result` (dimension ID) | Get current dimension |
| `player/get_armor` | `{player}` | `{result, toughness, found}` | Get armor value (×1) and toughness (×1000) |
| `player/is_flying` | `{player}` | `{result, found}` | Is player flying? |
| `player/is_sneaking` | `{player}` | `{result, found}` | Is player sneaking? |
| `player/is_sprinting` | `{player}` | `{result, found}` | Is player sprinting? |
| `player/is_on_ground` | `{player}` | `{result, found}` | Is player on ground? |
| `player/is_burning` | `{player}` | `{result, found}` | Is player on fire? |

All boolean checks return `result:1b` (true) or `result:0b` (false). `found:0b` means the player is offline.

---

## PID System

macroEngine assigns each player a unique integer PID stored in `macro:engine player_pids`. PID-based selectors (`scores={macro.pid=N}`) are used internally for reliable targeting even on servers where multiple players might share the same name (offline mode).

PIDs are assigned on `player/init` and persist across `/reload` via storage.

---

## Examples

### Store and read a custom variable

```mcfunction
# Write
data modify storage macro:engine players.Steve.coins set value 150

# Read
data get storage macro:engine players.Steve.coins

# Increment
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "coins"
function macro:player/increment with storage macro:input {}
```

### Default value pattern

```mcfunction
# Only writes if "level" doesn't exist yet (safe initialization)
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "level"
data modify storage macro:input value set value 1
function macro:player/add_default with storage macro:input {}
```

### Position and dimension

```mcfunction
data modify storage macro:input player set value "Steve"
function macro:player/get_pos with storage macro:input {}
# output: { x: 128, y: 64, z: -256, found: 1b }

function macro:player/get_dimension with storage macro:input {}
# output.result: "minecraft:overworld"
```

### Check state predicates

```mcfunction
data modify storage macro:input player set value "Steve"
function macro:player/is_sneaking with storage macro:input {}
execute if data storage macro:output {result:1b} run function mypack:stealth/enter
```

---

## Storage Layout

```
macro:engine
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b }
└── player_pids
    └── { Steve: 1, Alex: 2 }
```

`macro.pid` scoreboard — per-entity runtime PID score for selector targeting.
