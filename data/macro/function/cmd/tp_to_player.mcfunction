# macro:cmd/tp_to_player — Oyuncuyu başka oyuncuya ışınla
# INPUT: macro:input { player:"<ad>", target:"<hedef_oyuncu>" }

$execute as @a[name=$(player),limit=1] at @s run tp @s @a[name=$(target),limit=1]
