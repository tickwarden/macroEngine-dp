# ============================================
# macro:cmd/as_player
# ============================================
# Herhangi bir komutu belirtilen oyuncu OLARAK ve
# oyuncunun KONUMUNDA çalıştırır.
# INPUT: macro:input { player:"<ad>", cmd:"<komut>" }
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input cmd set value "effect give @s speed 5 2 true"
#   function macro:cmd/as_player with storage macro:input {}
# ============================================

$execute as @a[name=$(player),limit=1] at @s run $(cmd)
