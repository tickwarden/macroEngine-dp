# macro:cmd/effect_clear_one — Belirli bir efekti temizle
# INPUT: macro:input { player:"<ad>", effect:"<effect_id>" }

$execute as @a[name=$(player),limit=1] at @s run effect clear @s $(effect)
