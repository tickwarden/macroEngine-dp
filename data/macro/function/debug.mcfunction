# ═══════════════════════════════
#   macroEngine Debug Utilities
# ═══════════════════════════════

# Header
tellraw @s ["",{"text":"══ ","color":"dark_aqua"},{"text":"macroEngine Debug","color":"aqua","bold":true},{"text":" ══","color":"dark_aqua"}]

# ── macro:engine ──
tellraw @s {"text":"[ macro:engine ]","color":"dark_aqua","bold":true}

tellraw @s ["",{"text":"  global   » ","color":"gray"},{"storage":"macro:engine","nbt":"global","color":"aqua","italic":false}]
tellraw @s ["",{"text":"  players  » ","color":"gray"},{"storage":"macro:engine","nbt":"players","color":"aqua","italic":false}]
tellraw @s ["",{"text":"  cooldown » ","color":"gray"},{"storage":"macro:engine","nbt":"cooldowns","color":"yellow","italic":false}]
tellraw @s ["",{"text":"  queue    » ","color":"gray"},{"storage":"macro:engine","nbt":"queue","color":"gold","italic":false}]
tellraw @s ["",{"text":"  events   » ","color":"gray"},{"storage":"macro:engine","nbt":"events","color":"light_purple","italic":false}]
tellraw @s ["",{"text":"  config   » ","color":"gray"},{"storage":"macro:engine","nbt":"config","color":"green","italic":false}]

# ── macro:input / macro:output ──
tellraw @s {"text":"[ I/O ]","color":"dark_green","bold":true}

tellraw @s ["",{"text":"  input  » ","color":"gray"},{"storage":"macro:input","nbt":"","color":"green","italic":false}]
tellraw @s ["",{"text":"  output » ","color":"gray"},{"storage":"macro:output","nbt":"","color":"red","italic":false}]

# Separator
tellraw @s {"text":"────────────────────","color":"dark_gray"}
