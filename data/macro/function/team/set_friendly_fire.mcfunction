# ============================================
# macro:team/set_friendly_fire
# ============================================
# Takım içi hasar (friendly fire) ayarı.
# INPUT:  macro:input { team:"<isim>", value:"true" | "false" }
# OUTPUT: —
# ============================================

$team modify $(team) friendlyFire $(value)
$data modify storage macro:engine teams.$(team).friendly_fire set value "$(value)"
$tellraw @a[tag=macro.debug] [{"text":"[Team] ","color":"aqua"},{"text":"$(team)"},{"text":" friendlyFire -> "},{"text":"$(value)"}]
