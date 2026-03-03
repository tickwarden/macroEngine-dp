# macro:cmd/ban — Oyuncuyu yasakla
# INPUT: macro:input { player:"<ad>", reason:"<sebep>" }
# ⚠ Yalnızca dedicated server'da çalışır, single player'da etkisiz

execute unless entity @s[tag=macro.admin] run return 0

$ban $(player) $(reason)
