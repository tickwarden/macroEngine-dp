# macro:cmd/locate_structure — Belirtilen oyuncunun konumundan yapı ara
# INPUT: macro:input { player:"<ad>", structure:"<structure_id>" }
# ÖRNEK: structure:"minecraft:village_plains"
# Sonuç sohbete yazdırılır; output capture yoktur (vanilla sınırı)

$execute as @a[name=$(player),limit=1] at @s run locate structure $(structure)
