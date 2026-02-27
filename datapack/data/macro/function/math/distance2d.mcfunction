# ============================================
# macro:math/distance2d
# ============================================
# XZ düzleminde iki nokta arası mesafe: floor(√(dx² + dz²))
# INPUT:  macro:input { x1:<int>, z1:<int>, x2:<int>, z2:<int> }
# OUTPUT: macro:output { result:<int> }
#
# Örnek: distance2d(0,0, 3,4) = 5
# Not: macro:math/sqrt'ın binary search mantığı inline kullanılır;
#      macro:input kirlenmez.
# ============================================

$scoreboard players set $d2d_x1 macro.tmp $(x1)
$scoreboard players set $d2d_z1 macro.tmp $(z1)
$scoreboard players set $d2d_x2 macro.tmp $(x2)
$scoreboard players set $d2d_z2 macro.tmp $(z2)

# dx = x2 - x1
scoreboard players operation $d2d_dx macro.tmp = $d2d_x2 macro.tmp
scoreboard players operation $d2d_dx macro.tmp -= $d2d_x1 macro.tmp

# dz = z2 - z1
scoreboard players operation $d2d_dz macro.tmp = $d2d_z2 macro.tmp
scoreboard players operation $d2d_dz macro.tmp -= $d2d_z1 macro.tmp

# d² = dx² + dz²
scoreboard players operation $d2d_dx macro.tmp *= $d2d_dx macro.tmp
scoreboard players operation $d2d_dz macro.tmp *= $d2d_dz macro.tmp
scoreboard players operation $d2d_sq macro.tmp = $d2d_dx macro.tmp
scoreboard players operation $d2d_sq macro.tmp += $d2d_dz macro.tmp

# Mesafe sıfır özel durumu
execute if score $d2d_sq macro.tmp matches 0 run data modify storage macro:output result set value 0
execute if score $d2d_sq macro.tmp matches 0 run return 0

# sqrt(d²) — macro:math/sqrt inline binary search mantığı
# ($sqrt_n ← $d2d_sq, macro:input değişmez)
scoreboard players operation $sqrt_n macro.tmp = $d2d_sq macro.tmp
scoreboard players set $sqrt_lo macro.tmp 0
scoreboard players operation $sqrt_hi macro.tmp = $sqrt_n macro.tmp
execute if score $sqrt_hi macro.tmp matches 46342.. run scoreboard players set $sqrt_hi macro.tmp 46341
scoreboard players set $sqrt_itr macro.tmp 16
function macro:math/internal/sqrt_step

execute store result storage macro:output result int 1 run scoreboard players get $sqrt_lo macro.tmp
