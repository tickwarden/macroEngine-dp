# ─────────────────────────────────────────────────────────────────
#  macro:math/lcm
#  EKOK (LCM) hesaplar: lcm(a,b) = |a*b| / gcd(a,b)
#  Girdi : $(a), $(b)          → tam sayılar
#  Çıktı : macro:output result → LCM(a, b)
#  NOT   : Taşma riski — büyük sayılarda sonuç INT_MAX'ı aşabilir.
#
#  Örnek:
#    data modify storage macro:input a set value 12
#    data modify storage macro:input b set value 8
#    function macro:math/lcm with storage macro:input {}
#    # macro:output result = 24
# ─────────────────────────────────────────────────────────────────

$scoreboard players set $lcm_a macro.tmp $(a)
$scoreboard players set $lcm_b macro.tmp $(b)

# Sıfır kontrolü
execute if score $lcm_a macro.tmp matches 0 run data modify storage macro:output result set value 0
execute if score $lcm_a macro.tmp matches 0 run return 0
execute if score $lcm_b macro.tmp matches 0 run data modify storage macro:output result set value 0
execute if score $lcm_b macro.tmp matches 0 run return 0

# Mutlak değer
scoreboard players set $lcm_neg macro.tmp -1
execute if score $lcm_a macro.tmp matches ..-1 run scoreboard players operation $lcm_a macro.tmp *= $lcm_neg macro.tmp
execute if score $lcm_b macro.tmp matches ..-1 run scoreboard players operation $lcm_b macro.tmp *= $lcm_neg macro.tmp

# GCD hesapla (lcm_a, lcm_b → gcd_a, gcd_b değişkenlerini paylaşır)
scoreboard players operation $gcd_a macro.tmp = $lcm_a macro.tmp
scoreboard players operation $gcd_b macro.tmp = $lcm_b macro.tmp
function macro:math/internal/gcd_loop

# lcm = (a / gcd) * b  (taşmayı önlemek için önce böl)
scoreboard players operation $lcm_a macro.tmp /= $gcd_a macro.tmp
scoreboard players operation $lcm_a macro.tmp *= $lcm_b macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $lcm_a macro.tmp
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"math/lcm ","color":"aqua"},{"text":"($(a),$(b)) → ","color":"gray"},{"storage":"macro:output","nbt":"result","color":"green"}]
