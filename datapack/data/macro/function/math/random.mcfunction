# ============================================
# macro:math/random
# ============================================
# [min, max] aralığında pseudo-rastgele tamsayı üretir.
# Numerical Recipes LCG algoritması (32-bit, overflow wrap).
# Aynı tick içinde birden fazla çağrı farklı sonuç verir
# çünkü _rng_state her çağrıda güncellenir.
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

# Tohum: önceki state varsa kullan, yoksa epoch değerini al
execute if data storage macro:engine _rng_state run execute store result score $rnd macro.tmp run data get storage macro:engine _rng_state
execute unless data storage macro:engine _rng_state run execute store result score $rnd macro.tmp run scoreboard players get $epoch macro.time
execute unless data storage macro:engine _rng_state run scoreboard players operation $rnd macro.tmp += $tick macro.tmp

# LCG adımı: next = 1664525 * state + 1013904223  (Numerical Recipes)
scoreboard players set $rnd_a macro.tmp 1664525
scoreboard players operation $rnd macro.tmp *= $rnd_a macro.tmp
scoreboard players add $rnd macro.tmp 1013904223

# Tick ile karıştır — aynı tick'te birden fazla çağrıda farklılaştır
scoreboard players operation $rnd macro.tmp += $tick macro.tmp

# State'i kaydet
execute store result storage macro:engine _rng_state int 1 run scoreboard players get $rnd macro.tmp

# Modulo için pozitife çevir
# Integer.MIN_VALUE (-2147483648) özel durum — div sıfır hatasını önle
execute if score $rnd macro.tmp matches -2147483648 run scoreboard players set $rnd macro.tmp 2147483647
execute if score $rnd macro.tmp matches ..-1 run scoreboard players set $rnd_neg macro.tmp -1
execute if score $rnd macro.tmp matches ..-1 run scoreboard players operation $rnd macro.tmp *= $rnd_neg macro.tmp

# result = (rnd % range) + min  →  Java modulo negatif olabilir, normalize et
scoreboard players operation $rnd macro.tmp %= $rnd_max macro.tmp
execute if score $rnd macro.tmp matches ..-1 run scoreboard players operation $rnd macro.tmp += $rnd_max macro.tmp

# Offset ekle
scoreboard players operation $rnd macro.tmp += $rnd_min macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $rnd macro.tmp
