# ============================================
# macro:lib/schedule
# ============================================
# Fonksiyonu interval tick'te bir çalışacak şekilde zamanlar.
# İptal için: macro:lib/schedule_cancel (key ile).
# Devam etmek için: fonksiyon içinde macro:lib/schedule_renew çağır.
#
# BUG FIX v3.1: Aynı key ile tekrar çağrılınca queue'ya
# duplicate giriş EKLENMEZ — sadece func/interval güncellenir.
# Zamanlayıcıyı SIFIRLAMAK için önce schedule_cancel çağırın.
#
# INPUT: macro:input { func:"<namespace:path>", interval:<tick>, key:"<schedule_id>" }
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:tasks/heartbeat"
#   data modify storage macro:input interval set value 200
#   data modify storage macro:input key set value "heartbeat"
#   function macro:lib/schedule with storage macro:input {}
# ============================================

# Zaten var mı? → Sadece veriyi güncelle, kuyruğa tekrar ekleme
$execute if data storage macro:engine schedules.$(key) run data modify storage macro:engine schedules.$(key).func set value "$(func)"
$execute if data storage macro:engine schedules.$(key) run data modify storage macro:engine schedules.$(key).interval set value $(interval)
$execute if data storage macro:engine schedules.$(key) run return 0

# Yeni schedule: kaydet ve kuyruğa ekle
$data modify storage macro:engine schedules.$(key).func set value "$(func)"
$data modify storage macro:engine schedules.$(key).interval set value $(interval)
$data modify storage macro:engine queue append value {func:"$(func)", delay:$(interval)}
