# İterasyonu çalıştır, sayacı güncelle, tekrarla
execute store result score $rep_r macro.tmp run data get storage macro:engine _repeat.remaining
execute if score $rep_r macro.tmp matches ..0 run return 0

# Fonksiyonu çalıştır (i mevcut iterasyon indeksi olarak erişilebilir)
function macro:lib/internal/repeat_call with storage macro:engine _repeat

# remaining azalt, i artır
scoreboard players remove $rep_r macro.tmp 1
execute store result storage macro:engine _repeat.remaining int 1 run scoreboard players get $rep_r macro.tmp
execute store result score $rep_i macro.tmp run data get storage macro:engine _repeat.i
scoreboard players add $rep_i macro.tmp 1
execute store result storage macro:engine _repeat.i int 1 run scoreboard players get $rep_i macro.tmp

function macro:lib/internal/repeat_run
