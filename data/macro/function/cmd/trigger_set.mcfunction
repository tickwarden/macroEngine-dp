# ============================================
# macro:cmd/trigger_set
# ============================================
# Bir oyuncunun trigger objective değerini ayarlar.
# Oyuncuların /trigger komutuyla etkileşimi için scoreboard trigger
# objective'ine değer atar.
#
# INPUT: macro:input { player:"<oyuncu>", objective:"<trigger_adı>", value:<int> }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input objective set value "macro_menu"
#   data modify storage macro:input value set value 0
#   function macro:cmd/trigger_set with storage macro:input {}
# ============================================

$scoreboard players set $(player) $(objective) $(value)
