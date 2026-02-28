# ============================================
# macro:load — Advanced Macro Engine v3.2
# ============================================
# /reload veya sunucu başlangıcında otomatik çalışır.
# Scoreboard, storage ve schedule başlatır.
#
# v3.2 değişiklikleri:
#   + flag/ ve state/ modülleri için storage başlatma
#   + math/random tohum iyileştirmesi (BUG FIX)
#   + event/unregister_one eklendi
#   + event/has, event/count, event/clear_context eklendi
#   + event/fire_queued eklendi
#   + lib/queue_clear, lib/schedule_list, lib/schedule_reset eklendi
#   + math/map, math/wrap, math/log2, math/mod eklendi
#   + cmd/msg, cmd/msg_raw, cmd/clone, cmd/clone_masked eklendi
#   + cmd/ride, cmd/ride_dismount, cmd/forceload_add/remove eklendi
#   + cmd/trigger_set, cmd/spectate, cmd/spectate_stop eklendi
#   + cmd/place_feature, cmd/place_structure eklendi
# ============================================

execute if data storage macro:engine global{loaded:1b} run return 0

# ─── Scoreboard Objectives ───────────────────────────────
scoreboard objectives add macro.tmp dummy
scoreboard objectives add macro.time dummy
scoreboard objectives add macro_menu trigger
scoreboard objectives add macro_run trigger

# ─── Sayaçları başlat ────────────────────────────────────
# BUG FIX v3.0: $epoch macro.time /reload'da SIFIRLANMAZ.
# Yalnızca hiç var olmamışsa (ilk yüklemede) sıfırlanır;
# böylece cooldown'lar sunucu yeniden başlatmadan korunur.
execute unless score $epoch macro.time matches -2147483648..2147483647 run scoreboard players set $epoch macro.time 0
scoreboard players set $tick macro.tmp 0

# ─── process_queue özyineleme derinlik sayacı ─────────────
# BUG FIX v3.0: Her tick başında sıfırlanır; 256 limiti
# aynı tick'te stack overflow'u engeller.
scoreboard players set $pq_depth macro.tmp 0

# ─── Global storage başlat ───────────────────────────────
data modify storage macro:engine global set value {version:"3.3"}

# ─── Throttle durumunu başlat (yoksa) ────────────────────
execute unless data storage macro:engine throttle run data modify storage macro:engine throttle set value {}

# ─── Flag/State storage başlat (yoksa) ───────────────────
execute unless data storage macro:engine flags run data modify storage macro:engine flags set value {}
execute unless data storage macro:engine states run data modify storage macro:engine states set value {}

# ─── sync_tick schedule'ı kur (her 20 tick = 1sn) ───────
data modify storage macro:input func set value "macro:lib/sync_tick"
data modify storage macro:input interval set value 20
data modify storage macro:input key set value "sync_tick"
function macro:lib/schedule with storage macro:input {}
data remove storage macro:input func
data remove storage macro:input interval
data remove storage macro:input key

# Trigger'lar
scoreboard players enable @a[tag=macro.admin] macro_menu
scoreboard players enable @a[tag=macro.admin] macro_run

# Storage ayarla
data modify storage macro:engine global.loaded set value 1b

# ─── Yükleme mesajı ──────────────────────────────────────
tellraw @a[tag=macro.debug] {"text":"[Macro Engine v3.2] Yuklendi.","color":"green"}
function macro:cmd/sound_all {sound:"minecraft:ui.toast.challenge_complete",volume:1,pitch:0}
