# ============================================
# macro:dialog/show  [base — 1.21.1 fallback]
# ============================================
# 1.21.6+ overlay shows a native Minecraft dialog.
# Below pack_format 80 there is no dialog API;
# fall back to a tellraw with clickable commands.
# ============================================

return run tellraw @s {"text":"This feature requires 1.21.5 or higher!","color":"red","italic":false}
