# ============================================
# macro:math/map
# ============================================
# Bir değeri [in_min, in_max] aralığından [out_min, out_max] aralığına eşler.
# Lineer interpolasyon kullanır (lerp tabanlı).
# Tamsayı aritmetiği nedeniyle küçük aralıklarda hassasiyet kaybı olabilir.
#
# Formül: out_min + (value - in_min) * (out_max - out_min) / (in_max - in_min)
#
# INPUT:  macro:input { value:<int>, in_min:<int>, in_max:<int>, out_min:<int>, out_max:<int> }
# OUTPUT: macro:output { result:<int> }
#
# ÖRNEK:
#   # Oyuncunun canını (0-20) 0-100 arası yüzdeye çevir
#   data modify storage macro:input value set value 14
#   data modify storage macro:input in_min set value 0
#   data modify storage macro:input in_max set value 20
#   data modify storage macro:input out_min set value 0
#   data modify storage macro:input out_max set value 100
#   function macro:math/map with storage macro:input {}
#   # → result = 70
# ============================================

$scoreboard players set $map_v macro.tmp $(value)
$scoreboard players set $map_imin macro.tmp $(in_min)
$scoreboard players set $map_imax macro.tmp $(in_max)
$scoreboard players set $map_omin macro.tmp $(out_min)
$scoreboard players set $map_omax macro.tmp $(out_max)

# in_range = in_max - in_min
scoreboard players operation $map_ir macro.tmp = $map_imax macro.tmp
scoreboard players operation $map_ir macro.tmp -= $map_imin macro.tmp

# in_range == 0 ise bölme sıfır hatası — out_min döndür
execute if score $map_ir macro.tmp matches 0 run execute store result storage macro:output result int 1 run scoreboard players get $map_omin macro.tmp
execute if score $map_ir macro.tmp matches 0 run return 0

# out_range = out_max - out_min
scoreboard players operation $map_or macro.tmp = $map_omax macro.tmp
scoreboard players operation $map_or macro.tmp -= $map_omin macro.tmp

# offset = value - in_min
scoreboard players operation $map_off macro.tmp = $map_v macro.tmp
scoreboard players operation $map_off macro.tmp -= $map_imin macro.tmp

# result = out_min + offset * out_range / in_range
scoreboard players operation $map_off macro.tmp *= $map_or macro.tmp
scoreboard players operation $map_off macro.tmp /= $map_ir macro.tmp
scoreboard players operation $map_off macro.tmp += $map_omin macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $map_off macro.tmp
