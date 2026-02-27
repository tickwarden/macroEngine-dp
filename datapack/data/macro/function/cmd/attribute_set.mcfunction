# macro:cmd/attribute_set — Oyuncunun attribute base değerini ayarla
# INPUT: macro:input { player:"<ad>", attribute:"<attribute_id>", value:<float> }
# ÖRNEK: attribute:"minecraft:generic.max_health", value:40 → 20 kalp max

$execute as @a[name=$(player),limit=1] run attribute @s $(attribute) base set $(value)
