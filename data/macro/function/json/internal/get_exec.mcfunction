# macro:json/internal/get_exec [MACRO]
# INPUT: $(obj), $(key)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 1
$execute unless data storage macro:json objects.$(obj).$(key) run return 0
scoreboard players set $rc macro.json.rc 0
$data modify storage macro:output result set from storage macro:json objects.$(obj).$(key)
$data modify storage macro:json result set from storage macro:json objects.$(obj).$(key)
$execute store result score $type macro.json.type run data get storage macro:json meta.$(obj).$(key)

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/get ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":".","color":"#555555"},{"text":"$(key)","color":"yellow"},{"text":" → ","color":"#555555"},{"storage":"macro:output","nbt":"result","color":"green"}]
