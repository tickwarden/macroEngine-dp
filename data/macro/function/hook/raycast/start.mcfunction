# Raycast başlangıcı
# Distance counter'ı sıfırla (max 50 step = 5 blok)
scoreboard players set @s macro.tmp 0

# Döngüyü başlat
function macro:hook/raycast/loop
