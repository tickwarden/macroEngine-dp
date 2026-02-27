# macro:cmd/loot_give — Loot tablosundan eşya ver
# INPUT: macro:input { player:"<ad>", loot_table:"<namespace:path>" }
# ÖRNEK: loot_table:"minecraft:chests/simple_dungeon"

$execute as @a[name=$(player),limit=1] run loot give @s loot $(loot_table)
