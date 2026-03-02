$scoreboard players set @s macro.dialog_load $(cooldown)

# BUG FIX v1.0.2: Minecraft dialog, buton tıklamasında otomatik kapanır ama
# macro:dialog/close çağrılmaz — macro.dialog_opened tag'i oyuncuda kalır.
# Yeni bir loading başlatmadan önce tag'i temizle; aksi hâlde
# open → show akışındaki guard "dialog zaten açık" sanıp return 0 yapar
# ve oyuncu sonsuza kadar loading ekranında kalır.
tag @s remove macro.dialog_opened

tag @s add macro.dialog_opened
dialog show @s macro:loading
tag @s add macro.dialog_closed
