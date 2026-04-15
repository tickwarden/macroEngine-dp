# 🪄 Wand System — `macro:wand/*`

← [Home](Home)

---

## Overview

The `wand/` module binds functions or commands to right-click events on `carrot_on_a_stick` items (or any item) tagged with `minecraft:custom_data`. Multiple binds can be registered to the same tag — all run in sequence.

---

## API

| Function | Input | Description |
|----------|-------|-------------|
| `wand/register` | `{tag, func}` | Bind a function to the wand tag |
| `wand/register_cmd` | `{tag, cmd}` | Bind a command to the wand tag |
| `wand/unregister` | `{tag}` | Remove all binds for a tag |
| `wand/unregister_all` | — | Remove all wand binds |
| `wand/give` | `{player, tag, name}` | Give a wand to the player's mainhand |
| `wand/give_custom` | `{player, item, tag, name, count}` | Give a custom item as a wand |
| `wand/give_lore` | `{player, tag, name, lore, color}` | Give a wand with lore text |
| `wand/has` | `{player, tag}` | Check if player holds this wand → `macro:output result` |
| `wand/list` | — | Show all registered binds to `macro.debug` players |
| `wand/cooldown_set` | `{player, tag, duration}` | Apply a cooldown to a wand |
| `wand/cooldown_check` | `{player, tag}` | Check if wand cooldown is active → `macro:output result` |

---

## Usage Example

```mcfunction
# Register a wand
data modify storage macro:input tag set value "mypack.magic_wand"
data modify storage macro:input func set value "mypack:wand/cast_spell"
function macro:wand/register with storage macro:input {}

# Give the wand to a player
data modify storage macro:input player set value "Steve"
data modify storage macro:input tag set value "mypack.magic_wand"
data modify storage macro:input name set value "Magic Wand"
function macro:wand/give with storage macro:input {}
```

Inside the handler, `@s` is the player who right-clicked:

```mcfunction
# mypack:wand/cast_spell.mcfunction
particle minecraft:end_rod ~ ~1 ~ 0.3 0.3 0.3 0.05 20
playsound minecraft:entity.enderman.teleport player @s ~ ~ ~ 1 1.5
```

---

## Wand with Cooldown

```mcfunction
# Check cooldown before casting
data modify storage macro:input player set value "Steve"
data modify storage macro:input tag set value "mypack.magic_wand"
function macro:wand/cooldown_check with storage macro:input {}
execute if data storage macro:output {result:0b} run return 0  # on cooldown

# Cast and set 5-second cooldown
function mypack:wand/do_cast
data modify storage macro:input player set value "Steve"
data modify storage macro:input tag set value "mypack.magic_wand"
data modify storage macro:input duration set value 100
function macro:wand/cooldown_set with storage macro:input {}
```

---

## Storage Layout

```
macro:engine
└── wand_binds
    └── [{tag:"mypack.magic_wand", func:"mypack:wand/cast_spell"}]
```

Scoreboard: `macro.rightClick` (`minecraft.used:minecraft.carrot_on_a_stick`)  
Tick: `macro:tick/player_systems` → `wand/internal/tick_scan`

---

## Notes

- Default item is `carrot_on_a_stick`. Use `wand/give_custom` for other item types.
- `wand/unregister` — the public wrapper has no `$(var)` so it appears in tab-complete. The actual macro impl is in `internal/unregister_exec`.
- For wands with lore, use `wand/give_lore` — direct `lore_add`/`lore_remove` are not supported (removed in v2.1.2).
