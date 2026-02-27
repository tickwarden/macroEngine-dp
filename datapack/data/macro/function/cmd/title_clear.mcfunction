# macro:cmd/title_clear — Aktif title'ı kaldır
# INPUT: macro:input { player:"<ad>" }

$execute as @a[name=$(player),limit=1] at @s run title @s clear
