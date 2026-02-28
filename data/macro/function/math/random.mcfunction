# ============================================
# macro:math/random
# ============================================
# [min, max] aralığında pseudo-rastgele tamsayı üretir.
# Numerical Recipes LCG algoritması (32-bit, overflow wrap).
# Aynı tick içinde birden fazla çağrı farklı sonuç verir
# çünkü _rng_state her çağrıda güncellenir.
#
# BUG FIX v3.2: epoch=0 durumunda (ilk tick) tohum çok
# zayıftı. Sabit bir offset (0xDEAD = 57005) eklendi.
# Ayrıca tick*31 ile ekstra entropi karıştırılıyor.
#
# INPUT:  macro:input { min:<int>, max:<int> }
# OUTPUT: macro:output { result:<int> }
#
# ÖRNEK:
#   data modify storage macro:input min set value 1
#   data modify storage macro:input max set value 6
#   function macro:math/random with storage macro:input {}
#   # → 1-6 arası zar sonucu
# ============================================

$scoreboard players set $rnd_min macro.tmp $(min)
$scoreboard players set $rnd_max macro.tmp $(max)

# range = max - min + 1
scoreboard players operation $rnd_max macro.tmp -= $rnd_min macro.tmp
scoreboard players add $rnd_max macro.tmp 1

# Tohum: önceki state varsa kullan, yoksa epoch + offset ile başlat
# BUG FIX v3.2: 57005 sabiti (0xDEAD) epoch=0 iken zayıf tohumu giderir
execute if data storage macro:engine _rng_state run execute store result score $rnd macro.tmp run data get storage macro:engine _rng_state
execute unless data storage macro:engine _rng_state run execute store result score $rnd macro.tmp run scoreboard players get $epoch macro.time
execute unless data storage macro:engine _rng_state run scoreboard players add $rnd macro.tmp 57005

# Tick ile entropi: tick*31 eklenir — aynı tick içinde birden fazla çağrıda farklılaşır
scoreboard players set $rnd_tick macro.tmp 31
execute store result score $rnd_t macro.tmp run scoreboard players get $tick macro.tmp
scoreboard players operation $rnd_t macro.tmp *= $rnd_tick macro.tmp
scoreboard players operation $rnd macro.tmp += $rnd_t macro.tmp

# LCG adımı: next = 1664525 * state + 1013904223  (Numerical Recipes)
scoreboard players set $rnd_a macro.tmp 1664525
scoreboard players operation $rnd macro.tmp *= $rnd_a macro.tmp
scoreboard players add $rnd macro.tmp 1013904223

# State'i kaydet
execute store result storage macro:engine _rng_state int 1 run scoreboard players get $rnd macro.tmp

# Integer.MIN_VALUE (-2147483648) özel durum — div sıfır hatasını önle
execute if score $rnd macro.tmp matches -2147483648 run scoreboard players set $rnd macro.tmp 2147483647
execute if score $rnd macro.tmp matches ..-1 run scoreboard players set $rnd_neg macro.tmp -1
execute if score $rnd macro.tmp matches ..-1 run scoreboard players operation $rnd macro.tmp *= $rnd_neg macro.tmp

# result = (rnd % range) + min
scoreboard players operation $rnd macro.tmp %= $rnd_max macro.tmp
execute if score $rnd macro.tmp matches ..-1 run scoreboard players operation $rnd macro.tmp += $rnd_max macro.tmp
scoreboard players operation $rnd macro.tmp += $rnd_min macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $rnd macro.tmp
