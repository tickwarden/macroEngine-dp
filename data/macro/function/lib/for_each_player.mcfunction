# ============================================
# macro:lib/for_each_player
# ============================================
# Online olan her oyuncu OLARAK verilen fonksiyonu çalıştırır.
# Her oyuncu için @s = o oyuncu olur.
#
# INPUT: macro:input { func:"<namespace:path>" }
# ÖRNEK:
#   data modify storage macro:input func set value "mypack:daily/give_reward"
#   function macro:lib/for_each_player with storage macro:input {}
# ============================================

$execute as @a run function $(func)
