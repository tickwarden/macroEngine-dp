# ============================================
# macro:event/fire
# ============================================
# Kayıtlı tüm handler'ları sırayla çalıştırır.
# INPUT: macro:input { event:"<event_adı>" }
# Context için: macro:engine event_context.<alan>
# ============================================

$execute unless data storage macro:engine events.$(event) run return 0

# Handler listesini geçici kopyaya al (fire sırasında register olabilir)
$data modify storage macro:engine _event_tmp set from storage macro:engine events.$(event)
execute if data storage macro:engine _event_tmp[0] run function macro:event/internal/fire_next
data remove storage macro:engine _event_tmp
