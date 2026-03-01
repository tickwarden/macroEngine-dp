# ============================================
# macro:cmd/loot_drop
# ============================================
# Belirtilen koordinata loot table'dan item düşürür.
# macro:loot_table/ altındaki JSON'ları kullanır.
#
# INPUT: macro:input { x:<int>, y:<int>, z:<int>, loot_table:"<namespace:id>" }
#
# MEVCUT LOOT TABLES (macro namespace):
#   macro:util/empty              — Hiçbir şey düşürme
#   macro:template/single_item    — Tek item (editlenebilir şablon)
#   macro:template/weighted_pool  — Ağırlıklı rastgele havuz şablonu
#   macro:template/conditional_drop — Oyuncu vuruşuna koşullu drop
#   macro:template/bonus_per_looting — Looting büyüsüne göre bonus
#
# ÖRNEK:
#   data modify storage macro:input x set value 0
#   data modify storage macro:input y set value 64
#   data modify storage macro:input z set value 0
#   data modify storage macro:input loot_table set value "macro:template/single_item"
#   function macro:cmd/loot_drop with storage macro:input {}
# ============================================

$loot spawn $(x) $(y) $(z) loot $(loot_table)
