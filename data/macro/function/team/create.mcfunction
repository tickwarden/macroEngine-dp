# ============================================
# macro:team/create
# ============================================
# Yeni bir takım oluşturur ve storage'a kaydeder.
# INPUT:  macro:input { team:"<isim>" }
# OUTPUT: —
#
# Renk ve display için: macro:team/set_color, set_display
# Zaten varsa: team add sessizce başarısız olur (güvenli).
# ============================================

$team add $(team)
$data modify storage macro:engine teams.$(team) set value {color:"white",friendly_fire:1b,see_friendly_invisibles:0b}
tellraw @a[tag=macro.debug] [{"text":"[Team] Olusturuldu: ","color":"aqua"},{"text":"$(team)","color":"white"}]
