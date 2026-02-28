# Doğrudan çağırmayın.
# Makro INPUT: { func:"<handler_func>" } — _uro.src[0]'ın içeriği
# Bu handler, _uro.func ile eşleşmiyorsa events listesine geri eklenir.
$execute unless data storage macro:engine _uro{func:"$(func)"} run function macro:event/internal/uro_append with storage macro:engine _uro
