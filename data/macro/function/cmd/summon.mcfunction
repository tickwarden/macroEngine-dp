# macro:cmd/summon — Varlık çağır
# INPUT: macro:input { entity:"<entity_id>", x:<float>, y:<float>, z:<float>, nbt:"{}" }
# ÖRNEK: entity:"minecraft:zombie", x:10, y:64, z:10, nbt:"{}"

$summon $(entity) $(x) $(y) $(z) $(nbt)
