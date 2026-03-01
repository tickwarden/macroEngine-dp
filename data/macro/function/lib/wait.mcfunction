# ============================================
# macro:lib/wait
# ============================================
# queue_add için kısa alias — delay tick sonra fonksiyon çalıştır.
# INPUT: macro:input { func:"<namespace:path>", delay:<tick> }
# ÖRNEK (5sn sonra):
#   data modify storage macro:input func set value "mypack:events/end"
#   data modify storage macro:input delay set value 100
#   function macro:lib/wait with storage macro:input {}
# ============================================

function macro:lib/queue_add with storage macro:input {}
