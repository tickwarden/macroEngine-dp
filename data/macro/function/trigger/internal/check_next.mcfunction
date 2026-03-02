# ============================================
# macro:trigger/internal/check_next
# ============================================
# _tc_binds listesini birer birer işler.
# Her eleman için: value == $tc_player ise fonksiyonu çalıştırır.
# macro:input'e hiç dokunmaz — tick context güvenlidir.
# ============================================

execute unless data storage macro:engine _tc_binds[0] run return 0

# Mevcut bind'ı al
data modify storage macro:engine _tc_current set from storage macro:engine _tc_binds[0]
data remove storage macro:engine _tc_binds[0]

# Değeri oku ve karşılaştır
execute store result score $tc_val macro.tmp run data get storage macro:engine _tc_current.value

# Eşleşme: bu bind'ın fonksiyonunu çalıştır
execute if score $tc_player macro.tmp = $tc_val macro.tmp run function macro:trigger/internal/call with storage macro:engine _tc_current

# Sonraki bind
function macro:trigger/internal/check_next
