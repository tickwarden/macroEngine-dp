# ============================================
# macro:config/set_int
# ============================================
# Config'e tam sayı değer yazar.
# String değerler için macro:config/set kullanın.
# INPUT:  macro:input { key:"<anahtar>", value:<int> }
# OUTPUT: —
# ============================================

$execute store result storage macro:engine config.$(key) int 1 run scoreboard players set $cfg_tmp macro.tmp $(value)
tellraw @a[tag=macro.debug] [{"text":"[Config] ","color":"yellow"},{"text":"$(key)","color":"white"},{"text":" = "},{"text":"$(value)","color":"gold"}]
