$scoreboard players set @s macro.dialog_load $(cooldown)

# BUG FIX v1.0.1: Loading dialog açılırken macro.dialog_opened tag'i ekleniyor.
# close.mcfunction bu tag'i kaldırır; böylece close sonrası show'un
# "zaten açık" guard'ı yanlışlıkla tetiklenmez.
tag @s add macro.dialog_opened

dialog show @s macro:loading

tag @s add macro.dialog_closed