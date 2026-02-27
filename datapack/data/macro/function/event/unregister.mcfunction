# ============================================
# macro:event/unregister
# ============================================
# Event'e kayıtlı tüm handler'ları siler.
# INPUT: macro:input { event:"<event_adı>" }
# ============================================

$data remove storage macro:engine events.$(event)
