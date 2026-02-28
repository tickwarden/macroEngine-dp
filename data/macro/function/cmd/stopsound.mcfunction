# macro:cmd/stopsound — Oyuncuda çalan sesi durdur
# INPUT: macro:input { player:"<ad>", category:"*"|"master"|"music"|"record"|"weather"|"block"|"hostile"|"neutral"|"player"|"ambient"|"voice", sound:"<sound_id>" }
# sound boş bırakılırsa kategorideki tüm sesler durur

$execute as @a[name=$(player),limit=1] run stopsound @s $(category) $(sound)
