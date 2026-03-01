# ============================================
# macro:string/progress_bar
# ============================================
# Tek bir oyuncuya anlık (one-shot) ilerleme çubuğu gösterir.
# Gerçek zamanlı/otomatik HUD için macro:string/progress_bar_self kullanın.
#
# INPUT: macro:input { player:"<ad>", current:<int>, max:<int>, label:"<metin>" }
# CAĞIRI: function macro:string/progress_bar with storage macro:input {}
#
# BUGFIX v3.6 — TAM YENİDEN YAZIM:
#   1. "title $(player) actionbar" GEÇERSİZ — title komutu raw ad kabul etmez.
#      → title @a[name=$(player),limit=1] actionbar olarak düzeltildi.
#   2. $pb_cur/$pb_max/$pb_ten isimleri progress_bar_self ile çakışıyordu
#      → $pb1_seg/$pb1_max/$pb1_ten olarak yeniden adlandırıldı (race condition giderildi).
# ============================================

$scoreboard players set $pb1_seg macro.tmp $(current)
$scoreboard players set $pb1_max macro.tmp $(max)

# GUARD: max <= 0 → hata mesajı yaz ve çık
execute if score $pb1_max macro.tmp matches ..0 run tellraw @a[tag=macro.debug] {"text":"[progress_bar] HATA: max 0 veya negatif olamaz!","color":"red"}
execute if score $pb1_max macro.tmp matches ..0 run return fail

# segment = floor(current * 10 / max), 0..10 arasında sınırlan
scoreboard players set $pb1_ten macro.tmp 10
scoreboard players operation $pb1_seg macro.tmp *= $pb1_ten macro.tmp
scoreboard players operation $pb1_seg macro.tmp /= $pb1_max macro.tmp
execute if score $pb1_seg macro.tmp matches ..0 run scoreboard players set $pb1_seg macro.tmp 0
execute if score $pb1_seg macro.tmp matches 10.. run scoreboard players set $pb1_seg macro.tmp 10

# 11 adımlı lookup — selector ile doğru hedefleme
$execute if score $pb1_seg macro.tmp matches 0 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"░░░░░░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 1 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"█","color":"green"},{"text":"░░░░░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 2 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"██","color":"green"},{"text":"░░░░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 3 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"███","color":"green"},{"text":"░░░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 4 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"████","color":"green"},{"text":"░░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 5 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"█████","color":"yellow"},{"text":"░░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 6 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"██████","color":"yellow"},{"text":"░░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 7 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"███████","color":"yellow"},{"text":"░░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 8 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"████████","color":"green"},{"text":"░░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 9 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"█████████","color":"green"},{"text":"░","color":"red"}]
$execute if score $pb1_seg macro.tmp matches 10 run title @a[name=$(player),limit=1] actionbar [{"text":"$(label) ","color":"gray"},{"text":"██████████","color":"green"}]
