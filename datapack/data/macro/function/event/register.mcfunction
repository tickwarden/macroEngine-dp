# ============================================
# macro:event/register
# ============================================
# Event'e handler fonksiyonu ekler.
# INPUT: macro:input { event:"<event_adı>", func:"<namespace:path>" }
# ============================================

$data modify storage macro:engine events.$(event) append value {func:"$(func)"}
