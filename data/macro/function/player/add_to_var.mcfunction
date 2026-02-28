# ============================================
# macro:player/add_to_var
# ============================================
# Oyuncunun bir sayısal değişkenine ekle/çıkar.
# Negatif amount ile çıkarma yapılır.
# INPUT: macro:input { player:"<ad>", key:"<değişken>", amount:<int> }
# OUTPUT: macro:output { result:<int> } ← yeni değer
# ============================================

# Mevcut değeri scoreboard'a oku
$execute store result score $pvar macro.tmp run data get storage macro:engine players.$(player).$(key)

# amount'u ekle
$scoreboard players set $pamount macro.tmp $(amount)
scoreboard players operation $pvar macro.tmp += $pamount macro.tmp

# Storage'a geri yaz
$execute store result storage macro:engine players.$(player).$(key) int 1 run scoreboard players get $pvar macro.tmp

# Output'a da yaz
execute store result storage macro:output result int 1 run scoreboard players get $pvar macro.tmp
