# macro:cmd/sound — Oyuncuya ses çal
# INPUT: macro:input { player:"<ad>", sound:"<sound_id>", volume:<float>, pitch:<float> }
# ÖRNEK: sound:"minecraft:entity.player.levelup", volume:1, pitch:1

$execute as @a[name=$(player),limit=1] at @s run playsound $(sound) master @s ~ ~ ~ $(volume) $(pitch)
