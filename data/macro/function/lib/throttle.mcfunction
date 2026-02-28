# ============================================
# macro:lib/throttle
# ============================================
# Fonksiyonun belirli bir interval'dan daha sık çalışmasını engeller.
# İlk çağrı anında çalışır, sonraki çağrılar interval
# dolana kadar DROP edilir (debounce'dan farkı budur).
#
# INPUT: macro:input { func:"<namespace:path>", delay:<tick>, interval:<tick>, key:"<id>" }
#   delay    = kuyrukta bekletme (0 = hemen çalıştır)
#   interval = minimum tick aralığı
#   key      = throttle tanımlayıcısı (her throttle noktası için benzersiz)
#
# OUTPUT: —  (engellendiyse sessizce döner)
#
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:ui/update_hud"
#   data modify storage macro:input delay set value 0
#   data modify storage macro:input interval set value 20
#   data modify storage macro:input key set value "hud_update"
#   function macro:lib/throttle with storage macro:input {}
#   # → HUD en fazla saniyede 1 kez güncellenir
# ============================================

# Mevcut throttle durumunu kontrol et
scoreboard players set $thr_go macro.tmp 1

$execute if data storage macro:engine throttle.$(key) run execute store result score $thr_exp macro.tmp run data get storage macro:engine throttle.$(key)
execute store result score $thr_now macro.tmp run scoreboard players get $epoch macro.time
$execute if data storage macro:engine throttle.$(key) run execute if score $thr_now macro.tmp < $thr_exp macro.tmp run scoreboard players set $thr_go macro.tmp 0

# Engellendiyse dur
execute if score $thr_go macro.tmp matches 0 run return 0

# Yeni expiry = now + interval
$scoreboard players set $thr_int macro.tmp $(interval)
scoreboard players operation $thr_now macro.tmp += $thr_int macro.tmp
$execute store result storage macro:engine throttle.$(key) int 1 run scoreboard players get $thr_now macro.tmp

# Fonksiyonu kuyruğa ekle
function macro:lib/queue_add with storage macro:input {}
