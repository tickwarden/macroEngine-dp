# ============================================
# macro:team/delete
# ============================================
# Takımı oyundan ve storage'dan siler.
# INPUT:  macro:input { team:"<isim>" }
# OUTPUT: —
# ============================================

$team remove $(team)
$data remove storage macro:engine teams.$(team)
$tellraw @a[tag=macro.debug] [{"text":"[Team] Silindi: ","color":"red"},{"text":"$(team)","color":"white"}]
