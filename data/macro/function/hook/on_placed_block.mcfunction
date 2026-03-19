# Advancement reward: placed_block tetiklendiğinde çalışır
# Oyuncunun baktığı yöndeki yeni yerleştirilen bloğu bul

# Advancement'ı revoke et (tekrar tetiklenebilsin)
advancement revoke @s only macro:hook/placed_block

# Raycast başlat: oyuncunun gözünden başla
execute as @s at @s anchored eyes run function macro:hook/raycast/start
