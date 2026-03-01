# macro:cmd/gamemode — Oyuncunun oyun modunu değiştir
# INPUT: macro:input { player:"<ad>", mode:"<survival|creative|adventure|spectator>" }

$execute as @a[name=$(player),limit=1] at @s run gamemode $(mode) @s
