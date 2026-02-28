# ============================================
# macro:cmd/forceload_add
# ============================================
# Belirtilen blok koordinatlarındaki chunk'ı zorla yüklü tutar.
# Uzak mesafede çalışan redstone, komutlar veya spawn için gereklidir.
#
# INPUT: macro:input { x:<int>, z:<int> }
#
# ÖRNEK:
#   data modify storage macro:input x set value 100
#   data modify storage macro:input z set value 200
#   function macro:cmd/forceload_add with storage macro:input {}
# ============================================

$forceload add $(x) $(z)
