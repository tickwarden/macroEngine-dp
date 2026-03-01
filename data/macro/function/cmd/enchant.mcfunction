# macro:cmd/enchant — Oyuncunun elindeki eşyayı büyüle
# INPUT: macro:input { player:"<ad>", enchantment:"<enchant_id>", level:<int> }
# ÖRNEK: enchantment:"minecraft:sharpness", level:5

$execute as @a[name=$(player),limit=1] run enchant @s $(enchantment) $(level)
