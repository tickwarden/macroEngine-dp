# 🎣 Hook System — `macro:hook/*`

← [Home](Home)

---

## Overview

The hook system lets you register functions to run automatically when specific in-game events occur (block break, item use, player death, etc.).

Hooks are implemented as **advancement triggers** — when the advancement fires, macroEngine calls all registered handler functions.

---

## API

| Function | Input | Description |
|----------|-------|-------------|
| `hook/register` | `{event, func}` | Register a handler for a hook event |
| `hook/unregister` | `{event, func}` | Remove a specific handler |
| `hook/reset_all` | — | Remove all registered hook binds |
| `hook/list` | — | Show registered binds to `macro.debug` players |

---

## Available Hook Events

| Event name | Trigger |
|------------|---------|
| `break_block` | Player breaks a block |
| `placed_block` | Player places a block |
| `eat_food` | Player eats food |
| `entity_kill` | Player kills an entity |
| `player_death` | Player dies |
| `fish_caught` | Player catches a fish |
| `trade` | Player trades with a villager |
| `item_use` | Player uses an item |
| `interact_anvil` | Player interacts with an anvil |
| `interact_shulker_box` | Player interacts with a shulker box |
| `dimension_change` | Player changes dimension |
| `killed_by_arrow` | Player is killed by an arrow |
| `hero_of_the_village` | Player receives Hero of the Village |
| `advancement:<id>` | Custom advancement fires |

---

## Usage Example

```mcfunction
# Register a handler for block breaks
data modify storage macro:input event set value "break_block"
data modify storage macro:input func set value "mypack:handlers/on_break"
function macro:hook/register with storage macro:input {}

# Register a death handler
data modify storage macro:input event set value "player_death"
data modify storage macro:input func set value "mypack:handlers/on_death"
function macro:hook/register with storage macro:input {}
```

Inside the handler function, `@s` is the player who triggered the event:

```mcfunction
# mypack:handlers/on_break.mcfunction
tellraw @s {"text":"You broke a block!", "color":"yellow"}
```

---

## Custom Advancement Hook

```mcfunction
# Register a handler for a custom advancement
data modify storage macro:input event set value "advancement:mypack:my_achievement"
data modify storage macro:input func set value "mypack:handlers/on_achievement"
function macro:hook/register with storage macro:input {}
```

The advancement must call `macro:hook/internal/on_advancement_fire` in its reward function.

---

## Placed Block Hook (with Raycast)

The `placed_block` hook additionally populates `macro:engine event_context` with block placement data via raycast:

| Context field | Content |
|---------------|---------|
| `event_context.player` | Player name |
| `event_context.block_pos` | `{x, y, z}` of placed block |

Access in your handler:

```mcfunction
# mypack:handlers/on_place.mcfunction
data get storage macro:engine event_context.block_pos
```
