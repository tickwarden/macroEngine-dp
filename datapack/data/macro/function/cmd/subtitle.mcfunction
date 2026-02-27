# macro:cmd/subtitle — Oyuncuya subtitle göster
# INPUT: macro:input { player:"<ad>", text:"<metin>", color:"<renk>" }

$execute as @a[name=$(player),limit=1] at @s run title @s subtitle {"text":"$(text)","color":"$(color)"}
