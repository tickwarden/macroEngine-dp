# macro:json/internal/clear_exec [MACRO]
# INPUT: $(obj)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 0
$data modify storage macro:json objects.$(obj) set value {}
$data modify storage macro:json meta.$(obj) set value {}

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/clear ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":" cleared","color":"yellow"}]
