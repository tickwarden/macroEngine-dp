# macro:player/online_check — Oyuncu şu an sunucuda mı?
# INPUT: macro:input { player:"<oyuncuAdı>" }
# OUTPUT: macro:output { result: 1b (online) veya 0b (offline) }

data modify storage macro:output result set value 0b
$execute if entity @a[name=$(player),limit=1] run data modify storage macro:output result set value 1b
