# ============================================
# Progress Bar Kapatma
# ============================================
# Komut: /function macro:stop_progressbar
# ============================================

# Progress bar'ı kapat
data remove storage macro:engine pb_obj
data remove storage macro:engine pb_max
data remove storage macro:engine pb_label

# Actionbar'ı temizle
title @a actionbar {"text":""}

tellraw @a {"text":"[Progress Bar] Kapatıldı.","color":"yellow"}
