# ============================================
# macro:flag/set
# ============================================
# Global boolean bayrak koyar. Bayrak mevcut key altında 1b olarak saklanır.
# Oyuncu-bazlı bayraklar için player/set_var kullanın.
#
# INPUT: macro:input { key:"<bayrak_adı>" }
#
# ÖRNEK:
#   data modify storage macro:input key set value "game_started"
#   function macro:flag/set with storage macro:input {}
# ============================================

$data modify storage macro:engine flags.$(key) set value 1b
