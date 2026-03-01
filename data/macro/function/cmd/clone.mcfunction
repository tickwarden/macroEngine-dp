# ============================================
# macro:cmd/clone
# ============================================
# Belirtilen bölgeden hedef konuma blok kopyalar.
#
# INPUT: macro:input {
#   x1:<int>, y1:<int>, z1:<int>,
#   x2:<int>, y2:<int>, z2:<int>,
#   dx:<int>, dy:<int>, dz:<int>
# }
# (dx,dy,dz) = hedef konumun köşesi (to_x, to_y, to_z)
#
# ÖRNEK:
#   data modify storage macro:input x1 set value 0
#   data modify storage macro:input y1 set value 64
#   data modify storage macro:input z1 set value 0
#   data modify storage macro:input x2 set value 10
#   data modify storage macro:input y2 set value 74
#   data modify storage macro:input z2 set value 10
#   data modify storage macro:input dx set value 100
#   data modify storage macro:input dy set value 64
#   data modify storage macro:input dz set value 0
#   function macro:cmd/clone with storage macro:input {}
# ============================================

$clone $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(dx) $(dy) $(dz)
