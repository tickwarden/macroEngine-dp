# ============================================
# macro:state/get
# ============================================
# Oyuncunun mevcut durumunu döndürür.
#
# INPUT:  macro:input { player:"<oyuncu_adı>" }
# OUTPUT: macro:output { result:"<durum>" }  (durum yoksa result = null)
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   function macro:state/get with storage macro:input {}
#   # macro:output.result → "combat" (veya mevcut durum)
# ============================================

data remove storage macro:output result
$execute if data storage macro:engine states.$(player) run data modify storage macro:output result set from storage macro:engine states.$(player)
