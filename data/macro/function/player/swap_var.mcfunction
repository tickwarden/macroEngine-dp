# macro:player/swap_var — İki oyuncu arasında değişken değerlerini takas et
# INPUT: macro:input { player_a:"<ad>", player_b:"<ad>", key:"<değişken>" }

# Geçici yedeğe al
$data modify storage macro:engine _swap.tmp set from storage macro:engine players.$(player_a).$(key)
# B → A
$data modify storage macro:engine players.$(player_a).$(key) set from storage macro:engine players.$(player_b).$(key)
# Yedek → B
$data modify storage macro:engine players.$(player_b).$(key) set from storage macro:engine _swap.tmp
data remove storage macro:engine _swap
