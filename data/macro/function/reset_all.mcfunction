function macro:disable/main

function macro:hook/unbind_all
function macro:trigger/unbind_all
function macro:wand/unregister_all
data remove storage macro:engine interaction_binds
data remove storage macro:engine fibers
data remove storage macro:engine perm_triggers
data remove storage macro:engine perm_trigger_names
data remove storage macro:engine log_display
data remove storage macro:engine schedules
data remove storage macro:engine global.tick
data remove storage macro:engine global.epoch

tellraw @s ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"Engine disabled. ","color":"red"},{"text":"Restart → ","color":"#555555"},{"text":"[Click here]","color":"aqua","bold":true,"underlined":true,"click_event":{"action":"run_command","command":"/function macro:load"},"hover_event":{"action":"show_text","value":"/function macro:load"}}]
