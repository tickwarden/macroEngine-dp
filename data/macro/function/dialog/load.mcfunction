# ============================================
# macro:dialog/load  [base — 1.21.1 fallback]
# ============================================
# Starts a loading dialog with the given cooldown (ticks).
# After the cooldown elapses, macro:dialog/open fires automatically.
#
# INPUT: macro:input { cooldown:<int> }   (default: 20 ticks)
# EXAMPLE:
#   data modify storage macro:input cooldown set value 40
#   function macro:dialog/load
# ============================================

return run tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}
