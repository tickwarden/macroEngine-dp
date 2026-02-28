# macro:cmd/attribute_get — Oyuncunun attribute değerini oku
# INPUT: macro:input { player:"<ad>", attribute:"<attribute_id>" }
# OUTPUT: macro:output { result:<float> }
# ÖRNEK attribute: "minecraft:generic.max_health", "minecraft:generic.movement_speed"

$execute store result storage macro:output result double 1 run attribute @a[name=$(player),limit=1] $(attribute) get
