# 🔒 Permission System — `macro:perm/*`

← [Home](Home)

---

## Overview

The permission system provides a two-tier access control layer:
- **Storage** (`macro:engine permissions`) — persistent, works for offline players
- **Entity tag** (`perm.<name>`) — runtime fast lookup (online players only)

`macro.admin` tag always bypasses all permission checks.

---

## Core API

| Function | Input | Description |
|----------|-------|-------------|
| `perm/grant` | `{player, perm}` | Grant permission — writes to storage + adds entity tag |
| `perm/revoke` | `{player, perm}` | Revoke permission — clears storage + removes entity tag |
| `perm/clear` | `{player}` | Remove all permissions for a player |
| `perm/has` | `{player, perm}` | Returns `macro:output {result:1b/0b}` |
| `perm/check` | `{player, perm}` | Guard — `return 0` if no permission |
| `perm/run` | `{player, perm, cmd}` | Run command if player has permission (entity tag, online) |
| `perm/exec` | `{player, perm, cmd}` | Run command if player has permission (storage, offline-safe) |
| `perm/list` | `{player}` | Display permission list to `macro.debug` players |

> `grant`, `revoke`, `clear` can only be called by players with the `macro.admin` tag.

---

## Usage Examples

```mcfunction
# Grant a permission
data modify storage macro:input player set value "Steve"
data modify storage macro:input perm set value "mypack.open_shop"
function macro:perm/grant with storage macro:input {}

# Check permission (guard)
data modify storage macro:input player set value "Steve"
data modify storage macro:input perm set value "mypack.open_shop"
execute unless function macro:perm/check run return 0
# ... rest of function only runs if Steve has the permission

# Check permission (query)
function macro:perm/has with storage macro:input {}
execute if data storage macro:output {result:1b} run function mypack:shop/open
```

---

## Permission-Protected Triggers — `perm/trigger/*`

Allows players to use `/trigger <name> set <value>` — macroEngine performs the permission check before running the bound function.

| Function | Input | Description |
|----------|-------|-------------|
| `perm/trigger/bind` | `{name, value, func, perm}` | Bind trigger value to function with permission requirement |
| `perm/trigger/bind_cmd` | `{name, value, cmd, perm}` | Bind trigger value to command with permission requirement |
| `perm/trigger/enable` | `{player, name, perm}` | Enable trigger for a player (with permission check) |
| `perm/trigger/unbind` | `{name, value}` | Remove all binds for a specific value |
| `perm/trigger/clear` | `{name}` | Remove all binds for a trigger |

```mcfunction
# Setup: bind trigger value 1 to open the shop, requiring "mypack.shop" permission
data modify storage macro:input name set value "mypack_actions"
data modify storage macro:input value set value 1
data modify storage macro:input func set value "mypack:shop/open"
data modify storage macro:input perm set value "mypack.shop"
function macro:perm/trigger/bind with storage macro:input {}

# Enable for a player
data modify storage macro:input player set value "Steve"
data modify storage macro:input name set value "mypack_actions"
data modify storage macro:input perm set value "mypack.shop"
function macro:perm/trigger/enable with storage macro:input {}
```

Player usage:
```
/trigger mypack_actions set 1
```

If Steve has `mypack.shop` permission → `mypack:shop/open` runs.  
If not → error message shown to Steve.

---

## Storage Layout

```
macro:engine
├── permissions
│   └── Steve: ["mypack.open_shop", "mypack.admin"]
│
├── perm_triggers
│   └── mypack_actions: [{value:1, func:"mypack:shop/open", perm:"mypack.shop"}]
│
└── perm_trigger_names
    └── [{name:"mypack_actions"}]
```
