# macro:json/internal/export_exec [MACRO]
# INPUT: $(obj), $(storage), $(path)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 0
$data modify storage $(storage) $(path) set from storage macro:json objects.$(obj)

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/export ","color":"aqua"},{"text":"$(obj)","color":"yellow"},{"text":" → ","color":"#555555"},{"text":"$(storage):$(path)","color":"white"}]
