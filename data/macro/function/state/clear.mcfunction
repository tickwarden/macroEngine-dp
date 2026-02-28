# ============================================
# macro:state/clear
# ============================================
# Oyuncunun durumunu siler (durum "yok" hale gelir).
#
# INPUT: macro:input { player:"<oyuncu_adı>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   function macro:state/clear with storage macro:input {}
# ============================================

$data remove storage macro:engine states.$(player)
