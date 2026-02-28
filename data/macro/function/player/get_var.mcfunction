# ============================================
# macro:player/get_var
# ============================================
# Oyuncuya ait değişkeni macro:output.result'a yazar
# INPUT: macro:input { player:"<ad>", key:"<değişken>" }
# OUTPUT: macro:output { result: <değer> }
# ============================================

$data modify storage macro:output result set from storage macro:engine players.$(player).$(key)
