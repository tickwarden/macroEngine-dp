# ============================================
# macro:math/log2
# ============================================
# 2 tabanında tamsayı logaritma: floor(log₂(value))
# Bit uzunluğu bulmak, ikinin katını tespit etmek için kullanılır.
#
# Algoritma: Bit shift benzetimi — değer 1'e düşene kadar 2'ye böl, sayacı artır.
# 31 iterasyon yeterlidir (2^31 > INT_MAX).
#
# INPUT:  macro:input { value:<int> }
# OUTPUT: macro:output { result:<int> }
#         result = -1 → value <= 0 (tanımsız)
#
# ÖRNEKLER:
#   log2(1)   → 0
#   log2(2)   → 1
#   log2(4)   → 2
#   log2(7)   → 2   (floor)
#   log2(8)   → 3
#   log2(1024)→ 10
# ============================================

$scoreboard players set $lg2_v macro.tmp $(value)

# value <= 0 → tanımsız, -1 döndür
execute if score $lg2_v macro.tmp matches ..0 run data modify storage macro:output result set value -1
execute if score $lg2_v macro.tmp matches ..0 run return 0

scoreboard players set $lg2_r macro.tmp 0
scoreboard players set $lg2_2 macro.tmp 2

# Bit kaydırma benzetimi: değer >= 2 olduğu sürece 2'ye böl, sayacı artır
function macro:math/internal/log2_loop

execute store result storage macro:output result int 1 run scoreboard players get $lg2_r macro.tmp
