# ============================================
# macro:lib/schedule_renew
# ============================================
# Aktif schedule'ı bir sonraki tura yeniden kuyruğa ekler.
# Kendi schedule fonksiyonunuzun sonunda çağırın.
# Schedule iptal edilmişse hiçbir şey yapmaz.
# INPUT: macro:input { key:"<schedule_id>" }
# ============================================

$execute unless data storage macro:engine schedules.$(key) run return 0
$data modify storage macro:engine _sched_tmp set from storage macro:engine schedules.$(key)
function macro:lib/internal/schedule_requeue with storage macro:engine _sched_tmp
data remove storage macro:engine _sched_tmp
