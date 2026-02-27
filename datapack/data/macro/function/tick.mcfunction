# ============================================
# macro:tick — Her tick çalışır
# ============================================
# - $epoch macro.time: mutlak tick sayacı (cooldown için)
# - $tick macro.tmp: sync_tick'e kadar geçen tick (1sn'de bir sıfırlanır)
# - Queue işlenir
# - '/trigger macro_menu' çalışır
# - '/trigger macro_run' çalışır
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
