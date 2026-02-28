# ============================================
# macro:event/has
# ============================================
# Event'in en az bir kayıtlı handler'ı var mı kontrol eder.
#
# INPUT:  macro:input { event:"<event_adı>" }
# OUTPUT: macro:output { result: 1b (kayıtlı) / 0b (yok) }
#
# ÖRNEK:
#   data modify storage macro:input event set value "on_join"
#   function macro:event/has with storage macro:input {}
#   # macro:output.result → 1b veya 0b
# ============================================

data modify storage macro:output result set value 0b
$execute if data storage macro:engine events.$(event) run data modify storage macro:output result set value 1b
