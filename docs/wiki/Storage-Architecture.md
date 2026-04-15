# 🏗️ Storage Architecture

← [Home](Home)

---

## Overview

All macroEngine communication uses three NBT storage namespaces:

| Storage | Purpose |
|---------|---------|
| `macro:input` | Send arguments to a function |
| `macro:output` | Receive results from a function |
| `macro:engine` | Persistent engine state |

---

## `macro:engine` — Persistent State

```
macro:engine
├── global
│   ├── version: "v4.0.0"
│   └── tick: <int>
│
├── players
│   └── Steve { coins:150, level:5, xp:2300, online:1b, ... }
│
├── player_pids
│   └── { Steve: 1, Alex: 2, ... }          ← PID map (name → int)
│
├── _pid_seq                                  ← monotonic counter
│
├── cooldowns
│   └── Steve { fireball: 2460, dash: 1870 } ← expiry ticks
│
├── events
│   └── on_join: [{func:"mypack:welcome"}, {func:"mypack:xp_bonus"}]
│
├── queue
│   └── [{func:"mypack:event/end", delay:100}]
│
├── schedules
│   └── [{key:"my_timer", func:"mypack:tick_fn", interval:20, next:3840}]
│
├── hook_binds
│   └── [{event:"on_break", func:"mypack:on_break_handler"}]
│
├── interaction_binds
│   └── [{tag:"my_button", type:"use", func:"mypack:on_click"}]
│
├── wand_binds
│   └── [{tag:"my_wand", func:"mypack:on_right_click"}]
│
├── perm_triggers
│   └── my_trigger: [{value:1, func:"mypack:action", perm:"mypack.action"}]
│
├── perm_trigger_names
│   └── [{name:"my_trigger"}]
│
├── permissions
│   └── Steve: ["mypack.action", "mypack.admin"]
│
├── flags
│   └── { my_flag: 1b, other_flag: 0b }
│
├── config
│   └── { max_players: 10, spawn_rate: 5 }
│
├── log_display                               ← circular buffer (max 30)
│   └── [{level:"INFO", message:"...", color:"green"}]
│
├── region_watches
│   └── [{id:"spawn", x1:0,y1:0,z1:0, x2:100,y2:100,z2:100, func:"mypack:on_enter"}]
│
├── batches
│   └── [{id:"my_batch", items:[...], index:0}]
│
├── uuid_cache
│   └── { spawn_marker: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" }
│
├── dialog
│   └── { DIALOG: "mypack:my_dialog" }
│
└── fibers
    └── { fiber_id: {func:"mypack:step", state:{...}} }
```

---

## `macro:input` — Function Arguments

Before calling any macroEngine function, write your arguments to `macro:input`:

```mcfunction
data modify storage macro:input player set value "Steve"
data modify storage macro:input key set value "fireball"
data modify storage macro:input duration set value 100
function macro:cooldown/set with storage macro:input {}
```

> **Note:** Always use `set` (not `append`) on `macro:input` paths to avoid accumulation from previous calls.

### Preserving `macro:input` (input_push / input_pop)

If you need to call a function inside another function without clobbering `macro:input`:

```mcfunction
function macro:lib/input_push    # save current macro:input

data modify storage macro:input value set value 144
function macro:math/sqrt with storage macro:input {}
# output.result → 12

function macro:lib/input_pop     # restore macro:input
```

---

## `macro:output` — Function Results

After calling a function, read results from `macro:output`:

```mcfunction
function macro:cooldown/check with storage macro:input {}
execute if data storage macro:output {result:1b} run function mypack:ability/use
execute if data storage macro:output {result:0b} run function mypack:ability/busy
```

Common output fields:

| Field | Type | Used by |
|-------|------|---------|
| `result` | `1b`/`0b` or int | most check/query functions |
| `found` | `1b`/`0b` | player queries |
| `string.result` | string | `lib/string/*` |
| `inputs` | compound | `tools/utils/input_check` |

---

## Macro Substitution

Lines beginning with `$` and containing `$(var)` receive runtime substitution:

```mcfunction
# In a macro function file:
$scoreboard players set $(player) macro.some_obj $(value)
```

```mcfunction
# Called as:
function macro:some/fn with storage macro:input {}
# macro:input must contain: { player: "Steve", value: 5 }
```

> ⚠️ The `$` prefix is **only** valid on lines that contain at least one `$(var)`. Using `$` on a line with no variables causes a `No variables in macro` error.

> ⚠️ `execute function` subcommands **cannot** pass macro arguments. Use `with storage macro:input {}` on a top-level `function` call instead.
