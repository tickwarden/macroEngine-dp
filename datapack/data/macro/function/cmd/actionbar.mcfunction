# macro:cmd/actionbar — Oyuncuya actionbar mesajı göster
# INPUT: macro:input { player:"<ad>", text:"<metin>", color:"<renk>" }

$execute as @a[name=$(player),limit=1] at @s run title @s actionbar {"text":"$(text)","color":"$(color)"}
