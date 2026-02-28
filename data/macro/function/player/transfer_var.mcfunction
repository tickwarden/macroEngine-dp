# ============================================
# macro:player/transfer_var
# ============================================
# Oyuncudan oyuncuya değişken miktarı transfer et (örn: coin gönderme).
# from oyuncusundan amount düşülür, to oyuncusuna amount eklenir.
# Negatif bakiye ÖNLENMEZ — gerekirse önceden has_enough kontrolü yapın.
#
# INPUT: macro:input { from:"<kaynak>", to:"<hedef>", key:"<değişken>", amount:<int> }
# OUTPUT: macro:output { result:<hedef_yeni_değer> }
# ============================================

# from oyuncusundan çıkar
$execute store result score $tr_f macro.tmp run data get storage macro:engine players.$(from).$(key)
$scoreboard players set $tr_a macro.tmp $(amount)
scoreboard players operation $tr_f macro.tmp -= $tr_a macro.tmp
$execute store result storage macro:engine players.$(from).$(key) int 1 run scoreboard players get $tr_f macro.tmp

# to oyuncusuna ekle
$execute store result score $tr_t macro.tmp run data get storage macro:engine players.$(to).$(key)
scoreboard players operation $tr_t macro.tmp += $tr_a macro.tmp
$execute store result storage macro:engine players.$(to).$(key) int 1 run scoreboard players get $tr_t macro.tmp

execute store result storage macro:output result int 1 run scoreboard players get $tr_t macro.tmp
