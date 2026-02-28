# macro:cmd/scoreboard_get — Oyuncunun scoreboard değerini oku
# INPUT: macro:input { player:"<ad>", objective:"<objective>" }
# OUTPUT: macro:output { result:<int> }

$execute store result storage macro:output result int 1 run scoreboard players get @a[name=$(player),limit=1] $(objective)
