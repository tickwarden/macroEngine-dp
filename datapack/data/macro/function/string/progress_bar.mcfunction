# ============================================
# macro:string/progress_bar
# ============================================
# Action bar'da 10 segmentlik █/░ ilerleme çubuğu gösterir.
# INPUT: macro:input { player:"<ad>", current:<int>, max:<int>, label:"<metin>" }
# ============================================

# segment = floor(current * 10 / max), 0..10 arası sınırlanır
$scoreboard players set $pb_cur macro.tmp $(current)
$scoreboard players set $pb_max macro.tmp $(max)
scoreboard players set $pb_ten macro.tmp 10
scoreboard players operation $pb_cur macro.tmp *= $pb_ten macro.tmp
scoreboard players operation $pb_cur macro.tmp /= $pb_max macro.tmp
execute if score $pb_cur macro.tmp matches ..0 run scoreboard players set $pb_cur macro.tmp 0
execute if score $pb_cur macro.tmp matches 10.. run scoreboard players set $pb_cur macro.tmp 10

# 11 adımlı lookup — satır başı $ ile macro line, ortada $title YOK
$execute if score $pb_cur macro.tmp matches 0 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"░░░░░░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 1 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"█","color":"green"},{"text":"░░░░░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 2 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"██","color":"green"},{"text":"░░░░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 3 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"███","color":"green"},{"text":"░░░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 4 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"████","color":"green"},{"text":"░░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 5 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"█████","color":"yellow"},{"text":"░░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 6 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"██████","color":"yellow"},{"text":"░░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 7 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"███████","color":"yellow"},{"text":"░░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 8 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"████████","color":"green"},{"text":"░░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 9 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"█████████","color":"green"},{"text":"░","color":"red"}]
$execute if score $pb_cur macro.tmp matches 10 run title $(player) actionbar [{"text":"$(label) ","color":"gray"},{"text":"██████████","color":"green"}]
