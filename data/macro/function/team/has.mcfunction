# ============================================
# macro:team/has
# ============================================
# Oyuncu belirtilen takımda mı kontrol eder.
# INPUT:  macro:input { team:"<isim>", player:"<oyuncu>" }
# OUTPUT: macro:output { result: 1b (evet) | 0b (hayır) }
# ============================================

data modify storage macro:output result set value 0b
$execute if entity @a[name=$(player),team=$(team)] run data modify storage macro:output result set value 1b
