# Advanced Macro Engine -- Changelog

---

## v2.1.2 -- 2026-03-21

### New: Extended `hook/` System

Added new events alongside the existing `player_join`, `player_death`, `player_respawn`, `level_up`, `block_place`:

| Event | Detection method | Notes |
|---|---|---|
| `block_break` | `item_durability_changed` advancement | Tool-based only; hand-breaking not detectable |
| `item_use` | `using_item` advancement | -- |
| `entity_kill` | `player_killed_entity` advancement | -- |
| `using_item` | `item_durability_changed` advancement | Shares advancement with `block_break` |
| `killed_by_arrow` | `entity_killed_player` + `killing_blow: arrow` | -- |
| `hero_of_the_village` | `hero_of_the_village` advancement | -- |
| `sneak_start` / `sneak_stop` | `macro:is_sneaking` predicate + tick_scan | -- |
| `sprint_start` / `sprint_stop` | `macro:is_sprinting` predicate + tick_scan | -- |
| `elytra_start` / `elytra_stop` | `macro:is_gliding` predicate + tick_scan | -- |

New scoreboards: `macro.hook_sneak`, `macro.hook_sprint`, `macro.hook_elytra`, `macro.hook_tool_used`, `macro.hook_item_used`, `macro.hook_entity_killed`, `macro.hook_using_item`, `macro.hook_killed_by_arrow`, `macro.hook_hero_of_the_village`, `macro.hook_lvl_new`

### Bug Fixes

#### `hook/internal/tick_scan` -- `on_join` never fired for new players
`macro.hook_online` is `null` for a player who has never joined before. `scores={macro.hook_online=0}` does not match `null`. Changed to `scores={macro.hook_online=..0}` to catch both `null` and `0`.

#### `hook/internal/tick_scan` -- `sneak/sprint/elytra` never fired for new players
Same `null` vs `0` issue. Fixed for all three event pairs with `scores={..0}`.

#### `ame_load/load/scoreboards` -- wrong criteria for `hook_deaths`
`minecraft.custom:minecraft.deaths` is not valid in 1.21.x. Changed to `deathCount`.

#### `hook/internal/check_level_up` -- new XP level was unreadable by handlers
When `on_level_up` fired, the new XP level was stored in `$hlvl_cur macro.tmp` (a fake-entity score) which handlers cannot read. The new level is now copied to `@s macro.hook_lvl_new` (per-player) before the hook fires.

#### `advancement/hook/*.json` -- missing `parent` field
All hook advancements were treated as independent advancement trees because they had no `parent`. `/advancement revoke @s everything` traverses from a root and therefore skipped them. Added `"parent": "macro:hidden/root"` to all hook advancements.

#### `advancement/hook/item_craft.json` -- `recipe_crafted` trigger invalid in 1.21.11
`minecraft:recipe_crafted` requires `recipe_id` in 1.21.11; a generic "any craft" advancement cannot be defined. File, related scoreboard, and `tick_scan` lines removed.

#### `ame_load/load/scoreboards` -- online players re-triggered on `/reload`
After `macro.hook_online` is created, existing players had no score (treated as `0`) and were fired as new joins on every reload. Added `scoreboard players set @a macro.hook_online 1` immediately after the objective is created.

### Removed

- `advancement/hook/item_craft.json` -- incompatible with 1.21.11

---

## v2.1.1 -- 2026-03-19

### New Module: `wand/`

Right-click wand system based on `carrot_on_a_stick`. Items tagged with `minecraft:custom_data` can have functions or commands bound to them; multiple binds per tag are supported.

#### Public Functions

| Function | Input | Description |
|---|---|---|
| `wand/register` | `{tag, func}` | Bind a function to a tag |
| `wand/register_cmd` | `{tag, cmd}` | Bind a command to a tag |
| `wand/unregister` | `{tag}` | Remove all binds for a tag |
| `wand/unregister_all` | -- | Clear all wand binds |
| `wand/give` | `{player, tag, name}` | Give a wand to the player's mainhand |
| `wand/give_custom` | `{player, item, tag, name, count}` | Give a wand with a custom item type |
| `wand/give_lore` | `{player, tag, name, lore, color}` | Give a wand with lore via `item replace` |
| `wand/has` | `{player, tag}` | Check if player holds a specific wand → `macro:output result` |
| `wand/list` | -- | Show registered binds to `macro.debug` players |
| `wand/cooldown_set` | `{player, tag, duration}` | Apply a cooldown to a wand |
| `wand/cooldown_check` | `{player, tag}` | Check if cooldown is active → `macro:output result` |

Storage: `macro:engine wand_binds [{tag:"...", func/cmd:"..."}]`
Tick: `macro:tick/player_systems` → `wand/internal/tick_scan`
Scoreboard: `macro.rightClick` (`minecraft.used:minecraft.carrot_on_a_stick`)

#### Note: `wand/unregister` tab-complete
Because the macro impl contains `$(`, Minecraft hid `wand/unregister` from `/function` tab-complete. The macro impl was moved to `internal/unregister_exec`; the public wrapper no longer contains `$(` and is visible in the list.

#### `give` / `give_custom` -- overlay cleanup
1.21.5+ uses JSON object format for `item_name`. The `1_21_5` and `1_21_6` overlay files were removed; base functions were upgraded to the 1.21.5+ format directly. A `compat_1_21_4` overlay with the old `'` string syntax was added for 1.21.4 and below.

### Bug Fixes

#### `ame_load/load/internal/validate` -- version mismatch on every reload
First line wrote `{version:"v2.1.1-pre1"}` but the stored value from a previous world was never cleared, causing a mismatch and aborting load on every `/reload`. Fixed: changed `v2.1.1-pre1` to `v2.1.1` and added `data modify storage macro:engine global.version set value "v2.1.1"` so the version is always overwritten on load regardless of existing storage.

#### `ame_load/load/internal/version_set` -- double space parse error
`scoreboard players set #ame.pre  ame.pre_version` had a double space which caused `Expected integer` in the command parser. Reduced to a single space.

#### `cmd/data_remove_block`, `cmd/data_remove_entity`, `cmd/data_remove_storage` -- invalid macro line
The final `$tellraw` lines contained no `$(...)` variable. Minecraft requires every `$`-prefixed line to contain at least one `$(var)`. Removed `$` prefix and improved debug output to include relevant arguments.

#### `cmd/save-all`, `cmd/save-off`, `cmd/save-on`, `cmd/stop` -- parse error in singleplayer
These commands are not recognised by the command dispatcher in singleplayer, producing `Unknown command` on load. Rewritten to run through `cmd/other/run_self` macro wrapper, which is not parsed at load time.

#### `wand/internal/unregister_exec` -- `$` prefix on a line with no `$(var)`
Line 11 had `$data modify storage macro:engine _wand_unbinds ...` with no `$(var)`. Removed `$`.

### Removed

- `wand/lore_add`, `wand/lore_remove` and all related internal files (`lore_add_exec`, `lore_remove_exec`, `lore_rebuild_step`, `lore_rebuild_apply`) -- did not work because `set_lore` item function has no NBT source support. Replaced by `wand/give_lore`.
- `item_modifier/wand_lore_append.json`, `item_modifier/wand_lore_clear.json`
- `1_21_5` and `1_21_6` overlay copies of `wand/give.mcfunction`, `wand/give_custom.mcfunction`

---

### New: `engine/call/execute_validated`

Two-file module that executes a function after it passes `macro:tools/utils/input_check` security validation.

| File | Role |
|---|---|
| `engine/call/execute_validated.mcfunction` | Calls the macro sub-function from `macro:output.inputs` storage |
| `engine/call/execute_validated/run.mcfunction` | `$function $(func) with storage macro:input {}` -- macro wrapper |

The commented-out call in `input_check.mcfunction` line 140 was activated. This also fixes the CI `FAILED: One or more function references point to non-existent files` error.

---

### New: `cmd` Support for the Scheduler

`lib/schedule`, `lib/queue_add`, and related internals previously only accepted a `func` (function name). Raw Minecraft commands (`cmd`) can now be passed to the scheduler through the same API.

#### New Public Functions

| Function | Input | Description |
|---|---|---|
| `lib/schedule_cmd` | `{key, cmd, interval}` | Repeating command scheduler -- same semantics as `lib/schedule` |
| `lib/queue_add_cmd` | `{cmd, delay}` | Add a one-shot delayed command to the queue |
| `lib/wait_cmd` | `{cmd, delay}` | Alias for `queue_add_cmd` |
| `lib/once_cmd` | `{key, cmd}` | Run a command only once per key |
| `lib/debounce_cmd` | `{key, cmd, interval}` | Do not start a new scheduler if one is already active |
| `lib/schedule_if_cmd` | `{cmd, delay}` | Alias for `queue_add_cmd` |

#### Changed Internal Functions

| File | Change |
|---|---|
| `lib/internal/queue_fire` | Added `func` and `cmd` dispatch -- both run from the same queue |
| `lib/internal/queue_run_cmd` | NEW -- `$$(cmd)` raw command runner |
| `lib/internal/schedule_requeue_cmd` | NEW -- re-queues a `cmd` entry |
| `lib/internal/schedule_reset_do_cmd` | NEW -- resets and re-queues a `cmd` scheduler |
| `lib/schedule_renew` | Routes to the correct `requeue` function based on `func` or `cmd` |
| `lib/schedule_reset` | Routes to the correct `reset_do` function based on `func` or `cmd` |

### Removed

- `1_21_5/data/macro/function/dialog/` -- incorrectly created in a previous version. The dialog system is exclusive to the `1_21_6` overlay (pack_format ≥ 80, Minecraft 1.21.6+).

---

## v2.1.0 -- 2026-03-18

### Bug Fixes

#### `tools/utils/input_check` -- version check always failed
Comparison used `V2.0.3` (uppercase V) but the engine stores `v2.0.3` (lowercase v). The check always failed, bypassing all injection protection. Fixed to `v2.1.2`.

#### `tools/utils/input_check` -- `execute_validated` call was missing
After passing the validation block, `function macro:engine/call/execute_validated` was never called, so the command was never executed. Call added. Cleanup lines (`data remove storage macro:output`) moved to after this call.

### New: `tools/utils/check_all`

Combined guard that chains all guard checks in a single line:

```mcfunction
execute unless function macro:tools/utils/check_all run return 0
```

Internal flow: `load_check` → `perm_check` → `timer_check`. Stops at the first failure.

### New: `tools/admin/list`

Lists all online players with the `macro.admin` tag to `@s`. Protected by the `check_all` guard.

### Security: Additional Guards on Dangerous Commands

`op`, `ban`, `ban_ip`, `kick`, `deop`, `pardon`, `pardon_ip`, `stop`, `whitelist`, `data_remove_block`, `data_remove_entity`, `data_remove_storage`, `save-all`, `save-off`, `save-on` now require all three conditions:

| Guard | Condition |
|---|---|
| `@s[type=minecraft:player]` | Executor must be a player |
| `dimension minecraft:overworld` | Overworld only |
| `@s[gamemode=creative]` | Executor must be in creative mode |

Any failure cancels with `return 0`.

---

## v2.0.3 -- 2026-03-14

### New: `macro:version`

`/function macro:version` shows AME version info to the calling player.

- All version numbers read dynamically from the `ame.pre_version` scoreboard -- no hardcoding
- `-preN` suffix is shown only when `#ame.pre >= 1`; hidden for release builds
- Author / Source lines include clickable links via `click_event` (1.21.5+ overlays)
- Load status (`● loaded` / `✖ not initialized`) shown by checking `#ame.ver_set`

| Layer | File | click format |
|---|---|---|
| Base | `data/macro/function/version.mcfunction` | None |
| `compat_1_21_4` | `compat_1_21_4/data/macro/function/version.mcfunction` | None |
| `1_21_5` | `1_21_5/data/macro/function/version.mcfunction` | `click_event` + `url` |
| `1_21_6` | `1_21_6/data/macro/function/version.mcfunction` | `click_event` + `url` |

### New Module: `uuid/`

Full UUID infrastructure that converts entity UUIDs to `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` hex string format. Java's negative integer division bug (`truncate` instead of `floor`) is corrected manually -- the high-byte calculation error present in other implementations does not exist here.

#### Public Functions

| Function | Input | Output | Description |
|---|---|---|---|
| `uuid/from_entity` | -- (as `<entity>`) | `macro:input value` | Converts `@s` UUID to hex string |
| `uuid/from_array` | `{arr:[I;…]}` | `macro:input value` | Converts int[4] UUID array to hex string |
| `uuid/store` | `{key, value}` | -- | Saves UUID string to cache |
| `uuid/recall` | `{key}` | `macro:input value` | Reads UUID string from cache |
| `uuid/recall_array` | `{key}` | `macro:input arr` | Reads UUID from cache as int[4] |
| `uuid/match` | `{value, func}` | -- | Compares `@s` UUID with `value`; runs `func` if matched |
| `uuid/has` | `{key}` | `macro:output result` | Checks if key exists in cache (`1b`/`0b`) |
| `uuid/forget` | `{key}` | -- | Removes a single entry from cache |
| `uuid/cache_clear` | -- | -- | Clears the entire UUID cache |

Storage: `macro:engine uuid_cache {key: "uuid-string"}` · `macro:uuid hex_chars [...]` (256-entry lookup table)

### New Functions

#### `math/lerp_clamped`
Lerp with `t` clamped to `[0, 100]`. Unlike `lerp`: `t < 0` → `0`, `t > 100` → `100`.

#### `cooldown/extend`
Extends an active cooldown's expiry by `amount` ticks. If no cooldown is active, starts a new one for `amount` ticks.

| Input | Description |
|---|---|
| `{player, key, amount}` | Current expiry + `amount` → new expiry |

#### `state/toggle`
Toggles the `player` key between `on` and `off` values.

| Input | Output |
|---|---|
| `{player, on, off}` | `macro:output result` (new value) |

#### `event/fire_as`
Fires an event with `event_context.player` set to `player`. Shorthand for setting context manually before calling `event/fire`.

#### `string/format_ticks`
Converts a tick count to minutes + seconds (a simpler version of `ticks_to_time` without hours).

#### `player/get_dimension`
Returns the player's current dimension (`minecraft:overworld`, `minecraft:the_nether`, `minecraft:the_end`).

### New Assets

| Type | File |
|---|---|
| Advancement templates | `advancement/template/task.json`, `goal.json`, `challenge.json` |
| Item modifier | `item_modifier/set_custom_model_data.json`, `strip_enchants.json` |
| Loot table | `loot_table/template/tiered_drop.json` |
| Predicate | `predicate/is_holding_shield.json` |

### Bug Fixes

#### `all.mcfunction`, `finalize.mcfunction` -- hardcoded version strings
`"[Macro Engine v2.0.3]"` / `"v2.0.3"` hardcoded tellraw text converted to score-based `#ame.major/minor/patch`. `-preN` suffix added when `#ame.pre >= 1`.

#### `version_warn.mcfunction` (base) -- wrong pre number
Debug tellraw said `(expected: 2 0 3 pre=3)`. Fixed to `pre=4`.

#### `validate.mcfunction` -- `#ame.pre matches 0` mismatch
The `#ame.pre` check line read `matches 0` which triggered a version mismatch on every `/reload` in pre-release builds. Fixed to `matches 4`.

#### `compat_1_21_4/version.mcfunction` -- `click_event` not supported in 1.21.4
Author / Source lines incorrectly had `click_event` (`click_event` is 1.21.5+ only). Links removed, plain text retained.

#### `version_warn.mcfunction` (`compat_1_21_4`, `1_21_6`) -- wrong pre number
Debug tellraw said `(expected: 2 0 3 pre=2)`. Fixed to `pre=4`.

### Changes

- **Comment cleanup:** The majority of Turkish comment blocks across all `.mcfunction` files removed -- file size and readability improved.
- **Overlay rename:** `-1_21_4` → `compat_1_21_4`; all workflow references and `pack.mcmeta` updated.
- **`1_21_6/dialog/internal/load_exec`** removed; content inlined into `dialog/load.mcfunction`.
- **`pack.mcmeta`:** `supported_formats` changed from array format to `min_format`/`max_format` object format.

---

## v2.0.3-pre3 -- 2026-03-14

### New Module: `interaction/`

Listens to left-click (attack) and right-click (use) events on `minecraft:interaction` entities. Multiple binds per tag are supported; all run in order.

#### Public Functions

| Function | Input | Description |
|---|---|---|
| `interaction/spawn` | `{tag, width, height, response}` | Spawns an interaction entity with the given tag, size, and sound settings |
| `interaction/bind_attack` | `{tag, func}` | Binds an attack event to entities with the tag -- runs as the attacking player |
| `interaction/bind_use` | `{tag, func}` | Binds a use event to entities with the tag -- runs as the using player |
| `interaction/unbind_attack` | `{tag, func}` | Removes a specific attack bind |
| `interaction/unbind_use` | `{tag, func}` | Removes a specific use bind |
| `interaction/list` | `{tag}` | Shows all binds for a tag to `macro.debug` players |
| `interaction/remove` | `{tag}` | Removes all binds and entities for a tag |

Storage: `macro:engine interaction_binds [{tag:"...", type:"attack"|"use", func:"..."}]`

Changes: `tick/player_systems` updated in all overlays; `load/storages` and `load/internal/cleanup` updated.

---

## v2.0.3-pre2 -- 2026-03-13

### Bug Fixes

#### `lib/schedule` -- timer auto-reset on re-call
**Previous behavior:** Re-calling `schedule` with the same key only updated `func` and `interval` without resetting the timer. Manual `schedule_cancel` was required first.

**New behavior:** Re-calling `schedule` with the same key automatically cancels the old schedule and starts a new one with the full interval.

#### Comment translation -- all Turkish to English
All Turkish comments, documentation strings, and error messages in `.mcfunction` files translated to English.

Files affected: 150+ `.mcfunction` files across all namespaces.

#### Namespace correction -- `mopenro` → `macro`
Incorrect namespace references introduced during translation fixed. All `mopenro.*` tags, scoreboards, and storage paths corrected to `macro.*`.

Total corrections: 401 lines across 68 files.

---

## v2.0.3-pre1 -- 2026-03-11

### New Functions

| Function | Input | Output | Description |
|---|---|---|---|
| `cooldown/detail` | `{player, key}` | `{active:1b/0b, remaining:<int>, expires:<int>}` | `cooldown/check` + `cooldown/remaining` + expiry tick in a single call |
| `lib/ticks_to_time` | `{ticks:<int>}` | `{hours, minutes, seconds, ticks}` | Splits tick count into components; negative inputs treated as zero |
| `math/divmod` | `{value, divisor}` | `{quotient, remainder}` | Returns division and remainder in one pass; remainder always in `[0, divisor)` |
| `math/minmax` | `{a, b}` | `{min, max}` | Returns minimum and maximum in a single scoreboard pass |
| `player/get_pos` | `{player}` | `{x, y, z, found:1b/0b}` | Returns player's block coordinates; `found:0b` if offline |

### Bug Fixes

- **PID targeting:** `$execute store result` failure left `macro.tmp` at its previous value. Added `scoreboard players set $*_pid macro.tmp 0` to every pid resolve block.
- **`debug.mcfunction`:** Added missing storage fields `engine.flags`, `engine.config`, `input`, `output`.
- **`lib/throttle`:** Fixed inconsistency in throttle logic.
- **`cmd/other/multi_cmd/run`, `run_func`:** Fixed error during multi-command execution.
- **`flag/list`, `flag/list_systems`, `event/list`, `perm/list`, `state/list`, `trigger/list`, `log/show`:** Updated display format.

---

## v2.0.2 -- 2026-03-11

### New: Player PID System

Duplicate-name safe unique integer ID infrastructure. For offline-mode servers where multiple players may share the same name, `macro.pid` scoreboard-based targeting replaces `@a[name=$(player),limit=1]`.

| Component | Description |
|---|---|
| `player/internal/assign_pid` | Runs once per player on first `player/init` call; writes unique integer to `player_pids.<n>` storage and `macro.pid` score |
| `macro:engine player_pids` | `{name: pid}` map storage -- persists across reload |
| `macro:engine _pid_seq` | Monotonically increasing sequence counter -- persists across reload |
| `macro.pid` (scoreboard) | Per-entity PID score for runtime targeting |

### Bug Fixes

#### `math/random` -- distribution bias
The previous `abs()` step mapped both `x` and `-x` to the same residue class, under-representing values near 0 by ~50%. `abs()` removed; signed-modulo fix `(rnd % range + range) % range` applied -- distribution is now unbiased across `[min, max]`.

All `perm/*` functions updated to use PID-based targeting.

---

## v2.0.1 -- 2026-03-11

### Bug Fixes

#### `1_21_6/tick/player_systems` -- `perm/trigger` dispatch missing
`perm/trigger/internal/tick_start` was added to base `tick/player_systems` but not to the `1_21_6` override. Since the overlay completely shadows the base file for 1.21.6+, the `perm/trigger` system never fired on those versions. Line added to `1_21_6/tick/player_systems.mcfunction`.

#### `perm/trigger/internal/tick_dispatch` -- first-time players not getting trigger enabled
`$execute as @a[scores={$(name)=1..}]` only ran for players whose score was already `1` or above. Players with no score never received `scoreboard players enable`. Added `$execute as @a run scoreboard players enable @s $(name)` -- all players get enabled every tick.

#### Version references updated
All `v2.0.0` references in `load/all`, `finalize`, `validate`, `version_set`, `version_warn` updated to `v2.0.1`. `#ame.patch` scoreboard value corrected from `0` to `1`.

---

## v2.0.0 -- 2026-03-10

### New Module: `perm/` -- Permission System

Complete permission layer for managing player permissions. Two-tier architecture: **storage** (persistent, including offline) + **entity tag** (fast runtime access). `macro.admin` tag bypasses all permissions.

#### Core Functions

| Function | Input | Description |
|---|---|---|
| `perm/grant` | `{player, perm}` | Grant permission -- storage + tag |
| `perm/revoke` | `{player, perm}` | Revoke permission -- clear storage + tag |
| `perm/clear` | `{player}` | Clear all permissions |
| `perm/has` | `{player, perm}` | Permission check → `macro:output {result:1b/0b}` |
| `perm/check` | `{player, perm}` | Guard -- returns `0` if no permission |
| `perm/run` | `{player, perm, cmd}` | Run a permitted command (entity tag based, online only) |
| `perm/exec` | `{player, perm, cmd}` | Run a permitted command (storage based, includes offline) |
| `perm/list` | `{player}` | Show permission list to `macro.debug` players |

`grant`, `revoke`, `clear` can only be called by players with the `macro.admin` tag.

`perm/run` vs `perm/exec`: `run` checks entity tag (fast), `exec` checks storage (reliable, works offline).

### New Sub-system: `perm/trigger/` -- Permission-Protected Named Triggers

Allows players to write `/trigger <n> set <value>`; performs a permission check in the background before running the bound function or command. Permission-layered extension of the `macro_action` system.

| Function | Input | Description |
|---|---|---|
| `perm/trigger/bind` | `{name, value, func, perm}` | Bind a trigger value to a function |
| `perm/trigger/bind_cmd` | `{name, value, cmd, perm}` | Bind a trigger value to a command |
| `perm/trigger/enable` | `{player, name, perm}` | Enable a trigger for a player (with permission check) |
| `perm/trigger/unbind` | `{name, value}` | Remove all binds for a specific value |
| `perm/trigger/clear` | `{name}` | Clear all binds for a trigger |

Storage: `macro:engine perm_triggers.<n> [{value:N, func/cmd:"...", perm:"..."}]`

Tick dispatch: `tick/player_systems` → `perm/trigger/internal/tick_start` → `tick_step_loop` → `tick_dispatch` → `player_dispatch` → `check_bind` → `run_if_perm` → `exec`

### Bug Fixes

- **`perm/list` line 16:** Spurious `$` prefix on a `tellraw` with no `$(...)`. Removed.
- **`perm/trigger/internal/run_if_perm` line 14:** Same spurious `$` prefix. Removed.
- **`perm/trigger/internal/tick_step_loop`:** Trailing `{}` on `function ... with storage` was invalid syntax. Removed.

### Changes

- `tick/player_systems.mcfunction`: `perm/trigger/internal/tick_start` dispatch added
- `load.mcfunction`: `perm_triggers`, `perm_trigger_names`, `permissions` storage init added
- `disable/main.mcfunction`: cleanup for `perm_triggers`, `perm_trigger_names`, `permissions` added

---

## v1.0.6-pre3 -- 2026-03-06

### Bug Fixes

#### `-1_21_4` / `1_21_6` overlay `tick.mcfunction` -- flag system disabled
Both overlays contained the old monolithic `tick.mcfunction` which completely overrode the flag-controlled base. For 1.21.1 users (pack_format 48, `-1_21_4` active), `macro.Flags` was never read -- toggle appeared to work but systems were unaffected. Both overlays updated to the flag-controlled structure. The `1_21_6`-specific `dialog_load` logic moved to a `1_21_6/tick/player_systems` override.

#### `flag/toggle_system` -- `$ftgl_sys` macro variable collision
`$ftgl_sys` starts with `$`, so it was parsed as a `$(ftgl_sys)` macro variable inside a macro line, making `scoreboard players operation` always write 0. Toggle always set to 1. Fixed to `#ftgl_sys`.

#### `flag/toggle_system` -- `tellraw` fired before `set`
`tellraw` was between the two `set` lines; on a 0→1 transition the first `tellraw` read the old (0) value and the second read 1, producing two messages. Both `set` lines moved before `tellraw`.

#### `flag/toggle_system` -- double-execute race condition
Two sequential `execute if score` lines meant that after setting 1→0, the `matches 0` branch immediately fired and set it back to 1. Fixed by first copying the current score to `#ftgl_sys macro.tmp` so only one branch runs.

### New: Flag-Controlled Tick System

`macro:tick` split into five independent subsystems; each can be toggled via a flag in the `macro.Flags` scoreboard.

| Flag | Value | Covers |
|---|---|---|
| `#m_time` | `1` | Epoch counter, `$tick` increment |
| `#m_queue` | `1` | `lib/process_queue`, `lib/schedule` |
| `#m_player` | `1` | Player menu, run, action triggers |
| `#m_hud` | `1` | Automatic progress bar (actionbar) |
| `#m_admin` | `1` | Debug and admin systems |

When a flag is `0` the corresponding subsystem runs `macro:tick/disabled` (no-op). All flags are set to `1` (active) on load.

New tick files: `tick/time_systems`, `tick/queue_systems`, `tick/player_systems`, `tick/hud_systems`, `tick/admin_systems`, `tick/disabled`.

### New: Flag System Functions

| Function | Input | Description |
|---|---|---|
| `flag/toggle_system` | `{system:"<name>"}` | Toggles `#m_<name> macro.Flags` and reports the new state to `@s` |
| `flag/list_systems` | -- | Shows current scores for all five system flags to `@s` |

---

## v1.0.6-pre2 -- 2026-03-05

### Bug Fixes

#### `$v_pre` / `$v_*` -- 1.21.1 macro parser collision
Fake player names `$v_major`, `$v_minor`, `$v_patch`, `$v_pre`, `$ame_ver_set`, `$ver_mismatch` in `version_set` and `validate` were parsed as macro variables in 1.21.1 (pack_format 48–57), producing `Expected integer` / `Invalid variable for command` errors. All names moved to `#ame.*` format.

| Old | New |
|---|---|
| `$v_major` | `#ame.major` |
| `$v_minor` | `#ame.minor` |
| `$v_patch` | `#ame.patch` |
| `$v_pre` | `#ame.pre` |
| `$ame_ver_set` | `#ame.ver_set` |
| `$ver_mismatch` | `#ame.mismatch` |
| `$log_count` | `#ame.log_count` |

Files affected: `version_set`, `validate`, `version_warn`, `finalize`, `log/add`, `log/clear`, `load/internal/cleanup`.

#### `action` → `invoke` -- 1.21.1 NBT path parse error
`data modify storage macro:input action` lines produced `Invalid variable for command` in 1.21.1's command parser. Storage key renamed from `action` to `invoke`.

> ⚠️ **Breaking change:** Functions using `data modify storage macro:input action set value "..."` must be updated to use `invoke`.

### Changes

- All alignment-purpose double spaces in `.mcfunction` files reduced to single spaces (`.json` and `.mcmeta` left unchanged).

---

## v1.0.5 -- 2026-03-05

### Bug Fixes

#### `action` → `callback` -- 1.21.4+ reserved keyword collision
`action` became a reserved keyword in the 1.21.4 command parser. All `data modify storage macro:input action` lines in 13 files produced parse errors. Storage key renamed to `callback`.

> ⚠️ **Breaking change:** Functions using `data modify storage macro:input action set value "..."` must be updated to use `callback`.

#### `dialog/close` (base) -- unreachable code after `return`
`tag @s remove macro.dialog_opened` and `tag @s add macro.dialog_closed` after `return run tellraw` were never reached. `return` removed; engine tag state is now correctly cleaned up in the 1.21.1 fallback.

#### `1_21_6/dialog/load` -- reference to deleted `load_exec`
`1_21_6/dialog/load.mcfunction` called `macro:dialog/internal/load_exec` which had been deleted in a previous cleanup. Every `macro:dialog/load` call on 1.21.6+ produced `Unknown function`. Content of `load_exec` inlined into `load.mcfunction`.

#### `1_21_6/` overlay -- stale files from deleted functions
`cmd/storage_get.mcfunction`, `cmd/other/internal/display.mcfunction`, and `dialog/internal/load_exec.mcfunction` still existed in the `1_21_6/` overlay after being removed from `data/`. Since Minecraft merges both layers, these files were never truly deleted. All three removed from the overlay.

### Changes

- All alignment-purpose double spaces in `.mcfunction` files reduced to single spaces (comment lines preserved).

---

## v1.0.5-pre3 -- 2026-03-04

### Bug Fixes

#### Mass command corruption -- `remove` / `give` / `leave`
A find-and-replace operation corrupted three Minecraft commands across the entire pack:

| Corrupted | Correct | Files affected |
|---|---|---|
| `remove` | `remove` | 58 files, 194 lines |
| `give` | `give` | `cmd/give`, `cmd/give_one`, `cmd/loot_give`, `cmd/heal`, `cmd/effect_give` |
| `leave` | `leave` | `team/remove` (`team leave`) |

#### `macro:dialog/` -- missing base namespace
`macro:dialog/open`, `close`, `show`, `load` were only defined in the `1_21_6/` overlay (pack_format ≥ 80). On 1.21.1 (pack_format 48), `tick.mcfunction` produced `missing function` errors every tick. Added 4 fallback stubs under `data/macro/function/dialog/`; tag/score state is consistent, dialog API is absent.

### New: Version Scoreboard -- `ame.pre_version`

| Score | Value | Description |
|---|---|---|
| `$v_major` | `1` | Major version |
| `$v_minor` | `0` | Minor version |
| `$v_patch` | `5` | Patch version |
| `$ame_ver_set` | `1` | Sentinel -- previous AME session has written scores |

### New: Modular Load Internal Files

| File | Role |
|---|---|
| `version_set.mcfunction` | Writes version scores after a successful load |
| `version_warn.mcfunction` | Mismatch: test_block log + tellraw + debug score summary + log/warn |
| `finalize.mcfunction` | Post-load success log + admin score summary tellraw |

### New: `clickEvent` / `click_event` Overlay Split

Minecraft 1.21.5 changed `tellraw` JSON syntax (`clickEvent` → `click_event`, `hoverEvent` → `hover_event`). Affected files split into overlays:

- **Base (`data/`)** -- `click_event` / `hover_event` (1.21.5+)
- **`-1_21_4/` overlay** -- old `clickEvent` / `hoverEvent` syntax (pack_format ≤ 61)
- **`1_21_6/` overlay** -- `click_event` / `hover_event` (pack_format ≥ 80)

---

## v1.0.3-pre -- 2026-03-04

### New Module: `log/`

Dialog-based log system. Never writes to chat; opens an inline JSON panel via `/dialog show @s` on 1.21.6+, falls back to `tellraw @s` on older versions.

| Function | Input | Description |
|---|---|---|
| `log/add` | `{level, message, color}` | Add a raw log entry |
| `log/info` | `{message}` | INFO level (green) |
| `log/warn` | `{message}` | WARN level (yellow) |
| `log/error` | `{message}` | ERROR level (red) |
| `log/debug` | `{message}` | DEBUG level (gray) |
| `log/show` | -- | Show log dialog/tellraw to `@s` |
| `log/clear` | -- | Clear all log entries |

Storage: `macro:engine log_display` -- JSON text component list, max 30 entries (circular buffer). Scoreboard: `$log_count macro.tmp`.

### New: Tick-safe Guard -- `macro:lib/tick_guard`

Per-entity within-tick execution guard. Prevents the same entity from being processed twice in the same tick.

| Function | Description |
|---|---|
| `lib/tick_guard` | Check + set guard for `@s`. Returns 0 if already processed this tick, 1 to continue |
| `lib/tick_guard_clear` | Manually reset the guard for `@s` |

Mechanism: if `@s macro.tick_guard` equals `$epoch macro.time`, stop; otherwise write the epoch. The guard expires automatically on the next tick when `$epoch` changes.

### New: Advanced Trigger System -- `macro:trigger/*`

New `macro_action` trigger objective + value-to-function bind system. When a player writes `/trigger macro_action set <N>`, the function bound to N runs automatically. Tick dispatch never touches `macro:input`.

| Function | Input | Description |
|---|---|---|
| `trigger/bind` | `{value, func}` | Bind a value to a function |
| `trigger/unbind` | `{value}` | Remove all binds for a value |
| `trigger/unbind_all` | -- | Clear all binds |
| `trigger/enable` | `{player}` | Enable `macro_action` trigger for a player |
| `trigger/disable` | `{player}` | Disable a player's trigger |
| `trigger/list` | -- | Show bind list to `@s` |

Multiple binds per value are supported; all run in order.

---

## v1.0.0 -- 2026-03-03

Initial release.

### Core Modules

| Module | Functions |
|---|---|
| `cooldown/` | `set`, `check`, `remaining`, `clear`, `clear_all` |
| `event/` | `register`, `fire`, `unregister`, `list` |
| `lib/` | `for_each_player`, `for_each_player_at`, `repeat`, `wait`, `queue_add`, `schedule`, `once`, `throttle`, `debounce`, `input_push`, `input_pop` |
| `math/` | `sign`, `abs`, `clamp`, `lerp`, `sqrt`, `ceil_div`, `distance2d`, `distance3d`, `pow`, `min`, `max`, `random`, `cos`, `sin`, `gcd`, `lcm` |
| `team/` | `create`, `delete`, `add`, `remove`, `has`, `set_color`, `set_friendly_fire`, `count`, `list` |
| `config/` | `set`, `set_int`, `set_default`, `get`, `has`, `delete`, `list`, `reset` |
| `cmd/` | 100+ command wrappers |
| `string/` | `progress_bar`, `progress_bar_self`, `announce`, `header`, `chat`, `player_raw`, `broadcast_raw`, `format_number`, `pad_left` |
| `player/` | `init`, `reset`, `get_var`, `set_var`, `has_var`, `del_var`, `add_default`, `increment`, `decrement`, `get_name`, `get_health`, `get_xp`, `get_food`, `get_pos`, `get_dimension`, `is_online`, `online_check`, `get_online_count`, `list_vars` |
| `flag/` | `set`, `unset`, `get`, `toggle`, `list`, `toggle_system`, `list_systems` |
| `state/` | `set`, `get`, `is`, `clear`, `clear_all`, `list`, `toggle` |
| `geo/` | `in_region`, `in_region_unless`, `in_sphere`, `near_entity`, `near_entity_unless`, `as_nearby_player` |
| `entity/` | `count`, `damage`, `for_each`, `give_effect`, `kill_tagged`, `summon_at_player`, `tag_add`, `tag_remove`, `tp_to` |
| `world/` | `block_if`, `block_unless`, `setblock_if`, `fill_hollow`, `fill_keep`, `fill_outline`, `fill_replace`, `clone_to` |
| `inv/` | `count_item`, `clear_custom`, `player_if_item`, `player_unless_item`, `player_slot_if_item`, `chest_minecart_if_item`, `chest_minecart_unless_item`, `transfer_item` |
| `nbt/` | `append`, `clear`, `copy`, `count`, `exists`, `move`, `pop`, `swap` |
| `logic/` | `if_eq`, `if_not_eq`, `if_gt`, `if_gte`, `if_lt`, `if_lte` |
| `hook/` | `bind`, `unbind`, `unbind_all`, `list` |
| `wand/` | Full wand system |
| `interaction/` | Full interaction entity system |
| `perm/` | Full permission system |
| `uuid/` | Full UUID system |
| `dialog/` | `open`, `close`, `show`, `load` |
