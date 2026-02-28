# ============================================
# macro:lib/schedule_list
# ============================================
# Aktif tüm schedule'ları macro.debug tag'li oyunculara gösterir.
# Geliştirme ve debug amaçlıdır.
#
# INPUT:  (yok)
# OUTPUT: (yok — tellraw olarak gösterilir)
#
# ÖRNEK:
#   function macro:lib/schedule_list
# ============================================

tellraw @a[tag=macro.debug] [{"text":"--- Aktif Schedule'lar ---","color":"dark_aqua"}]
execute if data storage macro:engine schedules run tellraw @a[tag=macro.debug] [{"text":"  ","color":"gray"},{"storage":"macro:engine","nbt":"schedules","interpret":false,"color":"yellow"}]
execute unless data storage macro:engine schedules run tellraw @a[tag=macro.debug] {"text":"  [!] Aktif schedule yok.","color":"red"}
tellraw @a[tag=macro.debug] [{"text":"--- Kuyruk (","color":"dark_aqua"},{"score":{"name":"$pq_depth","objective":"macro.tmp"},"color":"white"},{"text":" item) ---","color":"dark_aqua"}]
execute if data storage macro:engine queue[0] run tellraw @a[tag=macro.debug] [{"text":"  ","color":"gray"},{"storage":"macro:engine","nbt":"queue","interpret":false,"color":"aqua"}]
tellraw @a[tag=macro.debug] [{"text":"-------------------------","color":"dark_aqua"}]
