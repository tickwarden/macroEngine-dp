# macro:json/internal/has_exec [MACRO]
# INPUT: $(obj), $(key)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 1
$execute unless data storage macro:json objects.$(obj).$(key) run return 0
scoreboard players set $rc macro.json.rc 0
data modify storage macro:output result set value 1b

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/has ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":".","color":"#555555"},{"text":"$(key)","color":"yellow"},{"text":" → ","color":"#555555"},{"storage":"macro:output","nbt":"result","color":"green"}]
