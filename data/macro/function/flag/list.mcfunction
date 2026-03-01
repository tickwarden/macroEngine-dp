# ============================================
# macro:flag/list
# ============================================
# Tüm aktif global bayrakları macro.debug tag'li oyunculara gösterir.
#
# INPUT:  (yok)
# OUTPUT: (yok — tellraw olarak gösterilir)
# ============================================

tellraw @a[tag=macro.debug] [{"text":"--- Global Flag'ler ---","color":"light_purple"}]
execute if data storage macro:engine flags run tellraw @a[tag=macro.debug] [{"text":"  ","color":"gray"},{"storage":"macro:engine","nbt":"flags","interpret":false,"color":"white"}]
execute unless data storage macro:engine flags run tellraw @a[tag=macro.debug] {"text":"  [!] Aktif flag yok.","color":"red"}
tellraw @a[tag=macro.debug] [{"text":"----------------------","color":"light_purple"}]
