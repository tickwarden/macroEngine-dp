# ============================================
# macro:state/list
# ============================================
# Tüm oyuncuların mevcut durumlarını macro.debug tag'li oyunculara gösterir.
#
# INPUT:  (yok)
# OUTPUT: (yok — tellraw olarak gösterilir)
# ============================================

tellraw @a[tag=macro.debug] [{"text":"--- Oyuncu Durumlari ---","color":"gold"}]
execute if data storage macro:engine states run tellraw @a[tag=macro.debug] [{"text":"  ","color":"gray"},{"storage":"macro:engine","nbt":"states","interpret":false,"color":"white"}]
execute unless data storage macro:engine states run tellraw @a[tag=macro.debug] {"text":"  [!] Kayitli durum yok.","color":"red"}
tellraw @a[tag=macro.debug] [{"text":"------------------------","color":"gold"}]
