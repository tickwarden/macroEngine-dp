# ============================================
# macro:player/set_var
# ============================================
# KULLANIM:
#   function macro:player/set_var with storage macro:input {}
#   Gerekli input storage alanları:
#     macro:input { player:"<oyuncuAdı>", key:"<değişkenAdı>", value:<değer> }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input key set value "coins"
#   data modify storage macro:input value set value 100
#   function macro:player/set_var with storage macro:input {}
# ============================================

$data modify storage macro:engine players.$(player).$(key) set value $(value)
