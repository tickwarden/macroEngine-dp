# macro:cmd/give — Oyuncuya eşya ver
# INPUT: macro:input { player:"<ad>", item:"<item_id>", count:<int> }

$execute as @a[name=$(player),limit=1] at @s run give @s $(item) $(count)
