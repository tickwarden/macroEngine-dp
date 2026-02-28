# ============================================
# macro:config/set_default
# ============================================
# Yalnızca key henüz yoksa string değer yazar.
# Zaten varsa hiçbir şey yapmaz.
# INPUT:  macro:input { key:"<anahtar>", value:"<değer>" }
# OUTPUT: macro:output { result: 1b (yeni yazıldı) | 0b (zaten vardı) }
# ============================================

# Varsayılan: yeni yazılacak (1b)
data modify storage macro:output result set value 1b

# Zaten varsa result = 0b, işlem yapma
$execute if data storage macro:engine config.$(key) run data modify storage macro:output result set value 0b
$execute if data storage macro:engine config.$(key) run return 0

# Yoksa yaz
$data modify storage macro:engine config.$(key) set value "$(value)"
tellraw @a[tag=macro.debug] [{"text":"[Config] Varsayilan: ","color":"yellow"},{"text":"$(key)","color":"white"},{"text":" = "},{"text":"$(value)","color":"gray"}]
