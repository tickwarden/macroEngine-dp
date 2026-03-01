# BUG FIX v1.0.1: Guard macro.dialog_CLOSED yerine macro.dialog_OPENED olmalıydı.
# Önceki kod, dialog kapatıldıktan hemen sonra show çağrılırsa
# (macro.dialog_closed tag'i hâlâ silinmemişse) yanlışlıkla return 0 yapıyordu.
# Doğru davranış: dialog zaten açıksa (macro.dialog_opened) engelle.
execute if entity @s[tag=macro.dialog_opened] at @s run return 0

# Gerekli: macro:engine dialog.DIALOG bir kaynak konumuna ayarlanmış olmalı
# Örnek: data modify storage macro:engine dialog.DIALOG set value "macro:loading"
execute unless data storage macro:engine dialog.DIALOG run return 0

# Oyuncu adını al
execute at @s run function macro:player/get_name

# Oyuncu adını storage'ye yaz
data modify storage macro:engine dialog.NAME set from storage macro:names temp.NAME

# Dialog'u aç
function macro:dialog/show_macro with storage macro:engine dialog

# Dialog açıldı olarak işaretle (çift açılmayı önler)
tag @s add macro.dialog_opened

return 1
