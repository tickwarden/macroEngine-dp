# ============================================
# macro:dialog/load  [1.21.6 — native dialog]
# ============================================
# Starts a loading dialog with the given cooldown (ticks).
#
# INPUT: macro:input { cooldown:<int> }   (default: 20 ticks)
# ============================================

execute unless data storage macro:input cooldown run data modify storage macro:input cooldown set value 20
function macro:dialog/internal/load_exec with storage macro:input {}
