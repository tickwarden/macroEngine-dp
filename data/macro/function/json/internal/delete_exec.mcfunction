# macro:json/internal/delete_exec [MACRO]
# INPUT: $(obj), $(key)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 1
$execute unless data storage macro:json objects.$(obj).$(key) run return 0
scoreboard players set $rc macro.json.rc 0
$data remove storage macro:json objects.$(obj).$(key)
$data remove storage macro:json meta.$(obj).$(key)

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/delete ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":".","color":"#555555"},{"text":"$(key)","color":"yellow"},{"text":" removed","color":"red"}]
