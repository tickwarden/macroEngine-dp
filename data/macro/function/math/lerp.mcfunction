# ============================================
# macro:math/lerp
# ============================================
# Doğrusal interpolasyon: a + (b - a) * t / 100
# t: 0..100 arası tam sayı yüzde
# INPUT:  macro:input { a:<int>, b:<int>, t:<int> }
# OUTPUT: macro:output { result:<int> }
#
# Örnek: lerp(0, 100, 75) = 75
#         lerp(10, 20, 50) = 15
# ============================================

$scoreboard players set $lerp_a macro.tmp $(a)
$scoreboard players set $lerp_b macro.tmp $(b)
$scoreboard players set $lerp_t macro.tmp $(t)

# range = b - a
scoreboard players operation $lerp_r macro.tmp = $lerp_b macro.tmp
scoreboard players operation $lerp_r macro.tmp -= $lerp_a macro.tmp

# result = a + range * t / 100
scoreboard players operation $lerp_r macro.tmp *= $lerp_t macro.tmp
scoreboard players set $lerp_100 macro.tmp 100
scoreboard players operation $lerp_r macro.tmp /= $lerp_100 macro.tmp
scoreboard players operation $lerp_r macro.tmp += $lerp_a macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $lerp_r macro.tmp
