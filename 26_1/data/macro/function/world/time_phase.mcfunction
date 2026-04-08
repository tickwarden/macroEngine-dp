# ─────────────────────────────────────────────────────────────────
# macro:world/time_phase
# 26.1+ World Clocks uyumlu zaman fazı belirleme
#
# OUTPUT:
#   macro:output.phase     → "dawn" / "day" / "dusk" / "night"
#   macro:output.daytime   → raw daytime tick (0–23999)
#   macro:output.is_day    → 1b (gündüz)
#   macro:output.is_night  → 1b (gece)
#   macro:output.is_dawn   → 1b (şafak)
#   macro:output.is_dusk   → 1b (alacakaranlık)
# ─────────────────────────────────────────────────────────────────

# Gün içi zamanı al (26.1+ doğru syntax)
execute store result score $tp_t macro.tmp run time of minecraft:overworld query day

# Raw daytime değerini storage'a yaz
execute store result storage macro:output daytime int 1 run scoreboard players get $tp_t macro.tmp

# Boolean flag'leri sıfırla
data modify storage macro:output is_day set value 0b
data modify storage macro:output is_night set value 0b
data modify storage macro:output is_dawn set value 0b
data modify storage macro:output is_dusk set value 0b

# Boolean değerleri ayarla
execute if score $tp_t macro.tmp matches 0..12999 run data modify storage macro:output is_day set value 1b
execute if score $tp_t macro.tmp matches 13000..23999 run data modify storage macro:output is_night set value 1b
execute if score $tp_t macro.tmp matches 0..999 run data modify storage macro:output is_dawn set value 1b
execute if score $tp_t macro.tmp matches 12000..13799 run data modify storage macro:output is_dusk set value 1b

# Faz ismini belirle
execute if score $tp_t macro.tmp matches 0..999 run data modify storage macro:output phase set value "dawn"
execute if score $tp_t macro.tmp matches 1000..11999 run data modify storage macro:output phase set value "day"
execute if score $tp_t macro.tmp matches 12000..13799 run data modify storage macro:output phase set value "dusk"
execute if score $tp_t macro.tmp matches 13800..23999 run data modify storage macro:output phase set value "night"

# Debug mesajı (isteğe bağlı)
tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"world/time_phase ","color":"aqua"},{"storage":"macro:output","nbt":"phase","color":"green"},{"text":" t=","color":"gray"},{"storage":"macro:output","nbt":"daytime","color":"white"}]
