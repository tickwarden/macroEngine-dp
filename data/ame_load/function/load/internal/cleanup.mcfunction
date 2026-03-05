# ============================================
# ame_load:load/internal/cleanup
# ============================================
# Full state reset — identical to disable/main.
# Called via /function macro:disable or macro:disable/main.
# BUG FIX v3.1: queue, events, cooldowns, player vars,
# schedules, throttle, _input_stack, _event_tmp,
# _repeat and rng_state are also cleared.
# ============================================

# ─── Schedule'lari stop ────────────────────────────────
schedule clear macro:lib/sync_tick

# ─── Forceload'u remove ──────────────────────────────────
forceload remove 0 0

# ─── Trigger resetma ───────────────────────────────────
scoreboard players reset @a macro_menu
scoreboard players reset @a macro_run

# ─── Counterlari reset ───────────────────────────────────
scoreboard players reset $tick macro.tmp
scoreboard players reset $pq_depth macro.tmp
scoreboard players reset $epoch macro.time

# ─── Storage clear (tam) ───────────────────────────────
data remove storage macro:engine queue
data remove storage macro:engine events
data remove storage macro:engine event_context
data remove storage macro:engine _event_tmp
data remove storage macro:engine cooldowns
data remove storage macro:engine throttle
data remove storage macro:engine players
data remove storage macro:engine flags
data remove storage macro:engine states
data remove storage macro:engine schedules
data remove storage macro:engine _input_stack
data remove storage macro:engine _repeat
data remove storage macro:engine _rng_state
data remove storage macro:engine _felist_input
data remove storage macro:engine _felist_state
data remove storage macro:engine _felist_current
data remove storage macro:engine _felist_i
data remove storage macro:engine log_display
scoreboard players reset $log_count macro.tmp
data remove storage macro:engine trigger_binds
data remove storage macro:engine _tc_binds
data remove storage macro:engine _tc_current
data remove storage macro:engine _tc_unbind
data remove storage macro:engine _tc_uval
# BUG FIX v1.0.6-pre1: teams storage was never cleared on disable/reload.
# team/create writes here; without this line data accumulates across reloads.
data remove storage macro:engine teams
# Config is preserved — so it survives reload
data remove storage macro:engine global
data remove storage macro:output result

# ─── Scoreboard objectives remove ───────────────────────
scoreboard objectives remove macro.tmp
scoreboard objectives remove macro.time
scoreboard objectives remove macro_menu
scoreboard objectives remove macro_run
scoreboard objectives remove macro_action
scoreboard objectives remove macro.tick_guard
scoreboard objectives remove macro.dialog_load
scoreboard objectives remove health
# Version tracking objective — also cleared on disable
scoreboard objectives remove ame.pre_version

# ─── Dialog tag'leri clear ────────────────────────────
tag @a remove macro.dialog_opened
tag @a remove macro.dialog_closed
