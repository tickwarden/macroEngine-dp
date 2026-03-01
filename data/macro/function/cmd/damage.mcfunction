# macro:cmd/damage — Oyuncuya hasar ver
# INPUT: macro:input { player:"<ad>", amount:<float>, type:"<damage_type>" }
# ÖRNEK type: "minecraft:generic", "minecraft:fall", "minecraft:magic"

$execute as @a[name=$(player),limit=1] at @s run damage @s $(amount) $(type)
