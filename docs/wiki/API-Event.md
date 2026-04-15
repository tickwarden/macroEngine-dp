# 📡 Event System — `macro:event/*`

← [Home](Home)

---

## Overview

The event system allows any number of handler functions to be registered to a named event. When the event fires, all handlers run in registration order. Events decouple your systems — the emitter doesn't need to know who is listening.

---

## API

| Function | Input | Description |
|----------|-------|-------------|
| `event/register` | `{event, func}` | Register a handler function for an event |
| `event/fire` | `{event}` | Run all handlers registered to this event |
| `event/fire_as` | `{event, player}` | Fire with `event_context.player` pre-set |
| `event/fire_queued` | `{event, delay}` | Fire after `delay` ticks (deferred, no race condition) |
| `event/unregister` | `{event}` | Remove all handlers for an event |
| `event/unregister_one` | `{event, func}` | Remove a specific handler |
| `event/has` | `{event}` | Returns `result:1b` if event has any handlers |
| `event/count` | `{event}` | Returns `result` = handler count |
| `event/clear_context` | — | Clear `macro:engine event_context` |
| `event/list` | — | Show all registered events to `macro.debug` players |

---

## Usage Examples

### Register handlers

```mcfunction
# Multiple packs can register to the same event
data modify storage macro:input event set value "on_player_join"
data modify storage macro:input func set value "mypack:handlers/welcome_message"
function macro:event/register with storage macro:input {}

data modify storage macro:input func set value "mypack:handlers/check_ban"
function macro:event/register with storage macro:input {}
```

### Fire an event with context

```mcfunction
# Set context before firing — handlers can read it
data modify storage macro:engine event_context.player set value "Steve"
data modify storage macro:engine event_context.reason set value "login"

data modify storage macro:input event set value "on_player_join"
function macro:event/fire with storage macro:input {}
```

### Fire with context shortcut

```mcfunction
data modify storage macro:input event set value "on_player_join"
data modify storage macro:input player set value "Steve"
function macro:event/fire_as with storage macro:input {}
```

### Read context inside a handler

```mcfunction
# mypack:handlers/welcome_message.mcfunction
# Access event_context set by the emitter
execute store result storage macro:input player string 1 \
  run data get storage macro:engine event_context.player

tellraw @a [{"text":"Welcome, "},{"storage":"macro:engine","nbt":"event_context.player"}]
```

### Deferred event (fires after delay)

```mcfunction
data modify storage macro:input event set value "on_arena_start"
data modify storage macro:input delay set value 200
function macro:event/fire_queued with storage macro:input {}
# Fires after 200 ticks (10 seconds), no race condition with current tick
```

### PvP match end example

```mcfunction
# mypack:match/end.mcfunction
data modify storage macro:input event set value "mypack.match_end"
data modify storage macro:input player set value "Steve"
function macro:event/fire_as with storage macro:input {}

# Send all players to lobby after 5 seconds
data modify storage macro:input func set value "mypack:lobby/send_all"
data modify storage macro:input delay set value 100
function macro:lib/wait with storage macro:input {}
```

---

## Storage Layout

```
macro:engine
└── events
    └── on_player_join: [
          {func: "mypack:handlers/welcome_message"},
          {func: "mypack:handlers/check_ban"}
        ]
```
