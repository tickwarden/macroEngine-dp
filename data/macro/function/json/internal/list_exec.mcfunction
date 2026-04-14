# macro:json/internal/list_exec [MACRO]
# INPUT: $(obj)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 0

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/list ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":" → ","color":"#555555"},{"storage":"macro:json","nbt":"objects.$(obj)","color":"green","interpret":false}]
$tellraw @a[tag=macro.debug] ["",{"text":"  meta: ","color":"#555555"},{"storage":"macro:json","nbt":"meta.$(obj)","color":"#888888","interpret":false}]
