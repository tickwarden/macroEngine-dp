# macro:cmd/scoreboard_set — Oyuncunun scoreboard değerini yaz
# INPUT: macro:input { player:"<ad>", objective:"<objective>", value:<int> }

$execute as @a[name=$(player),limit=1] at @s run scoreboard players set @s $(objective) $(value)
