# ============================================
# macro:team/set_color
# ============================================
# Takımın rengini ayarlar.
# INPUT:  macro:input { team:"<isim>", color:"<renk>" }
# Geçerli renkler: black, dark_blue, dark_green, dark_aqua,
#   dark_red, dark_purple, gold, gray, dark_gray, blue,
#   green, aqua, red, light_purple, yellow, white, reset
# OUTPUT: —
# ============================================

$team modify $(team) color $(color)
$data modify storage macro:engine teams.$(team).color set value "$(color)"
tellraw @a[tag=macro.debug] [{"text":"[Team] ","color":"aqua"},{"text":"$(team)"},{"text":" renk -> "},{"text":"$(color)"}]
