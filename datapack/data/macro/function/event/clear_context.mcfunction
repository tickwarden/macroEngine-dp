# ============================================
# macro:event/clear_context
# ============================================
# macro:engine event_context storage'ını temizler.
# Event fire öncesi ve sonrası çağrılması önerilir —
# özellikle bağımsız event zincirlerinde context kirlenmesini önler.
#
# INPUT:  (yok)
# OUTPUT: (yok)
#
# ÖRNEK:
#   function macro:event/clear_context
#   data modify storage macro:engine event_context.player set value "Steve"
#   data modify storage macro:input event set value "on_join"
#   function macro:event/fire with storage macro:input {}
#   function macro:event/clear_context
# ============================================

data remove storage macro:engine event_context
