# ============================================
# macro:cmd/attribute_add_modifier
# ============================================
# Oyuncuya attribute modifier ekler.
# Modifier UUID çakışmasını önlemek için benzersiz id kullan.
#
# INPUT: macro:input {
#   player:"<ad>",
#   attribute:"<attribute_id>",
#   id:"<modifier_id>",
#   amount:<float>,
#   operation:"<add_value|add_multiplied_base|add_multiplied_total>"
# }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input attribute set value "minecraft:generic.movement_speed"
#   data modify storage macro:input id set value "macro:speed_boost"
#   data modify storage macro:input amount set value 0.1
#   data modify storage macro:input operation set value "add_value"
#   function macro:cmd/attribute_add_modifier with storage macro:input {}
# ============================================

$attribute @a[name=$(player),limit=1] $(attribute) modifier add $(id) $(amount) $(operation)
