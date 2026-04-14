# macro:json/internal/create_exec [MACRO]
# INPUT: $(obj)

$execute unless data storage macro:json objects.$(obj) run data modify storage macro:json objects.$(obj) set value {}
$execute unless data storage macro:json meta.$(obj) run data modify storage macro:json meta.$(obj) set value {}

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/create ","color":"aqua"},{"text":"$(obj)","color":"white"},{"text":" ready","color":"green"}]
