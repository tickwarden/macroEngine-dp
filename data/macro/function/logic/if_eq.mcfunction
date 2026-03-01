# ============================================
# macro:logic/if_eq
# ============================================
# a == b ise func'ı çalıştırır.
# INPUT: macro:input { a:<int>, b:<int>, func:"<namespace:path>" }
# ÖRNEK:
#   data modify storage macro:input a set value 10
#   data modify storage macro:input b set value 10
#   data modify storage macro:input func set value "mypack:on_equal"
#   function macro:logic/if_eq with storage macro:input {}
# ============================================

$scoreboard players set $if_a macro.tmp $(a)
$scoreboard players set $if_b macro.tmp $(b)
# BUG FIX: "run $function $(func)" → "run function $(func)"
$execute if score $if_a macro.tmp = $if_b macro.tmp run function $(func)
