# Doğrudan çağırmayın — event/unregister_one tarafından kullanılır.
# Her elemanı kontrol et: eşleşmiyorsa events listesine geri ekle.
function macro:event/internal/uro_check with storage macro:engine _uro.src[0]
data remove storage macro:engine _uro.src[0]
execute if data storage macro:engine _uro.src[0] run function macro:event/internal/uro_loop
