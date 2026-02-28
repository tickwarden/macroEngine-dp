# macro:cmd/tp — Oyuncuyu koordinata ışınla
# INPUT: macro:input { player:"<ad>", x:<float>, y:<float>, z:<float> }

$execute as @a[name=$(player),limit=1] at @s run tp @s $(x) $(y) $(z)
