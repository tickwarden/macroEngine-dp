# macro:debug/engine_macro/internal/adv_consumer [MACRO]
# Called by macro:engine/macro/with_advancement.
# Receives: $(done) — 1b if minecraft:story/mine_stone is complete, 0b otherwise.
# Both outcomes are valid — result depends on the player's progress.

execute if data storage macro:engine _macro_pipe{done:1b} run tellraw @s ["",{"text":"    result: ","color":"#555555"},{"text":"done=1b  ","color":"green"},{"text":"✔ advancement completed","color":"green"}]
execute if data storage macro:engine _macro_pipe{done:0b} run tellraw @s ["",{"text":"    result: ","color":"#555555"},{"text":"done=0b  ","color":"gray"},{"text":"✘ advancement not yet completed","color":"#555555"}]
