# ============================================
# macro:lib/for_each_list
# ============================================
# Bir storage listesinin her elemanı için fonksiyon çalıştırır.
#
# KULLANIM:
#   1. Listeyi _felist_input'a kopyala:
#      data modify storage macro:engine _felist_input set from storage <kaynak> <yol>
#   2. Fonksiyonu çağır:
#      data modify storage macro:input func set value "mypack:loop/item_step"
#      function macro:lib/for_each_list with storage macro:input {}
#
# Her iterasyonda erişilebilir:
#   macro:engine _felist_current  → mevcut eleman
#   macro:engine _felist_i        → mevcut indeks (0'dan başlar, int)
#
# NOT: func içinde _felist_input'u değiştirme — iterator bozulur.
#
# ÖRNEK:
#   data modify storage macro:engine _felist_input set value ["elma","armut","kiraz"]
#   data modify storage macro:input func set value "mypack:give/fruit"
#   function macro:lib/for_each_list with storage macro:input {}
# ============================================

$data modify storage macro:engine _felist_state set value {func:"$(func)"}
scoreboard players set $felist_i macro.tmp 0
function macro:lib/internal/for_each_list_step

# Temizle
data remove storage macro:engine _felist_input
data remove storage macro:engine _felist_state
data remove storage macro:engine _felist_current
data remove storage macro:engine _felist_i
