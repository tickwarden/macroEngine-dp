# ============================================
# macro:cooldown/clear
# ============================================
# Belirtilen cooldown'u siler.
# INPUT: macro:input { player:"<ad>", key:"<cooldown>" }
# ============================================

$data remove storage macro:engine cooldowns.$(player).$(key)
