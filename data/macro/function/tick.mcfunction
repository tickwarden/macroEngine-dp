# ============================================
# macro:tick — Her tick çalışır
# ============================================
# - $epoch macro.time: mutlak tick sayacı (cooldown için)
# - $tick macro.tmp: sync_tick'e kadar geçen tick (1sn'de bir sıfırlanır)
# - Queue işlenir
# - '/trigger macro_menu' çalışır
# - '/trigger macro_run' çalışır
# - Auto-HUD: macro:engine pb_obj ayarlıysa progress_bar_self otomatik çalışır
#   Aktif et  : data modify storage macro:engine pb_obj set value "health"
#               data modify storage macro:engine pb_max set value 20
#               data modify storage macro:engine pb_label set value "Can"
#   Kapat     : data remove storage macro:engine pb_obj
# ============================================

execute unless entity @a run return 0

execute unless data storage macro:engine global{loaded:1b} run return 0

scoreboard players add $epoch macro.time 1
scoreboard players add $tick macro.tmp 1
# BUG FIX v3.0: Her tick'te özyineleme sayacını sıfırla
scoreboard players set $pq_depth macro.tmp 0
function macro:lib/process_queue
execute as @a[scores={macro_menu=1..}] run function macro:menu
scoreboard players set @a[scores={macro_menu=1..}] macro_menu 0
scoreboard players enable @a[scores={macro_menu=-1..}] macro_menu

execute as @a[scores={macro_run=1..}] run function #macro:run
scoreboard players set @a[scores={macro_run=1..}] macro_run 0
scoreboard players enable @a[scores={macro_run=-1..}] macro_run

# ── Auto-HUD: her 4 tick'te bir, pb_obj varsa progress_bar_self çalıştır ──
execute if data storage macro:engine pb_obj run execute if score $epoch macro.time matches 0 run scoreboard players set $pb_phase macro.tmp 0
execute if data storage macro:engine pb_obj run scoreboard players add $pb_phase macro.tmp 1
execute if data storage macro:engine pb_obj run execute if score $pb_phase macro.tmp matches 4.. run scoreboard players set $pb_phase macro.tmp 0
execute if data storage macro:engine pb_obj run execute if score $pb_phase macro.tmp matches 0 run execute as @a run function macro:string/progress_bar_self with storage macro:engine {}

execute as @a at @s run function macro:string/progress_bar with storage macro:input {}