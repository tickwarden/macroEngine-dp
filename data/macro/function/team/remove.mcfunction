# ============================================
# macro:team/remove
# ============================================
# Oyuncuyu bulunduğu takımdan çıkarır.
# INPUT:  macro:input { player:"<oyuncu>" }
# OUTPUT: —
# ============================================

$team leave $(player)
$tellraw @a[tag=macro.debug] [{"text":"[Team] ","color":"gray"},{"text":"$(player)","color":"white"},{"text":" takimdan cikti.","color":"gray"}]
