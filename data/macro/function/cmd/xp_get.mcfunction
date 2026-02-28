# macro:cmd/xp_get — Oyuncunun XP seviyesini oku
# INPUT: macro:input { player:"<ad>", type:"levels"|"points" }
# OUTPUT: macro:output { result:<int> }

$execute store result storage macro:output result int 1 run xp query @a[name=$(player),limit=1] $(type)
