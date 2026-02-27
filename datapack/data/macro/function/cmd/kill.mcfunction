# macro:cmd/kill — Oyuncuyu öldür
# INPUT: macro:input { player:"<ad>" }

$execute as @a[name=$(player),limit=1] at @s run kill @s
