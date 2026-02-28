# ============================================
# macro:math/ceil_div
# ============================================
# Tavan bölme: ⌈a / b⌉
# INPUT:  macro:input { a:<int>, b:<int> }
# OUTPUT: macro:output { result:<int> }
#
# Formül: ⌈a/b⌉ = floor((a + b - 1) / b)
# Örnek: ceil_div(10, 3) = 4   (10/3 = 3.33... → 4)
#         ceil_div(9, 3)  = 3   (9/3  = 3.0   → 3)
# ============================================

$scoreboard players set $cdv_a macro.tmp $(a)
$scoreboard players set $cdv_b macro.tmp $(b)

# temp = b - 1
scoreboard players operation $cdv_t macro.tmp = $cdv_b macro.tmp
scoreboard players remove $cdv_t macro.tmp 1

# a = a + (b - 1)
scoreboard players operation $cdv_a macro.tmp += $cdv_t macro.tmp

# result = a / b  (integer floor division)
scoreboard players operation $cdv_a macro.tmp /= $cdv_b macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $cdv_a macro.tmp
