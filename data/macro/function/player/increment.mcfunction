# macro:player/increment — Değişkeni 1 artır (kısayol)
# INPUT: macro:input { player:"<ad>", key:"<değişken>" }
# OUTPUT: macro:output { result:<yeni değer> }
# BUG FIX v2.5: macro:input.amount artık kirletilmiyor; doğrudan scoreboard ile ekleme yapılır.

$execute store result score $pvar macro.tmp run data get storage macro:engine players.$(player).$(key)
scoreboard players add $pvar macro.tmp 1
$execute store result storage macro:engine players.$(player).$(key) int 1 run scoreboard players get $pvar macro.tmp
execute store result storage macro:output result int 1 run scoreboard players get $pvar macro.tmp
