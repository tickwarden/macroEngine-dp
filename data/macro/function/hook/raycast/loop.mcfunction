# Raycast döngüsü
# Mevcut pozisyonda air olmayan blok var mı kontrol et

# Air olmayan blok bulduysa -> found function
execute unless block ~ ~ ~ #minecraft:air run return run function macro:hook/raycast/found

# Hala air -> devam et
# Counter'ı artır
scoreboard players add @s macro.tmp 1

# Max mesafeye ulaştıysak dur (50 step = 5 blok)
execute if score @s macro.tmp matches 50.. run return 0

# Pozisyonu 0.1 blok ilerlet ve tekrar dene
execute positioned ^ ^ ^0.1 run function macro:hook/raycast/loop
