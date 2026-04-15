# 📊 Scoreboard Reference

← [Home](Home)

---

## Objectives

| Objective | Criterion | Description |
|-----------|-----------|-------------|
| `macro.time` | `dummy` | Global monotonic tick counter. `$epoch` never resets on `/reload`. |
| `macro.tmp` | `dummy` | General-purpose temporary calculations. |
| `macro.pid` | `dummy` | Per-player unique integer PID for reliable targeting. |
| `macro.Flags` | `dummy` | Tick subsystem enable/disable flags. |
| `macro.rightClick` | `minecraft.used:minecraft.carrot_on_a_stick` | Right-click detection for the wand system. |
| `macro.tick_guard` | `dummy` | Per-entity tick-unique execution guard. |
| `macro_action` | `trigger` | Legacy trigger system (value→function dispatch). |
| `ame.pre_version` | `dummy` | Engine version scoreboard (`major`, `minor`, `patch`, `pre`). |

---

## Fake Players (on `macro.Flags`)

| Fake player | Meaning |
|-------------|---------|
| `#m_time` | Time subsystem enabled (1) / disabled (0) |
| `#m_queue` | Queue/schedule subsystem |
| `#m_player` | Player subsystem (wand, interaction, trigger, perm) |
| `#m_hud` | HUD/actionbar subsystem |
| `#m_admin` | Admin/debug subsystem |

---

## Fake Players (on `ame.pre_version`)

| Fake player | Value | Description |
|-------------|-------|-------------|
| `#ame.major` | e.g. `4` | Major version number |
| `#ame.minor` | e.g. `0` | Minor version number |
| `#ame.patch` | e.g. `0` | Patch version number |
| `#ame.pre` | `0` = release | Pre-release build index |
| `#ame.ver_set` | `1` after load | Sentinel — previous AME session initialized |
| `#ame.mismatch` | `1` on mismatch | Version mismatch detected during load |
| `#ame.log_count` | 0 – 30 | Current log buffer entry count |

---

## Fake Players (on `macro.time`)

| Fake player | Description |
|-------------|-------------|
| `$epoch` | Current absolute tick (increments every tick, never resets) |
| `$tick` | Current tick within session |
| `$pq_depth` | Queue recursion depth guard (max 256/tick) |

---

## LanternLoad

| Score holder | Objective | Value | Description |
|---|---|---|---|
| `macroEngine` | `load.status` | `40000` (v4.0.0) | Version for dependency guards. Format: `major*10000 + minor*100 + patch`. |
| `StringLib` | `load.status` | non-zero | StringLib loaded successfully. |

---

## Per-Session Flags (tags on players)

| Tag | Meaning |
|-----|---------|
| `macro.admin` | Player has admin privileges |
| `macro.debug` | Player receives verbose/debug output |
| `macro.dialog_opened` | Player has a dialog open |
| `macro.dialog_closed` | Player just closed a dialog |
| `perm.<name>` | Player has permission `<name>` (runtime cache) |
