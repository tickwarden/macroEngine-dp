# macro:json/internal/import_exec [MACRO]
# INPUT: $(obj), $(storage), $(path)
# Copies a compound from an external storage path into macro:json objects.$(obj).
# Type metadata is reset because individual key types are unknown after a bulk copy.

$data modify storage macro:json objects.$(obj) set from storage $(storage) $(path)
$data modify storage macro:json meta.$(obj) set value {}
scoreboard players set $rc macro.json.rc 0

$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"json/import ","color":"aqua"},{"text":"$(storage):$(path)","color":"white"},{"text":" → ","color":"#555555"},{"text":"$(obj)","color":"yellow"}]
