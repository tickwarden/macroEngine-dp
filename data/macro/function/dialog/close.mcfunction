# ============================================
# macro:dialog/close  [base — 1.21.1 fallback]
# ============================================
# 1.21.6+ overlay uses native "dialog clear @s".
# Below pack_format 80 we just clean up the tags
# so the engine state stays consistent.
# ============================================

return run tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}

tag @s remove macro.dialog_opened
tag @s add macro.dialog_closed
