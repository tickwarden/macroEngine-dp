# ============================================
# macro:math/internal/sqrt_step
# ============================================
# macro:math/sqrt tarafindan cagrilan binary search adimi.
# Doğrudan çağırmayın.
#
# Kullandigi scoreboard skorlari:
#   $sqrt_n   - orijinal deger (sabit)
#   $sqrt_lo  - binary search alt siniri
#   $sqrt_hi  - binary search ust siniri
#   $sqrt_itr - kalan iterasyon sayisi
#   $sqrt_mid, $sqrt_sq, $sqrt_2 - gecici
# ============================================

# mid = (lo + hi) / 2
scoreboard players operation $sqrt_mid macro.tmp = $sqrt_lo macro.tmp
scoreboard players operation $sqrt_mid macro.tmp += $sqrt_hi macro.tmp
scoreboard players set $sqrt_2 macro.tmp 2
scoreboard players operation $sqrt_mid macro.tmp /= $sqrt_2 macro.tmp

# sq = mid * mid
scoreboard players operation $sqrt_sq macro.tmp = $sqrt_mid macro.tmp
scoreboard players operation $sqrt_sq macro.tmp *= $sqrt_mid macro.tmp

# mid^2 <= n -> lo = mid  |  mid^2 > n -> hi = mid
execute if score $sqrt_sq macro.tmp <= $sqrt_n macro.tmp run scoreboard players operation $sqrt_lo macro.tmp = $sqrt_mid macro.tmp
execute unless score $sqrt_sq macro.tmp <= $sqrt_n macro.tmp run scoreboard players operation $sqrt_hi macro.tmp = $sqrt_mid macro.tmp

# Sonraki iterasyon
scoreboard players remove $sqrt_itr macro.tmp 1
execute if score $sqrt_itr macro.tmp matches 1.. run function macro:math/internal/sqrt_step
