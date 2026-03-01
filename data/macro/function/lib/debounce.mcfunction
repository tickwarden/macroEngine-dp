# ============================================
# macro:lib/debounce
# ============================================
# Fonksiyonu yalnızca henüz schedule edilmemişse zamanlar.
# Zaten aktif bir schedule varsa çağrıyı yok sayar
# (ilk çağrı korunur — sonrakiler düşer).
#
# Tersi davranış için (son çağrıyı koru):
#   schedule_cancel → schedule şeklinde çağırın.
#
# INPUT: macro:input { func:"<namespace:path>", interval:<tick>, key:"<id>" }
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:save/checkpoint"
#   data modify storage macro:input interval set value 60
#   data modify storage macro:input key set value "autosave"
#   function macro:lib/debounce with storage macro:input {}
#   # → Oyuncu her saniye tetiklese bile yalnızca 3sn'de 1 kaydeder
# ============================================

# Schedule zaten varsa → görmezden gel (debounce)
$execute if data storage macro:engine schedules.$(key) run return 0

# Yoksa → normal schedule oluştur
function macro:lib/schedule with storage macro:input {}
