# Doğrudan çağırmayın — math/log2 tarafından kullanılır.
# BUG FIX v3.2: Dogru sira: dur <= 1, sonra r++, sonra bol
# Onceki kod: bol, dur == 1, r++ -- log2(2)=0 donuyordu (dogru: 1)

# v <= 1 ise dur
execute if score $lg2_v macro.tmp matches ..1 run return 0

# r++ ve bol
scoreboard players add $lg2_r macro.tmp 1
scoreboard players operation $lg2_v macro.tmp /= $lg2_2 macro.tmp

function macro:math/internal/log2_loop
