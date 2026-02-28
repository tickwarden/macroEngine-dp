# ============================================
# macro:state/is
# ============================================
# Oyuncunun durumu beklenen değerle eşleşiyor mu kontrol eder.
# NBT string eşleşmesi kullanır.
#
# INPUT:  macro:input { player:"<oyuncu_adı>", state:"<beklenen_durum>" }
# OUTPUT: macro:output { result: 1b (eşleşiyor) / 0b (eşleşmiyor) }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input state set value "lobby"
#   function macro:state/is with storage macro:input {}
#   # macro:output.result → 1b veya 0b
# ============================================

data modify storage macro:output result set value 0b
$execute if data storage macro:engine states{$(player):"$(state)"} run data modify storage macro:output result set value 1b
