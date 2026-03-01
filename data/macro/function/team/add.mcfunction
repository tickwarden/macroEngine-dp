# ============================================
# macro:team/add
# ============================================
# Oyuncuyu takıma ekler.
# INPUT:  macro:input { team:"<isim>", player:"<oyuncu>" }
# OUTPUT: —
# ============================================

$team join $(team) $(player)
$tellraw @a[tag=macro.debug] [{"text":"[Team] ","color":"aqua"},{"text":"$(player)","color":"white"},{"text":" -> "},{"text":"$(team)","color":"aqua"}]
