# ============================================
# macro:cmd/msg_raw
# ============================================
# Belirtilen oyuncuya ham JSON tellraw mesajı gönderir.
# Renk, format ve bileşik mesajlar için msg yerine kullanın.
#
# INPUT: macro:input { player:"<hedef>", json:"<JSON_metin>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input json set value "[{\"text\":\"Merhaba \",\"color\":\"gold\"},{\"text\":\"Steve!\",\"bold\":true}]"
#   function macro:cmd/msg_raw with storage macro:input {}
# ============================================

$tellraw $(player) $(json)
