# ============================================
# macro:tick — Runs every tick
# ============================================
# - $epoch macro.time: absolute tick counter (for cooldown)
# - $tick macro.tmp: ticks elapsed since last sync_tick (1s reset interval)
# - Queue is processed
# - '/trigger macro_menu' runs
# - '/trigger macro_run' runs
# - '/trigger macro_action' → dispatched via trigger/bind system
# - Auto-HUD: if macro:engine pb_obj is set, progress_bar_self runs automatically every tick
# Enable : data modify storage macro:engine pb_obj set value "health"
# data modify storage macro:engine pb_max set value 20
# data modify storage macro:engine pb_label set value "Health"
# Disable : data remove storage macro:engine pb_obj
# ============================================

execute unless entity @a run return 0

execute unless data storage macro:engine global{loaded:1b} run return 0

scoreboard players add $epoch macro.time 1
scoreboard players add $tick macro.tmp 1
# BUG FIX v3.0: Reset recursion counter every tick
scoreboard players set $pq_depth macro.tmp 0
function macro:lib/process_queue
execute as @a[scores={macro_menu=1..}] run function macro:menu
scoreboard players set @a[scores={macro_menu=1..}] macro_menu 0
scoreboard players enable @a[scores={macro_menu=-1..}] macro_menu

execute as @a[scores={macro_run=1..}] run function #macro:run
scoreboard players set @a[scores={macro_run=1..}] macro_run 0
scoreboard players enable @a[scores={macro_run=-1..}] macro_run

# ── Advanced trigger dispatch (v1.0.3) ───────────────────────────
# scan trigger/bind list for any player with macro_action > 0.
# All matching bind functions run as @s.
# macro:input must never be touched (tick context safety).
execute as @a[scores={macro_action=1..}] run function macro:trigger/internal/dispatch

# ── Auto-HUD: every tick, run progress_bar_self if pb_obj is set ──
# $epoch % 1 = always 0, so it runs every tick — actionbar never disappears
execute if data storage macro:engine pb_obj run scoreboard players operation $pb_mod macro.tmp = $epoch macro.time
execute if data storage macro:engine pb_obj run scoreboard players operation $pb_mod macro.tmp %= $pb_four macro.tmp
execute if data storage macro:engine pb_obj run execute if score $pb_mod macro.tmp matches 0 run execute as @a run function macro:string/progress_bar_self with storage macro:engine {}

# BUG FIX v1.0.1: Only decrement positioned scores.
# Onceden "@a" decremented all player scores; score could go past 0 to -1, -2...
# oldugunda "=0" condition would never match again (race condition).
# Score no longer drops below 0; trigger always fires.
scoreboard players remove @a[scores={macro.dialog_load=1..}] macro.dialog_load 1

# Time elapsed + loading dialog closed, so open (used with macro:dialog/load)
execute as @a[scores={macro.dialog_load=0},tag=macro.dialog_closed] at @s run function macro:dialog/open
# BUG FIX v1.0.1: Direct "/scoreboard players set @s macro.dialog_load N" usage:
# Also open dialog if only score was set without the tag.
execute as @a[scores={macro.dialog_load=0},tag=!macro.dialog_closed,tag=!macro.dialog_opened] at @s run function macro:dialog/open

# Other
tag @a[tag=macro.admin] add macro.debug
scoreboard players enable @a[tag=macro.admin] macro_menu
scoreboard players enable @a[tag=macro.admin] macro_action
scoreboard players enable @a[tag=macro.admin] macro_run
