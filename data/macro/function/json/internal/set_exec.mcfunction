# macro:json/internal/set_exec [MACRO]
# INPUT: $(obj), $(key), $(type)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 0
$data modify storage macro:json objects.$(obj).$(key) set from storage macro:input value
$data modify storage macro:json meta.$(obj).$(key) set value $(type)

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/set ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":".","color":"#555555"},{"text":"$(key)","color":"yellow"},{"text":" ← ","color":"#555555"},{"storage":"macro:input","nbt":"value","color":"green"},{"text":" [type:$(type)]","color":"#555555"}]
