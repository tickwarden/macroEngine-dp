# ============================================
# macro:cmd/place_structure
# ============================================
# Belirtilen konuma NBT yapısı (structure) yerleştirir.
# Minecraft 1.19+ place structure komutu kullanır.
#
# INPUT: macro:input { structure:"<namespace:yol>", x:<int>, y:<int>, z:<int> }
#
# ÖRNEK:
#   data modify storage macro:input structure set value "mypack:arena/spawn_room"
#   data modify storage macro:input x set value 0
#   data modify storage macro:input y set value 64
#   data modify storage macro:input z set value 0
#   function macro:cmd/place_structure with storage macro:input {}
# ============================================

$place structure $(structure) $(x) $(y) $(z)
