# ============================================
# macro:dialog/open  [base — 1.21.1–1.21.4 fallback]
# ============================================
# 1.21.6+ overlay overrides this with the native dialog API.
# Below pack_format 62 there is no dialog API; we fall back
# to a chat-based prompt so the engine does not crash.
#
# BUG FIX v1.0.6-pre1: Previously set macro.dialog_opened tag
# before the error return, permanently blocking future open calls.
# Tags are no longer touched in the error path.
# ============================================

execute unless data storage macro:engine dialog.DIALOG run return 0

scoreboard players set @s macro.dialog_load -1
tag @s remove macro.dialog_closed
tag @s remove macro.dialog_opened
tag @s add macro.dialog_opened

tellraw @s ["",{"text":"[AME] ","color":"aqua","bold":true},{"text":"Dialog: ","color":"gray"},{"nbt":"dialog.DIALOG","storage":"macro:engine","color":"yellow"},{"text":" — ","color":"dark_gray"},{"text":"This feature requires Minecraft 1.21.5 or higher.","color":"red","italic":true}]

return 1
