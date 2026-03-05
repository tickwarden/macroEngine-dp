# macro:dialog/open  [-1_21_4 overlay — base fallback]
# Overrides base for pack_format ≤ 61 (≤ 1.21.4).
# Uses legacy clickEvent/hoverEvent syntax.
# BUG FIX v1.0.6-pre1: Removed erroneous `return run tellraw` that made
# all fallback code unreachable. The fallback chat-based dialog now runs.

execute unless data storage macro:engine dialog.DIALOG run return 0

scoreboard players set @s macro.dialog_load -1
tag @s remove macro.dialog_closed
tag @s remove macro.dialog_opened
tag @s add macro.dialog_opened

tellraw @s ["",{"text":"[AME] ","color":"aqua","bold":true},{"text":"Dialog: ","color":"gray"},{"nbt":"dialog.DIALOG","storage":"macro:engine","color":"yellow"},{"text":" — ","color":"dark_gray"},{"text":"[Load]","color":"green","bold":true,"underlined":true,"clickEvent":{"action":"run_command","value":"/function macro:load"},"hoverEvent":{"action":"show_text","value":{"text":"Upgrade to 1.21.6+ for native dialog support","color":"gray"}}}]

return 1
