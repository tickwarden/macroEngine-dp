# macro:json/internal/drop_exec [MACRO]
# INPUT: $(obj)

$execute unless data storage macro:json objects.$(obj) run return 0
scoreboard players set $rc macro.json.rc 0
$data remove storage macro:json objects.$(obj)
$data remove storage macro:json meta.$(obj)

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/drop ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":" dropped","color":"red"}]
