# ============================================
# macro:math/wrap
# ============================================
# Değeri [min, max) döngüsel aralıkta tutar (max dahil değil).
# Overflow durumunda başa döner; underflow durumunda sona döner.
# Rotasyon, dalga, çember indeksleme için idealdir.
#
# Formül: min + ((value - min) % range + range) % range
#
# INPUT:  macro:input { value:<int>, min:<int>, max:<int> }
# OUTPUT: macro:output { result:<int> }
#
# ÖRNEKLER:
#   wrap(value:11, min:0, max:10) → 1   (10'u geçince başa döner)
#   wrap(value:-1, min:0, max:10) → 9   (0'ın altına inince sona döner)
#   wrap(value:5,  min:0, max:10) → 5   (aralık içinde, değişmez)
#   wrap(value:7,  min:3, max:8 ) → 7
#   wrap(value:9,  min:3, max:8 ) → 4   (8'i geçince 3'ten devam eder)
# ============================================

$scoreboard players set $wrap_v macro.tmp $(value)
$scoreboard players set $wrap_min macro.tmp $(min)
$scoreboard players set $wrap_max macro.tmp $(max)

# range = max - min
scoreboard players operation $wrap_r macro.tmp = $wrap_max macro.tmp
scoreboard players operation $wrap_r macro.tmp -= $wrap_min macro.tmp

# range <= 0 ise geçersiz — min döndür
execute if score $wrap_r macro.tmp matches ..0 run execute store result storage macro:output result int 1 run scoreboard players get $wrap_min macro.tmp
execute if score $wrap_r macro.tmp matches ..0 run return 0

# offset = value - min
scoreboard players operation $wrap_off macro.tmp = $wrap_v macro.tmp
scoreboard players operation $wrap_off macro.tmp -= $wrap_min macro.tmp

# Java modulo (negatif koruma)
scoreboard players operation $wrap_off macro.tmp %= $wrap_r macro.tmp
execute if score $wrap_off macro.tmp matches ..-1 run scoreboard players operation $wrap_off macro.tmp += $wrap_r macro.tmp

# result = min + offset
scoreboard players operation $wrap_off macro.tmp += $wrap_min macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $wrap_off macro.tmp
