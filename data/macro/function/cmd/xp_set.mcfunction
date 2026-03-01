# macro:cmd/xp_set — Oyuncunun XP'sini ayarla
# INPUT: macro:input { player:"<ad>", amount:<int>, type:"points"|"levels" }

$execute as @a[name=$(player),limit=1] run xp set @s $(amount) $(type)
