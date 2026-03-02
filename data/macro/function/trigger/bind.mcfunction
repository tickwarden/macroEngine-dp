# ============================================
# macro:trigger/bind
# ============================================
# macro_action trigger objective'ine bir değer-fonksiyon bağlaması ekler.
# Oyuncu /trigger macro_action set <değer> yazdığında
# bu değere bağlı fonksiyon otomatik çalışır.
#
# INPUT: macro:input { value:<int>, func:"<namespace:path>" }
#
# ÖRNEK:
# data modify storage macro:input value set value 1
# data modify storage macro:input func set value "mypack:menu/open"
# function macro:trigger/bind with storage macro:input {}
#
# data modify storage macro:input value set value 2
# data modify storage macro:input func set value "mypack:shop/open"
# function macro:trigger/bind with storage macro:input {}
#
# Oyuncu kullanımı:
# /trigger macro_action set 1 → mypack:menu/open çalışır
# /trigger macro_action set 2 → mypack:shop/open çalışır
#
# NOT: Aynı değer için yeni bind eklenirse eski bind üzerine YAZILMAZ,
# ikisi birden çalışır. Önce unbind yapın.
# ============================================

# trigger_binds listesini yoksa başlat
execute unless data storage macro:engine trigger_binds run data modify storage macro:engine trigger_binds set value []

$data modify storage macro:engine trigger_binds append value {value:$(value), func:"$(func)"}
