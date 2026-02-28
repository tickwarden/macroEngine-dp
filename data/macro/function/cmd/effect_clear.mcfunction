# macro:cmd/effect_clear — Oyuncunun tüm efektlerini temizle
# INPUT: macro:input { player:"<ad>" }

$execute as @a[name=$(player),limit=1] at @s run effect clear @s
