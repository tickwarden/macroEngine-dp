# ============================================
# macro:player/add_default
# ============================================
# Oyuncunun bir değişkeni yoksa varsayılan değeri yaz (varsa dokunma).
# init'ten bağımsız olarak tek değişken koruma.
# INPUT: macro:input { player:"<ad>", key:"<değişken>", value:<değer> }
# ============================================

$execute unless data storage macro:engine players.$(player).$(key) run data modify storage macro:engine players.$(player).$(key) set value $(value)
