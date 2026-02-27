# macro:cmd/title_reset — Title sürelerini varsayılana döndür
# INPUT: macro:input { player:"<ad>" }

$execute as @a[name=$(player),limit=1] at @s run title @s reset
