# macro:cmd/bossbar_add — Yeni bossbar oluştur
# INPUT: macro:input { id:"<namespace:id>", text:"<başlık>", color:"<renk>" }
# color: pink, blue, red, green, yellow, purple, white

$bossbar add $(id) {"text":"$(text)"}
$bossbar set $(id) color $(color)
