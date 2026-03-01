# ============================================
# macro:event/unregister_one
# ============================================
# Event listesinden YALNIZCA belirtilen handler fonksiyonunu siler.
# Diğer handler'lar korunur. Tüm event'i silmek için event/unregister kullanın.
#
# INPUT: macro:input { event:"<event_adı>", func:"<namespace:path>" }
#
# ÖRNEK:
#   data modify storage macro:input event set value "on_join"
#   data modify storage macro:input func set value "mypack:handlers/welcome"
#   function macro:event/unregister_one with storage macro:input {}
#
# NOT: Aynı fonksiyon birden fazla kez kayıtlıysa HEPSİ silinir.
# ============================================

# Event hiç yoksa çık
$execute unless data storage macro:engine events.$(event) run return 0

# Filtre verisini hazırla
$data modify storage macro:engine _uro.event set value "$(event)"
$data modify storage macro:engine _uro.func set value "$(func)"
$data modify storage macro:engine _uro.src set from storage macro:engine events.$(event)

# Event listesini temizle — filtreli olarak yeniden dolduracağız
$data remove storage macro:engine events.$(event)

# Döngü başlat
execute if data storage macro:engine _uro.src[0] run function macro:event/internal/uro_loop

# Temizlik
data remove storage macro:engine _uro
