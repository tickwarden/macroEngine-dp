# ============================================
# macro:lib/for_each_player_at
# ============================================
# Online olan her oyuncu OLARAK ve onun KONUMUNDA fonksiyon çalıştır.
# INPUT: macro:input { func:"<namespace:path>" }
# ============================================

$execute as @a at @s run function $(func)
