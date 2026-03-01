# ============================================
# macro:string/progress_bar_self
# ============================================
# Her oyuncu için ayrı ayrı çalışır; skoru scoreboard'dan okur.
# execute as @a bağlamında çağrılmak ZORUNDADIR.
#
# INPUT (macro:engine storage'dan okunur — macro:input kirlenmez):
#   pb_obj   : scoreboard objective adı (string)
#   pb_max   : maksimum değer (int)
#   pb_label : görünen etiket (string)
#
# ÇAĞIRI: execute as @a run function macro:string/progress_bar_self with storage macro:engine {}
#
# OTOMATİK HUD (elle çağırmaya gerek yok!):
#   data modify storage macro:engine pb_obj   set value "health"
#   data modify storage macro:engine pb_max   set value 20
#   data modify storage macro:engine pb_label set value "Can"
#   → tick.mcfunction her 4 tick'te otomatik çalıştırır.
#   Kapatmak için: data remove storage macro:engine pb_obj
#
# BUGFIX v3.6 — TAM YENİDEN YAZIM:
#   1. $pb_cur/$pb_max/$pb_ten → $pbs_seg/$pbs_max/$pbs_ten (progress_bar ile çakışma giderildi)
#   2. @s ile title komutu — her oyuncu kendi actionbar'ını görür (doğru davranış)
# ============================================

# GUARD: pb_max <= 0 → hata yaz ve çık
$scoreboard players set $pbs_max macro.tmp $(pb_max)
execute if score $pbs_max macro.tmp matches ..0 run tellraw @a[tag=macro.debug] {"text":"[progress_bar_self] HATA: pb_max 0 veya negatif olamaz!","color":"red"}
execute if score $pbs_max macro.tmp matches ..0 run return fail

# @s'in skorunu objective'den oku
$execute store result score $pbs_seg macro.tmp run scoreboard players get @s $(pb_obj)

# segment = floor(seg * 10 / max), 0..10 sınırlan
scoreboard players set $pbs_ten macro.tmp 10
scoreboard players operation $pbs_seg macro.tmp *= $pbs_ten macro.tmp
scoreboard players operation $pbs_seg macro.tmp /= $pbs_max macro.tmp
execute if score $pbs_seg macro.tmp matches ..0 run scoreboard players set $pbs_seg macro.tmp 0
execute if score $pbs_seg macro.tmp matches 10.. run scoreboard players set $pbs_seg macro.tmp 10

# 11 adımlı lookup — @s = bu oyuncu (execute as bağlamı)
$execute if score $pbs_seg macro.tmp matches 0 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"░░░░░░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 1 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"█","color":"green"},{"text":"░░░░░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 2 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"██","color":"green"},{"text":"░░░░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 3 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"███","color":"green"},{"text":"░░░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 4 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"████","color":"green"},{"text":"░░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 5 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"█████","color":"yellow"},{"text":"░░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 6 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"██████","color":"yellow"},{"text":"░░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 7 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"███████","color":"yellow"},{"text":"░░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 8 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"████████","color":"green"},{"text":"░░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 9 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"█████████","color":"green"},{"text":"░","color":"red"}]
$execute if score $pbs_seg macro.tmp matches 10 run title @s actionbar [{"text":"$(pb_label) ","color":"gray"},{"text":"██████████","color":"green"}]
