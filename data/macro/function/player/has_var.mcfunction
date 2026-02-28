# macro:player/has_var — Oyuncunun değişkeni var mı?
# INPUT: macro:input { player:"<ad>", key:"<değişken>" }
# OUTPUT: macro:output { result: 1b (var) veya 0b (yok) }

data modify storage macro:output result set value 0b
$execute if data storage macro:engine players.$(player).$(key) run data modify storage macro:output result set value 1b
