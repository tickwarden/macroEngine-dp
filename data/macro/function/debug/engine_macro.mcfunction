# macro:debug/engine_macro [MACRO]
# Debug suite for the engine/macro/ module.
# Runs with_score, with_advancement, and with_function in sequence.
#
# Usage:
#   function macro:debug/engine_macro {player:"YourName"}
#
# Requirements:
#   - AME must be loaded (ame_load:load/yes)
#   - $(player) must be online

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━ engine/macro debug ","color":"aqua"},{"text":"━━━━━━━━━━━━━━━","color":"#555555"}]
$tellraw @s ["",{"text":"  player: ","color":"#555555"},{"text":"$(player)","color":"white"}]
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"─────────────────────────────────","color":"#555555"}]

# ── Test 1: with_score ────────────────────────────────────────────────────────
tellraw @s ["",{"text":"[1] ","color":"yellow","bold":true},{"text":"with_score","color":"aqua"},{"text":"  objective=macro.tmp  var=val","color":"#555555"}]

$scoreboard players set $(player) macro.tmp 99

$function macro:engine/macro/with_score {func:"macro:debug/engine_macro/internal/score_consumer",player:"$(player)",objective:"macro.tmp",var:"val"}

# ── Test 2: with_advancement ──────────────────────────────────────────────────
tellraw @s ["",{"text":"[2] ","color":"yellow","bold":true},{"text":"with_advancement","color":"aqua"},{"text":"  advancement=minecraft:story/mine_stone  var=done","color":"#555555"}]

$function macro:engine/macro/with_advancement {func:"macro:debug/engine_macro/internal/adv_consumer",player:"$(player)",advancement:"minecraft:story/mine_stone",var:"done"}

# ── Test 3: with_function ─────────────────────────────────────────────────────
tellraw @s ["",{"text":"[3] ","color":"yellow","bold":true},{"text":"with_function","color":"aqua"},{"text":"  source=fn_provider  target=fn_consumer","color":"#555555"}]

function macro:engine/macro/with_function {source:"macro:debug/engine_macro/internal/fn_provider",target:"macro:debug/engine_macro/internal/fn_consumer"}

# ─────────────────────────────────────────────────────────────────────────────
tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━","color":"#555555"}]
