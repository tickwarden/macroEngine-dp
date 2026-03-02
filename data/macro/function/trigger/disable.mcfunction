# ============================================
# macro:trigger/disable
# ============================================
# Bir oyuncunun macro_action trigger'ını devre dışı bırakır.
# Skor sıfırlanır ve yeniden etkinleştirilmez.
#
# INPUT: macro:input { player:"<oyuncu_adı>" }
#
# ÖRNEK:
# data modify storage macro:input player set value "Steve"
# function macro:trigger/disable with storage macro:input {}
# ============================================

$scoreboard players reset $(player) macro_action
