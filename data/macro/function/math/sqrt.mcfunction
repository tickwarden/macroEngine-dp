# ============================================
# macro:math/sqrt
# ============================================
# Tamsayı karekök: floor(√value)
# INPUT:  macro:input { value:<int> }
# OUTPUT: macro:output { result:<int> }
#
# Maksimum girdi: 2,147,395,600  (46340² ≈ 2³¹)
# Daha büyük değerler 46340 döndürür.
#
# Algoritma: Binary search, 16 iterasyon
#   İnvaryant: lo² ≤ value < hi²
#   Başlangıç:  lo=0, hi=min(value, 46341)
#   16 adım → aralık 1'e düşer → lo = floor(√value)
# ============================================

$scoreboard players set $sqrt_n macro.tmp $(value)

# Negatif ve sıfır özel durumu
execute if score $sqrt_n macro.tmp matches ..0 run data modify storage macro:output result set value 0
execute if score $sqrt_n macro.tmp matches ..0 run return 0

# Girdi 1 ise sonuç 1
execute if score $sqrt_n macro.tmp matches 1 run data modify storage macro:output result set value 1
execute if score $sqrt_n macro.tmp matches 1 run return 0

# Binary search sınırlarını başlat
scoreboard players set $sqrt_lo macro.tmp 0
scoreboard players operation $sqrt_hi macro.tmp = $sqrt_n macro.tmp
# Üst sınırı 46341 ile sınırla (46341² > 2^31 aşımı engeli)
execute if score $sqrt_hi macro.tmp matches 46342.. run scoreboard players set $sqrt_hi macro.tmp 46341

# 16 iterasyon (2^16 = 65536 > 46341 → her değer için yeterli)
scoreboard players set $sqrt_itr macro.tmp 16
function macro:math/internal/sqrt_step

# lo = floor(√value)
execute store result storage macro:output result int 1 run scoreboard players get $sqrt_lo macro.tmp
