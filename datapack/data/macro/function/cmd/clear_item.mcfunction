# macro:cmd/clear_item — Oyuncudan belirli eşyayı kaldır
# INPUT: macro:input { player:"<ad>", item:"<item_id>", count:<int> }

$execute as @a[name=$(player),limit=1] at @s run clear @s $(item) $(count)
