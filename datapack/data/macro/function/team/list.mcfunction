# ============================================
# macro:team/list
# ============================================
# Kayıtlı tüm takımları debug kanalına gösterir.
# INPUT:  —
# OUTPUT: —  (debug çıktısı)
# ============================================

tellraw @a[tag=macro.debug] {"text":"[Team] -- Kayıtlı Takımlar --","color":"aqua"}
tellraw @a[tag=macro.debug] {"nbt":"teams","storage":"macro:engine","interpret":false,"color":"white"}
tellraw @a[tag=macro.debug] {"text":"[Team] ---------------------","color":"aqua"}
