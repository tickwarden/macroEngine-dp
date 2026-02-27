# ============================================
# macro:cooldown/remaining
# ============================================
# Kalan cooldown tick'ini döndürür. 0 = dolmuş / hazır.
# INPUT: macro:input { player:"<ad>", key:"<cooldown>" }
# OUTPUT: macro:output { result:<kalan_tick> }
# ============================================

# Kayıt yoksa 0
data modify storage macro:output result set value 0
$execute unless data storage macro:engine cooldowns.$(player).$(key) run return 0

$execute store result score $cd_exp macro.tmp run data get storage macro:engine cooldowns.$(player).$(key)
execute store result score $cd_now macro.tmp run scoreboard players get $epoch macro.time

# remaining = expiry - now (eğer negatifse 0)
scoreboard players operation $cd_exp macro.tmp -= $cd_now macro.tmp
execute if score $cd_exp macro.tmp matches 1.. run execute store result storage macro:output result int 1 run scoreboard players get $cd_exp macro.tmp
