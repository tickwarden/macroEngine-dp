scoreboard players set @s macro.dialog_load -1
tag @s remove macro.dialog_closed

# BUG FIX v1.0.2: Buton tıklamasıyla kapanan dialog macro:dialog/close'u
# çağırmaz; macro.dialog_opened tag'i kalmış olabilir. show'dan önce temizle.
tag @s remove macro.dialog_opened

# Dialog'u aç
execute at @s run function macro:dialog/show

# Bitir
return 1