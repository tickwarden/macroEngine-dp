# ============================================
# macro:lib/sync_tick
# ============================================
# Her 20 tick'te (1 sn) çağrılır.
# - global.tick: son 1 sn içindeki tick sayısı (debug/monitoring)
# - global.epoch: mutlak tick sayısı (cooldown hesapları için)
# - $tick macro.tmp sıfırlanır
# ============================================
execute store result storage macro:engine global.tick int 1 run scoreboard players get $tick macro.tmp
execute store result storage macro:engine global.epoch int 1 run scoreboard players get $epoch macro.time
scoreboard players set $tick macro.tmp 0
