# macro:player/copy_var — Bir oyuncunun değişkenini başka oyuncuya kopyala
# INPUT: macro:input { from:"<kaynak>", to:"<hedef>", key:"<değişken>" }

$data modify storage macro:engine players.$(to).$(key) set from storage macro:engine players.$(from).$(key)
