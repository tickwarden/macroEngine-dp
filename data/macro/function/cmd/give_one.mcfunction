# macro:cmd/give_one — Oyuncuya 1 adet eşya ver (count parametresi gerekmez)
# INPUT: macro:input { player:"<ad>", item:"<item_id>" }

$execute as @a[name=$(player),limit=1] at @s run give @s $(item) 1
