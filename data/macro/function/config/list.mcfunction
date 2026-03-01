# ============================================
# macro:config/list
# ============================================
# Tüm config değerlerini debug kanalına gösterir.
# INPUT:  —
# OUTPUT: — (debug çıktısı)
# ============================================

tellraw @a[tag=macro.debug] {"text":"[Config] -- Tüm Değerler --","color":"yellow"}
tellraw @a[tag=macro.debug] {"nbt":"config","storage":"macro:engine","interpret":false,"color":"white"}
tellraw @a[tag=macro.debug] {"text":"[Config] -----------------","color":"yellow"}
