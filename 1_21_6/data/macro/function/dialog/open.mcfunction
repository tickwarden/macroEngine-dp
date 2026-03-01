scoreboard players set @s macro.dialog_load -1
tag @s remove macro.dialog_closed

# Dialog'u aç
execute at @s run function macro:dialog/show

# Temp'i sil
data remove storage macro:engine dialog