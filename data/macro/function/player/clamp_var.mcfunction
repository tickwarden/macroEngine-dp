# macro:player/clamp_var — Oyuncunun değişkenini min..max aralığına sınırla
# add_to_var veya set_var sonrası taşmayı engellemek için kullanılır.
# INPUT: macro:input { player:"<ad>", key:"<değişken>", min:<int>, max:<int> }
# OUTPUT: macro:output { result:<sınırlanmış değer> }

$execute store result score $cv macro.tmp run data get storage macro:engine players.$(player).$(key)
$scoreboard players set $cv_mn macro.tmp $(min)
$scoreboard players set $cv_mx macro.tmp $(max)
execute if score $cv macro.tmp < $cv_mn macro.tmp run scoreboard players operation $cv macro.tmp = $cv_mn macro.tmp
execute if score $cv macro.tmp > $cv_mx macro.tmp run scoreboard players operation $cv macro.tmp = $cv_mx macro.tmp
$execute store result storage macro:engine players.$(player).$(key) int 1 run scoreboard players get $cv macro.tmp
execute store result storage macro:output result int 1 run scoreboard players get $cv macro.tmp
