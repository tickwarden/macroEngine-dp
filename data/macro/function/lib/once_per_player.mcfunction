# ─────────────────────────────────────────────────────────────────
#  macro:lib/once_per_player
#  Verilen key için her oyuncuda yalnızca bir kez fonksiyonu çalıştırır.
#  Oturum sıfırlanana dek tekrar çalışmaz.
#  Girdi : $(func)   → çalıştırılacak fonksiyon
#           $(key)    → benzersiz key (örn: "tutorial_intro")
#           $(player) → oyuncu adı
#  Çıktı : macro:output ran → 1b (çalıştı) / 0b (daha önce yapılmıştı)
# ─────────────────────────────────────────────────────────────────

data modify storage macro:output ran set value 0b

$execute if data storage macro:engine once_per_player.$(player).$(key) run return 0

data modify storage macro:output ran set value 1b
$data modify storage macro:engine once_per_player.$(player).$(key) set value 1b
$function $(func)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"lib/once_per_player ","color":"aqua"},{"text":"$(player):$(key) ","color":"white"},{"text":"✔ ilk kez çalıştı","color":"green"}]
