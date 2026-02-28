# ============================================
# macro:event/count
# ============================================
# Bir event'e kayıtlı handler sayısını döndürür.
#
# INPUT:  macro:input { event:"<event_adı>" }
# OUTPUT: macro:output { result:<int> }  (0 = event yok veya boş)
#
# ÖRNEK:
#   data modify storage macro:input event set value "on_join"
#   function macro:event/count with storage macro:input {}
#   # macro:output.result → handler sayısı
# ============================================

data modify storage macro:output result set value 0
$execute if data storage macro:engine events.$(event) run execute store result storage macro:output result int 1 run data get storage macro:engine events.$(event)
