# for_each_list iç döngü adımı — for_each_list tarafından çağrılır
execute unless data storage macro:engine _felist_input[0] run return 0

# Mevcut elemanı güncelle
data modify storage macro:engine _felist_current set from storage macro:engine _felist_input[0]
execute store result storage macro:engine _felist_i int 1 run scoreboard players get $felist_i macro.tmp

# Kullanıcı fonksiyonunu çalıştır
function macro:lib/internal/for_each_list_call with storage macro:engine _felist_state

# Listeyi ilerlet
data remove storage macro:engine _felist_input[0]
scoreboard players add $felist_i macro.tmp 1

# Sonraki eleman
function macro:lib/internal/for_each_list_step
