# ============================================
# macro:cooldown/clear_all
# ============================================
# Oyuncunun tüm cooldown'larını siler.
# INPUT: macro:input { player:"<ad>" }
# ============================================

$data remove storage macro:engine cooldowns.$(player)
