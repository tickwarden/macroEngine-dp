# ============================================
# macro:lib/schedule_reset
# ============================================
# Mevcut bir schedule'ın geri sayımını sıfırlar.
# Kuyruktaki gecikmiş girişi siler, yeniden kuyruklar.
# Schedule mevcut değilse hiçbir şey yapmaz.
#
# INPUT: macro:input { key:"<schedule_id>" }
#
# ÖRNEK:
#   data modify storage macro:input key set value "inactivity"
#   function macro:lib/schedule_reset with storage macro:input {}
# ============================================

# Var mı kontrol et
$execute unless data storage macro:engine schedules.$(key) run return 0

# Geçici kopyaya al
$data modify storage macro:engine _sreset set from storage macro:engine schedules.$(key)
$data modify storage macro:engine _sreset.key set value "$(key)"

# schedules kaydını sil (schedule_cancel gibi)
$data remove storage macro:engine schedules.$(key)

# Yeniden schedule et (tam olarak lib/schedule mantığıyla)
function macro:lib/internal/schedule_reset_do with storage macro:engine _sreset
data remove storage macro:engine _sreset
