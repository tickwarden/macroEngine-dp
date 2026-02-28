# macro:cmd/scoreboard_add — Oyuncunun scoreboard değerine ekle
# INPUT: macro:input { player:"<ad>", objective:"<objective>", amount:<int> }

$execute as @a[name=$(player),limit=1] at @s run scoreboard players add @s $(objective) $(amount)
