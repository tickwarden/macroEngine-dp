# ============================================
# macro:math/sign
# ============================================
# Sayinin isaretini dondurur.
# INPUT:  macro:input { value:<int> }
# OUTPUT: macro:output { result: -1 | 0 | 1 }
# ============================================

$scoreboard players set $sign_v macro.tmp $(value)
execute if score $sign_v macro.tmp matches 1.. run data modify storage macro:output result set value 1
execute if score $sign_v macro.tmp matches 0 run data modify storage macro:output result set value 0
execute if score $sign_v macro.tmp matches ..-1 run data modify storage macro:output result set value -1
