# ============================================
# macro:player/list_vars
# ============================================
# Oyuncunun tüm değişkenlerini ve cooldown'larını debug olarak göster.
# INPUT: macro:input { player:"<ad>" }
# ============================================

$tellraw @a[tag=macro.debug] [{"text":"----------------","color":"dark_gray"},{"text":" [VARS] ","color":"white"},{"text":"$(player)","color":"aqua","bold":true},{"text":" ----------------","color":"dark_gray"}]

$execute if data storage macro:engine players.$(player) run tellraw @a[tag=macro.debug] [{"text":"  Degiskenler: ","color":"gray"},{"storage":"macro:engine","nbt":"players.$(player)","interpret":false,"color":"yellow"}]
$execute unless data storage macro:engine players.$(player) run tellraw @a[tag=macro.debug] {"text":"  [!] Kayit yok.","color":"red"}

$execute if data storage macro:engine cooldowns.$(player) run tellraw @a[tag=macro.debug] [{"text":"  Cooldown'lar: ","color":"gray"},{"storage":"macro:engine","nbt":"cooldowns.$(player)","interpret":false,"color":"aqua"}]
$execute unless data storage macro:engine cooldowns.$(player) run tellraw @a[tag=macro.debug] {"text":"  [CD] Aktif cooldown yok.","color":"dark_gray"}

tellraw @a[tag=macro.debug] {"text":"----------------------------------------","color":"dark_gray"}
