# ============================================
# macro:string/progress_bar v4.0
# ============================================
# Tek kullanımlık progress bar gösterimi
# Minecraft 1.21.11+ uyumlu
#
# KULLANIM:
# data modify storage macro:input player set value "IronCrest"
# data modify storage macro:input current set value 15
# data modify storage macro:input max set value 20
# data modify storage macro:input label set value "Can"
# function macro:string/progress_bar with storage macro:input {}
# ============================================

# Değerleri ayarla
$scoreboard players set $pb1_seg macro.tmp $(current)
$scoreboard players set $pb1_max macro.tmp $(max)

# Max kontrolü
execute if score $pb1_max macro.tmp matches ..0 run return fail

# 10 segmente böl
scoreboard players set $pb1_ten macro.tmp 10
scoreboard players operation $pb1_seg macro.tmp *= $pb1_ten macro.tmp
scoreboard players operation $pb1_seg macro.tmp /= $pb1_max macro.tmp

# 0-10 arası sınırla
execute if score $pb1_seg macro.tmp matches ..0 run scoreboard players set $pb1_seg macro.tmp 0
execute if score $pb1_seg macro.tmp matches 10.. run scoreboard players set $pb1_seg macro.tmp 10

# Progress bar göster
$execute if score $pb1_seg macro.tmp matches 0 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ░░░░░░░░░░"}
$execute if score $pb1_seg macro.tmp matches 1 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █░░░░░░░░░"}
$execute if score $pb1_seg macro.tmp matches 2 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██░░░░░░░░"}
$execute if score $pb1_seg macro.tmp matches 3 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ███░░░░░░░"}
$execute if score $pb1_seg macro.tmp matches 4 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ████░░░░░░"}
$execute if score $pb1_seg macro.tmp matches 5 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █████░░░░░"}
$execute if score $pb1_seg macro.tmp matches 6 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██████░░░░"}
$execute if score $pb1_seg macro.tmp matches 7 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ███████░░░"}
$execute if score $pb1_seg macro.tmp matches 8 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ████████░░"}
$execute if score $pb1_seg macro.tmp matches 9 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) █████████░"}
$execute if score $pb1_seg macro.tmp matches 10 run title @a[name=$(player),limit=1] actionbar {"text":"$(label) ██████████"}
