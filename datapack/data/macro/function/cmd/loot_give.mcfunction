# ============================================
# macro:cmd/loot_give (v3.3 — loot_table referanslı)
# ============================================
# Oyuncuya loot table içeriğini doğrudan envanterine verir.
#
# INPUT: macro:input { player:"<ad>", loot_table:"<namespace:id>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input loot_table set value "macro:template/single_item"
#   function macro:cmd/loot_give with storage macro:input {}
# ============================================

$loot give @a[name=$(player),limit=1] loot $(loot_table)
