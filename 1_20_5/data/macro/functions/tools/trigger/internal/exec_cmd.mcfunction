# type:"cmd" → {cmd:"say hello"}
# Güvenlik: yalnızca macro.admin etiketli executors çalıştırabilir.
execute unless entity @s[tag=macro.admin] run return 0
tellraw @a[tag=macro.admin] [{"selector":"@s","color":"gold"},{"text":" - command executed","color":"yellow"}]

$$(cmd)
