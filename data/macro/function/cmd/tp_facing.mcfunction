# macro:cmd/tp_facing — Oyuncuyu koordinata ışınla ve belirli yöne baktır
# INPUT: macro:input { player:"<ad>", x:<float>, y:<float>, z:<float>,
#                      fx:<float>, fy:<float>, fz:<float> }

$execute as @a[name=$(player),limit=1] at @s run tp @s $(x) $(y) $(z) facing $(fx) $(fy) $(fz)
