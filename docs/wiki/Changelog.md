# 📋 Changelog

← [Home](Home)

Full detailed changelog: [docs/CHANGELOG.md](https://github.com/tickwarden/macroEngine-datapack/blob/main/docs/CHANGELOG.md)

---

## v4.0.0 — 2026-04-13

**Load Confirmation Gate** — `ame_load:load/confirm` / `yes` / `no` / `timeout`. Storage is never written until an admin confirms. Prevents silent data loss on `/reload`.

**Dangerous Command Gate** — `ban`, `ban_ip`, `disable` now go through `ame_load:gate/` with 30-second auto-cancel.

**Storage Safety** — `storages.mcfunction` uses `execute unless data` guards on all fields.

**Marker Entity Pattern** — All gate messages use `summon marker → say → kill` for reliable server-log output on headless servers.

---

## v4.0.0 — 2026-04-12

**StringLib Integration** — [StringLib (CMDred, MIT)](https://github.com/CMDred/StringLib) bundled directly. Access via `macro:lib/string/*` wrappers: `concat`, `find`, `replace`, `split`, `insert`, `to_lowercase`, `to_uppercase`, `to_number`, `to_string`.

---

## v3.0.3 — 2026-04-11

**New overlay:** `1_20_5` (pack_format 41–47).  
**New:** `math/mul_div` — overflow-safe `a×b÷c`.

---

## v3.0.2 — 2026-04-10

**New overlay:** `1_20_3` (pack_format 26).  
**New:** `queue/` multi-command queue system.  
**New:** All hook advancements for `1_20_3` and `1_20_5` overlays.  
**New:** `spyglass.json` static analysis config.  
**Fix:** Trigger system unified into dispatch hub.

---

## v3.0.1 — 2026-04-09

**New:** `time/get_time`, `time/time_phase`, `hook/reset_all`.  
**Fix:** Version string mismatch in all overlays (v4.0.0 → v3.0.1).

---

## v4.0.0 — 2026-04-04

**Breaking:** `rate_limit` module fully rewritten — sub-function API removed. New `check` / `tick` / `config` pure-scoreboard API.

---

## v2.2.9 — 2026-04-04

**New:** `cooldown/pause`, `cooldown/resume`, `player/is_flying`, `string/repeat`.

---

## v2.2.8 — 2026-04-03

**New:** `entity/for_each_in_radius`, `player/is_on_ground`, `player/is_burning`, `inv/offhand_item`, `world/get_time`, `nbt/merge`, `nbt/first`, `flag/set_if`, `flag/any`.

---

## v2.2.7 — 2026-04-02

**New:** `math/round`, `math/sign_nonzero`, `string/truncate`, `string/pluralize`, `player/get_armor`, `player/is_sneaking`, `player/is_sprinting`, `entity/clear_effects`, `entity/set_health`, `entity/nearest`, `flag/set_if`, `flag/any`.

---

## v2.2.6 — 2026-03-30

**New overlay:** `1_20_3` compatibility fixes (predicates, loot tables, advancement display).

---

## v2.2.2

**New:** `cmd/swing`, `cmd/time_of`, `cmd/set_clock_rate`.

---

## v2.2.1 — 2026-03-23

**Fix:** Spurious `Unknown function` errors, `wand/register` errors, silent dialog fail.

---

## v2.2.0 — 2026-03-22

**New modules:** `lib/fiber/` (cooperative concurrency), `math/vec/` (3D vectors), `geo/region_watch/` (persistent region triggers), `lib/batch/` (tick-spread processing).  
**New hook events:** `dimension_change`, `trade`, `advancement:<id>`.

---

## v2.1.2 — 2026-03-19

**New:** `wand/` module — carrot-on-a-stick right-click detection with bind/unbind/cooldown system.  
**Fix:** `ame_load:load/internal/validate` version mismatch on reload.  
**Fix:** `macro:cmd/save-all` etc. wrapped via `run_self` to avoid single-player parse error.  
**Renamed overlay:** `-1_21_4` → `compat_1_21_4`.

---

## v2.0.3 — 2026-03-14

**New:** `macro:version` function, `uuid/` module, `math/lerp_clamped`, `cooldown/extend`, `state/toggle`, `event/fire_as`, `string/format_ticks`, `player/get_dimension`.  
**New:** Scheduler `cmd` variant functions (`lib/schedule_cmd`, `lib/wait_cmd`, etc.).  
**Fix:** `tools/utils/input_check` version comparison (uppercase `V` → lowercase `v`).

---

## v2.0.2 — 2026-03-11

**New:** Player PID system — unique integer IDs for duplicate-name-safe targeting.  
**Fix:** `math/random` distribution bias removed.

---

## v2.0.0 — 2026-03-10

**New:** `perm/` permission system (grant/revoke/check/run/exec).  
**New:** `perm/trigger/` — permission-protected named triggers.

---

## v1.0.6-pre4 — 2026-03-06

**New:** Multi-command system, `flag/open_toggle_system_menu`.

---

## v1.0.6-pre3 — 2026-03-05

**New:** Flag-controlled tick subsystem (5 independently-togglable subsystems).  
**Fix:** `flag/toggle_system` macro variable conflict, double-execute race condition.

---

## v1.0.5 — 2026-03-05

**Breaking:** `action` key → `callback`, then → `invoke` (v1.0.6-pre2).  
**Fix:** `dialog/close` unreachable code after `return run`.

---

## v1.0.3-pre

**New:** Log system (`log/*`), tick-guard (`lib/tick_guard`), trigger system (`trigger/*`).

---

## v1.0.0

**Initial release.** Auto-HUD, `string/progress_bar`, load/warn dialog, base API.
