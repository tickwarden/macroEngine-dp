# ============================================
# macro:math/max
# ============================================
# İki tamsayının büyüğünü döndürür.
# INPUT:  macro:input { a:<int>, b:<int> }
# OUTPUT: macro:output { result:<int> }
#
# ÖRNEK:
#   data modify storage macro:input a set value 42
#   data modify storage macro:input b set value 17
#   function macro:math/max with storage macro:input {}
#   # → result: 42
# ============================================

$scoreboard players set $max_a macro.tmp $(a)
$scoreboard players set $max_b macro.tmp $(b)

# Başlangıç: result = a
execute store result storage macro:output result int 1 run scoreboard players get $max_a macro.tmp

# b > a ise result = b
execute if score $max_b macro.tmp > $max_a macro.tmp run execute store result storage macro:output result int 1 run scoreboard players get $max_b macro.tmp
