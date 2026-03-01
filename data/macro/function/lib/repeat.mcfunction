# ============================================
# macro:lib/repeat
# ============================================
# Bir fonksiyonu N kez çalıştırır.
# Her iterasyonda macro:engine _repeat.i artar (0'dan başlar).
#
# INPUT: macro:input { func:"<namespace:path>", count:<int> }
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:loop/step"
#   data modify storage macro:input count set value 10
#   function macro:lib/repeat with storage macro:input {}
# ============================================

$data modify storage macro:engine _repeat.func set value "$(func)"
$scoreboard players set $rep_n macro.tmp $(count)
# Sayaç sıfırla
scoreboard players set $rep_i macro.tmp 0
execute store result storage macro:engine _repeat.i int 1 run scoreboard players get $rep_i macro.tmp
execute store result storage macro:engine _repeat.remaining int 1 run scoreboard players get $rep_n macro.tmp
function macro:lib/internal/repeat_run
data remove storage macro:engine _repeat
