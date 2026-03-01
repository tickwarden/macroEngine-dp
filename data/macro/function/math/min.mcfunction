# ============================================
# macro:math/min
# ============================================
# İki tamsayının küçüğünü döndürür.
# INPUT:  macro:input { a:<int>, b:<int> }
# OUTPUT: macro:output { result:<int> }
#
# ÖRNEK:
#   data modify storage macro:input a set value 42
#   data modify storage macro:input b set value 17
#   function macro:math/min with storage macro:input {}
#   # → result: 17
# ============================================

$scoreboard players set $min_a macro.tmp $(a)
$scoreboard players set $min_b macro.tmp $(b)

# Başlangıç: result = a
execute store result storage macro:output result int 1 run scoreboard players get $min_a macro.tmp

# b < a ise result = b
execute if score $min_b macro.tmp < $min_a macro.tmp run execute store result storage macro:output result int 1 run scoreboard players get $min_b macro.tmp
