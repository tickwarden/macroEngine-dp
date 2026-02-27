# ============================================
# macro:cooldown/check
# ============================================
# Cooldown dolmuş mu (hazır mı) kontrol eder.
# INPUT: macro:input { player:"<ad>", key:"<cooldown>" }
# OUTPUT: macro:output { result: 1b (hazır) / 0b (aktif) }
# ============================================

data modify storage macro:output result set value 1b

# Kayıt yoksa hazır (1b zaten set)
$execute unless data storage macro:engine cooldowns.$(player).$(key) run return 0

# Expiry'yi oku, mevcut epoch ile karşılaştır
$execute store result score $cd_exp macro.tmp run data get storage macro:engine cooldowns.$(player).$(key)
execute store result score $cd_now macro.tmp run scoreboard players get $epoch macro.time

# epoch >= expiry → hazır (1b), epoch < expiry → aktif (0b)
execute if score $cd_now macro.tmp < $cd_exp macro.tmp run data modify storage macro:output result set value 0b
