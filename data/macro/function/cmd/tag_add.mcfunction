# macro:cmd/tag_add — Oyuncuya entity tag ekle
# INPUT: macro:input { player:"<ad>", tag:"<tag>" }

$execute as @a[name=$(player),limit=1] at @s run tag @s add $(tag)
