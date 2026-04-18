# macro:debug/internal/on_kill_handler
# Debug handler registered to the "on_kill" event by example_events.
# Called by macro:event/fire via queue_run_func — no macro args.
# Reads context from macro:engine event_context storage.

tellraw @a[tag=macro.debug] ["",{"text":"[DEBUG] ","color":"red","bold":true},{"text":"on_kill fired — player=","color":"gray"},{"storage":"macro:engine","nbt":"event_context.player","color":"green"},{"text":"  reason=","color":"gray"},{"storage":"macro:engine","nbt":"event_context.reason","color":"aqua"}]
