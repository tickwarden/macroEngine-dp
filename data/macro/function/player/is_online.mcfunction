# ─────────────────────────────────────────────────────────────────
#  macro:player/is_online
#  Oyuncunun sunucuda olup olmadığını kontrol eder.
#  Girdi : $(player) → oyuncu adı
#  Çıktı : macro:output result → 1b (çevrimiçi) / 0b (çevrimdışı)
# ─────────────────────────────────────────────────────────────────

data modify storage macro:output result set value 0b
$execute if entity @a[name=$(player),limit=1] run data modify storage macro:output result set value 1b
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"player/is_online ","color":"aqua"},{"text":"$(player) → ","color":"gray"},{"storage":"macro:output","nbt":"result","color":"green"}]
