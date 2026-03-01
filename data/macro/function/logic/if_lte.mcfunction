# ============================================
# macro:logic/if_lte
# ============================================
# a <= b ise func'ı çalıştırır.
# INPUT: macro:input { a:<int>, b:<int>, func:"<namespace:path>" }
# ============================================

$scoreboard players set $if_a macro.tmp $(a)
$scoreboard players set $if_b macro.tmp $(b)
# BUG FIX: "run $function $(func)" → "run function $(func)"
$execute if score $if_a macro.tmp <= $if_b macro.tmp run function $(func)
