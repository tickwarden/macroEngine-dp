# ============================================
# macro:trigger/internal/dispatch
# ============================================
# @s'nin macro_action skorunu okur, sıfırlar ve
# eşleşen bind'ı arar. Bulunan fonksiyonu çalıştırır.
# Birden fazla bind aynı değere sahipse hepsi çalışır.
#
# tick.mcfunction tarafından çağrılır:
# execute as @a[scores={macro_action=1..}] run function macro:trigger/internal/dispatch
# ============================================

# Oyuncunun trigger değerini geçici olarak kaydet
scoreboard players operation $tc_player macro.tmp = @s macro_action

# Trigger'ı sıfırla ve yeniden etkinleştir
scoreboard players set @s macro_action 0
scoreboard players enable @s macro_action

# Bind listesi boşsa dur
execute unless data storage macro:engine trigger_binds[0] run return 0

# Bind'ları kendi geçici listesine kopyala (macro:input'e dokunmadan)
data modify storage macro:engine _tc_binds set from storage macro:engine trigger_binds

# İtere et
function macro:trigger/internal/check_next
data remove storage macro:engine _tc_binds
data remove storage macro:engine _tc_current
