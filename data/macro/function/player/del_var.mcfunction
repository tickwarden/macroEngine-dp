# ============================================
# macro:player/del_var
# ============================================
# INPUT: macro:input { player:"<ad>", key:"<değişken>" }
# ============================================

$data remove storage macro:engine players.$(player).$(key)
