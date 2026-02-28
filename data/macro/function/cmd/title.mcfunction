# macro:cmd/title — Oyuncuya title göster
# INPUT: macro:input { player:"<ad>", text:"<metin>", color:"<renk>" }

$execute as @a[name=$(player),limit=1] at @s run title @s title {"text":"$(text)","color":"$(color)"}
