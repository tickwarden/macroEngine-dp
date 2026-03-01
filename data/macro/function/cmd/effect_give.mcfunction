# macro:cmd/effect_give — Oyuncuya efekt ver
# INPUT: macro:input { player:"<ad>", effect:"<effect_id>", duration:<tick>, amplifier:<int> }
# ÖRNEK: effect:"minecraft:speed", duration:200, amplifier:1

$execute as @a[name=$(player),limit=1] at @s run effect give @s $(effect) $(duration) $(amplifier) true
