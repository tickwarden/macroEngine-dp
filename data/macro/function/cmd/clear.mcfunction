# macro:cmd/clear — Oyuncunun envanterini temizle
# INPUT: macro:input { player:"<ad>" }

$execute as @a[name=$(player),limit=1] at @s run clear @s
