# 🛡️ Admin Guide

← [Home](Home)

---

## Admin Tag

The `macro.admin` tag grants access to all privileged operations:

```mcfunction
# Grant admin
/tag <player> add macro.admin

# Revoke admin
/tag <player> remove macro.admin

# Check who has admin
/tag @a[tag=macro.admin] list
```

Admin players bypass all permission checks in `macro:perm/*`.

---

## Load Confirmation Gate

On `/reload` or world startup, macroEngine fires a confirmation gate **before** initializing storage. This prevents overwriting existing session data (permissions, cooldowns, wand binds, etc.).

```
# In server log / chat:
[AME] Reload detected. Run /function ame_load:load/yes to confirm.
      Auto-cancels in 5 minutes.

/function ame_load:load/yes   ← confirm
/function ame_load:load/no    ← cancel (storage untouched)
```

> The gate uses `marker` entity `say` output so it always appears in the server log even on headless/unattended servers.

---

## Dangerous Command Gate

Three destructive commands require explicit confirmation:

| Function | What it does | Gate functions |
|----------|-------------|----------------|
| `macro:cmd/ban` | Bans a player | `ame_load:gate/yes` / `gate/no` |
| `macro:cmd/ban_ip` | IP-bans a player | `ame_load:gate/yes` / `gate/no` |
| `macro:disable` | Disables macroEngine | `ame_load:gate/yes` / `gate/no` |

Auto-cancels after **30 seconds** if not confirmed.

---

## Debug Mode

Tag yourself with `macro.debug` to receive verbose output from list/debug functions:

```mcfunction
/tag @s add macro.debug
```

Debug functions:
```mcfunction
/function macro:debug            # dump engine state
/function macro:tools/admin/list # list all online admins
/function macro:flag/list_systems # show tick subsystem flags
/function macro:perm/list {player:"Steve"}
/function macro:event/list
/function macro:wand/list
/function macro:trigger/list
/function macro:log/show         # view log buffer
```

---

## Tick Subsystem Flags

macroEngine's tick loop is split into five independently-togglable subsystems:

| Flag name | `macro.Flags` key | Controls |
|-----------|------------------|---------|
| `time` | `#m_time` | Epoch counter, `$tick` increment |
| `queue` | `#m_queue` | `lib/process_queue`, `lib/schedule` |
| `player` | `#m_player` | Wand, interaction, trigger, perm dispatchers |
| `hud` | `#m_hud` | Auto progress bar (actionbar) |
| `admin` | `#m_admin` | Debug and admin systems |

Toggle a subsystem:
```mcfunction
/function macro:flag/toggle_system {system:"queue"}
/function macro:flag/list_systems
```

Or set directly:
```mcfunction
/scoreboard players set #m_hud macro.Flags 0   ← disable
/scoreboard players set #m_hud macro.Flags 1   ← enable
```

---

## Version Info

```mcfunction
/function macro:version
```

Displays engine version, load status, and build info.

---

## Disable / Cleanup

Full cleanup (removes all scoreboards, clears storage):

```mcfunction
/function macro:disable/main
```

> This goes through the dangerous command gate — confirm with `/function ame_load:gate/yes`.
