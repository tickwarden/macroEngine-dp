# ============================================
# macro:cooldown/set
# ============================================
# Cooldown başlatır. Bitiş epoch'unu storage'a yazar.
# INPUT: macro:input { player:"<ad>", key:"<cooldown>", duration:<tick> }
# ============================================

# Mevcut epoch + duration = expiry
$scoreboard players set $cd_dur macro.tmp $(duration)
execute store result score $cd_now macro.tmp run scoreboard players get $epoch macro.time
scoreboard players operation $cd_now macro.tmp += $cd_dur macro.tmp
$execute store result storage macro:engine cooldowns.$(player).$(key) int 1 run scoreboard players get $cd_now macro.tmp
