# 🏳️ Flag & State — `macro:flag/*` · `macro:state/*`

← [Home](Home)

---

## Flag Module — `macro:flag/*`

Flags are boolean (`1b`/`0b`) named values stored in `macro:engine flags`. Useful for global switches, feature toggles, and event guards.

### API

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `flag/set` | `{key}` | — | Set flag to `1b` |
| `flag/unset` | `{key}` | — | Set flag to `0b` |
| `flag/get` | `{key}` | `result` (1b/0b) | Read flag value |
| `flag/toggle` | `{key}` | `result` (new value) | Toggle between 1b/0b |
| `flag/list` | — | — | Show all flags to `macro.debug` players |
| `flag/set_if` | `{key, score_holder, objective, matches}` | `result` | Set flag if scoreboard condition is true |
| `flag/any` | `{key_a, key_b}` | `result`, `result_a`, `result_b` | True if either flag is set |

### Tick System Flags

Special flags that control macroEngine's tick subsystems — see [Admin Guide](Admin-Guide#tick-subsystem-flags).

| Function | Input | Description |
|----------|-------|-------------|
| `flag/toggle_system` | `{system}` | Toggle a tick subsystem flag |
| `flag/list_systems` | — | Show all subsystem flag states |

### Examples

```mcfunction
# Set a flag
data modify storage macro:input key set value "mypack.event_active"
function macro:flag/set with storage macro:input {}

# Check flag
function macro:flag/get with storage macro:input {}
execute if data storage macro:output {result:1b} run function mypack:event/tick

# Toggle
function macro:flag/toggle with storage macro:input {}
# output.result = new value (1b or 0b)

# Set flag based on scoreboard condition
data modify storage macro:input key set value "mypack.is_night"
data modify storage macro:input score_holder set value "$daytime"
data modify storage macro:input objective set value "macro.time"
data modify storage macro:input matches set value "..12000"
function macro:flag/set_if with storage macro:input {}
```

---

## State Module — `macro:state/*`

States are string or NBT values stored per-player in `macro:engine players.<n>`. Useful for tracking player-specific state machines.

### API

| Function | Input | Output | Description |
|----------|-------|--------|-------------|
| `state/set` | `{player, key, value}` | — | Set player state value |
| `state/get` | `{player, key}` | `result` | Read player state value |
| `state/is` | `{player, key, value}` | `result` (1b/0b) | Check if state equals value |
| `state/clear` | `{player, key}` | — | Delete a state key |
| `state/clear_all` | `{player}` | — | Delete all state keys for player |
| `state/list` | `{player}` | — | Show player states to `macro.debug` |
| `state/toggle` | `{player, on, off}` | `result` (new value) | Toggle between two values |

### Examples

```mcfunction
# Set player state
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "quest_stage"
data modify storage macro:input value set value "gather_wood"
function macro:state/set with storage macro:input {}

# Check state
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "quest_stage"
data modify storage macro:input value set value "gather_wood"
function macro:state/is with storage macro:input {}
execute if data storage macro:output {result:1b} run function mypack:quest/stage_1

# Toggle between "open" and "closed"
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "shop_status"
data modify storage macro:input on set value "open"
data modify storage macro:input off set value "closed"
function macro:state/toggle with storage macro:input {}
# output.result = "open" or "closed"
```
