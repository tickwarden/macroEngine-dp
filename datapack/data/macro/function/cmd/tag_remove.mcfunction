# macro:cmd/tag_remove — Oyuncudan entity tag kaldır
# INPUT: macro:input { player:"<ad>", tag:"<tag>" }

$execute as @a[name=$(player),limit=1] at @s run tag @s remove $(tag)
