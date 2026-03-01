# ============================================
# macro:event/list
# ============================================
# Kayıtlı tüm event ve handler'ları debug olarak gösterir.
# INPUT: (yok)
# ============================================

tellraw @a[tag=macro.debug] [{"text":"--- Kayitli Event'ler ---","color":"dark_aqua"}]
execute if data storage macro:engine events run tellraw @a[tag=macro.debug] [{"text":"  ","color":"gray"},{"storage":"macro:engine","nbt":"events","interpret":false,"color":"yellow"}]
execute unless data storage macro:engine events run tellraw @a[tag=macro.debug] {"text":"  [!] Kayitli event yok.","color":"red"}
tellraw @a[tag=macro.debug] [{"text":"-------------------------","color":"dark_aqua"}]
