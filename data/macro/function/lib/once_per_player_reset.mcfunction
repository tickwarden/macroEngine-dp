# ─────────────────────────────────────────────────────────────────
#  macro:lib/once_per_player_reset
#  once_per_player kaydını siler — fonksiyon tekrar çalışabilir hale gelir.
#  Girdi : $(player), $(key)
# ─────────────────────────────────────────────────────────────────

$data remove storage macro:engine once_per_player.$(player).$(key)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"lib/once_per_player_reset ","color":"aqua"},{"text":"$(player):$(key) sıfırlandı","color":"yellow"}]
