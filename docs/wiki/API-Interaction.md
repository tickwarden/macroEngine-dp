# 🖱️ Interaction Entity System — `macro:interaction/*`

← [Home](Home)

---

## Overview

The `interaction/` module allows you to create invisible `minecraft:interaction` entities and bind functions to left-click (attack) or right-click (use) events. Multiple binds can be registered to the same tag — all run in sequence.

---

## API

### Public Functions

| Function | Input | Description |
|----------|-------|-------------|
| `interaction/spawn` | `{tag, width, height, response}` | Spawn an interaction entity with the given tag and dimensions |
| `interaction/bind_attack` | `{tag, func}` | Bind a function to left-click (attack) on entities with this tag |
| `interaction/bind_use` | `{tag, func}` | Bind a function to right-click (use) on entities with this tag |
| `interaction/unbind_attack` | `{tag, func}` | Remove a specific attack bind |
| `interaction/unbind_use` | `{tag, func}` | Remove a specific use bind |
| `interaction/list` | `{tag}` | Show all binds for a tag to `macro.debug` players |
| `interaction/remove` | `{tag}` | Remove all binds and kill all entities with this tag |

---

## Usage Example

```mcfunction
# Spawn a 1×2 interaction entity tagged "door_button"
data modify storage macro:input tag set value "door_button"
data modify storage macro:input width set value 1.0f
data modify storage macro:input height set value 2.0f
data modify storage macro:input response set value 0b
function macro:interaction/spawn with storage macro:input {}

# Bind a function to right-click
data modify storage macro:input tag set value "door_button"
data modify storage macro:input func set value "mypack:door/open"
function macro:interaction/bind_use with storage macro:input {}

# Bind a function to left-click
data modify storage macro:input tag set value "door_button"
data modify storage macro:input func set value "mypack:door/close"
function macro:interaction/bind_attack with storage macro:input {}
```

Inside the handler, `@s` is the player who clicked:

```mcfunction
# mypack:door/open.mcfunction
setblock ~ ~1 ~ minecraft:air
tellraw @s {"text":"Door opened!", "color":"green"}
```

---

## Internal Architecture

Tick scan runs every tick via `macro:tick/player_systems`:

```
tick/player_systems
  └── interaction/internal/tick_scan
        ├── for each interaction entity with attack NBT → on_attack → dispatch → check_bind → fire
        └── for each interaction entity with use NBT   → on_use   → dispatch → check_bind → fire
```

Storage: `macro:engine interaction_binds [{tag:"...", type:"attack"|"use", func:"..."}]`

---

## Notes

- `response:0b` — interaction entity makes no sound when clicked
- `response:1b` — plays the standard interaction sound
- The tick scan checks `interaction` NBT for pending attack/use events and clears them after dispatch
- Entities are identified by their `macro_ie_tag` custom tag (set automatically by `interaction/spawn`)
