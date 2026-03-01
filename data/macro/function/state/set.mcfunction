# ============================================
# macro:state/set
# ============================================
# Bir oyuncuya durum (state) atar.
# Aynı oyuncu için bir önceki durum üzerine yazar.
# Durum makinesi, oyun fazları, NPC davranışları için idealdir.
#
# INPUT: macro:input { player:"<oyuncu_adı>", state:"<durum>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input state set value "combat"
#   function macro:state/set with storage macro:input {}
# ============================================

$data modify storage macro:engine states.$(player) set value "$(state)"
