# 💬 Dialog System — `macro:dialog/*`

← [Home](Home)

---

## Overview

The dialog module provides in-game dialog UI using Minecraft's native `/dialog` command (1.21.6+). On older versions it falls back to `tellraw`-based output.

> **Availability:** Full dialog functionality requires Minecraft 1.21.6+ (pack_format ≥ 80, `1_21_6` overlay). On older versions, stub functions prevent `Unknown function` errors but dialogs will not display.

---

## API

| Function | Input | Description |
|----------|-------|-------------|
| `dialog/open` | `{dialog}` | Open a dialog for `@s` (with loading screen) |
| `dialog/show` | — | Show the queued dialog (called after `open`) |
| `dialog/load` | `{dialog}` | Queue a dialog for delayed display |
| `dialog/close` | — | Close the active dialog for `@s` |

---

## Log System — `macro:log/*`

The log system writes to an in-game circular buffer (max 30 entries). Displayed via `/dialog show` on 1.21.6+, via `tellraw` on older versions.

| Function | Input | Description |
|----------|-------|-------------|
| `log/add` | `{level, message, color}` | Add raw log entry |
| `log/info` | `{message}` | INFO level (green) |
| `log/warn` | `{message}` | WARN level (yellow) |
| `log/error` | `{message}` | ERROR level (red) |
| `log/debug` | `{message}` | DEBUG level (gray) |
| `log/show` | — | Display log buffer to `@s` |
| `log/clear` | — | Clear all log entries |

---

## Usage Examples

### Open a custom dialog

```mcfunction
# Define your dialog in: data/mypack/dialog/my_dialog.json
data modify storage macro:input dialog set value "mypack:my_dialog"
function macro:dialog/open with storage macro:input {}
```

### Log from your functions

```mcfunction
data modify storage macro:input message set value "Arena started successfully"
function macro:log/info with storage macro:input {}

data modify storage macro:input message set value "Player count too low"
function macro:log/warn with storage macro:input {}

# View the log
function macro:log/show
```

---

## Dialog File Format (1.21.6+)

Dialog JSON files go in `data/<namespace>/dialog/`. Example:

```json
{
  "type": "minecraft:dialog",
  "title": {"text": "My Dialog"},
  "body": [
    {
      "type": "minecraft:plain_message",
      "content": {"text": "Hello from macroEngine!"}
    }
  ],
  "buttons": [
    {
      "label": {"text": "Close"},
      "action": {
        "type": "minecraft:dialog_action/custom_click",
        "id": "mypack:close"
      }
    }
  ]
}
```

---

## Loading Screen Pattern

`dialog/open` uses a loading dialog + deferred `dialog/show` to avoid race conditions:

1. `dialog/open` — shows loading dialog, sets `macro.dialog_load` score
2. Each tick: checks `macro.dialog_load` score, decrements
3. When score reaches 0 → calls `dialog/show` with the queued dialog
4. `dialog/close` — clears `macro.dialog_opened` tag, adds `macro.dialog_closed` tag

This pattern prevents the "infinite loading" bug where closing a dialog button doesn't trigger `dialog/close`.

---

## Storage Layout

```
macro:engine
└── dialog
    └── DIALOG: "mypack:my_dialog"    ← queued dialog ID

macro:engine log_display              ← circular buffer
└── [{level:"INFO", message:"...", color:"green"}]
```

Scoreboard: `macro.dialog_load` — controls loading animation timing.
Tags: `macro.dialog_opened`, `macro.dialog_closed` — dialog lifecycle state.
