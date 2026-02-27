# ============================================
# macro:config/delete
# ============================================
# Config'den belirli bir key'i siler.
# INPUT:  macro:input { key:"<anahtar>" }
# OUTPUT: —
# ============================================

$data remove storage macro:engine config.$(key)
tellraw @a[tag=macro.debug] [{"text":"[Config] Silindi: ","color":"red"},{"text":"$(key)","color":"white"}]
