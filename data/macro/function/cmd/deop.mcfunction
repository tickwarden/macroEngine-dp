# macro:cmd/deop — Oyuncunun OP'unu al
# INPUT: macro:input { player:"<ad>" }

execute unless entity @s[tag=macro.admin] run return 0

$deop $(player)
