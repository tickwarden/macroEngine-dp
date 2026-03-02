# ============================================
# macro:trigger/list
# ============================================
# Kayıtlı trigger bind'larını @s'e gösterir.
# macro.debug tag'i şart değildir; herhangi bir yönetici çağırabilir.
# 1.21.6+: dialog ile; önceki sürümler: tellraw ile.
#
# ÇAĞIRIM:
# execute as <oyuncu> run function macro:trigger/list
# ============================================

execute unless data storage macro:engine trigger_binds[0] run tellraw @s {"text":"[Trigger] Kayıtlı bind yok.","color":"gray"}
execute if data storage macro:engine trigger_binds[0] run tellraw @s [{"text":"[Trigger] Bind listesi:\n","color":"gold","bold":true},{"nbt":"trigger_binds","storage":"macro:engine","interpret":false}]
