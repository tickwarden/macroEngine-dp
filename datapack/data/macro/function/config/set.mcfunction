# ============================================
# macro:config/set
# ============================================
# Config'e string değer yazar.
# Tam sayılar için macro:config/set_int kullanın.
# INPUT:  macro:input { key:"<anahtar>", value:"<değer>" }
# OUTPUT: —
# ============================================

$data modify storage macro:engine config.$(key) set value "$(value)"
$tellraw @a[tag=macro.debug] [{"text":"[Config] ","color":"yellow"},{"text":"$(key)","color":"white"},{"text":" = "},{"text":"$(value)","color":"green"}]
