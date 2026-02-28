# ============================================
# macro:cmd/attribute_remove_modifier
# ============================================
# Oyuncudan attribute modifier kaldırır.
#
# INPUT: macro:input { player:"<ad>", attribute:"<attribute_id>", id:"<modifier_id>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input attribute set value "minecraft:generic.movement_speed"
#   data modify storage macro:input id set value "macro:speed_boost"
#   function macro:cmd/attribute_remove_modifier with storage macro:input {}
# ============================================

$attribute @a[name=$(player),limit=1] $(attribute) modifier remove $(id)
