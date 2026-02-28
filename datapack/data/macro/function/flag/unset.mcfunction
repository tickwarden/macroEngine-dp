# ============================================
# macro:flag/unset
# ============================================
# Global bayrağı kaldırır.
#
# INPUT: macro:input { key:"<bayrak_adı>" }
#
# ÖRNEK:
#   data modify storage macro:input key set value "game_started"
#   function macro:flag/unset with storage macro:input {}
# ============================================

$data remove storage macro:engine flags.$(key)
