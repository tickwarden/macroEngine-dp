# ============================================
# macro:trigger/enable
# ============================================
# Belirli bir oyuncuya macro_action trigger'ını açar.
# Oyuncu /trigger macro_action set <N> yazabilir hâle gelir.
#
# INPUT: macro:input { player:"<oyuncu_adı>" }
#
# ÖRNEK:
# data modify storage macro:input player set value "Steve"
# function macro:trigger/enable with storage macro:input {}
#
# Tüm oyunculara açmak için:
# scoreboard players enable @a macro_action
# ============================================

$scoreboard players enable $(player) macro_action
