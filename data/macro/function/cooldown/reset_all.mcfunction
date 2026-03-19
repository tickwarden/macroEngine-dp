# ─────────────────────────────────────────────────────────────────
#  macro:cooldown/reset_all
#  Bir oyuncunun tüm aktif cooldown'larını temizler.
#  Girdi : $(player) → oyuncu adı
#  Çıktı : (yan etki)
#
#  Örnek:
#    data modify storage macro:input player set value "Steve"
#    function macro:cooldown/reset_all with storage macro:input {}
# ─────────────────────────────────────────────────────────────────

$data remove storage macro:engine cooldowns.$(player)
$tellraw @a[tag=macro.debug] ["",{"text":"[AME] ","color":"#00AAAA","bold":true},{"text":"cooldown/reset_all ","color":"aqua"},{"text":"$(player) tüm cooldowns temizlendi","color":"yellow"}]
