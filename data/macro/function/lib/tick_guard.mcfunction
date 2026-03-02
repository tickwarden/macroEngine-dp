# ============================================
# macro:lib/tick_guard
# ============================================
# @s için bu tick'te zaten çalışıp çalışmadığını kontrol eder.
# Aynı entity'nin aynı tick içinde bir fonksiyonu iki kez çalıştırmasını engeller.
#
# Dönen değer:
# return 0 → Bu tick'te zaten çalışmış (tekrar tetikleme). Dur.
# return 1 → İlk kez çalışıyor. Guard set edildi, devam et.
#
# NASIL ÇALIŞIR:
# @s'nin macro.tick_guard scoreboard değeri, $epoch macro.time ile karşılaştırılır.
# Eşitse → bu tick zaten işlendi → return 0.
# Farklıysa → ilk kez → epoch değerini yaz → return 1.
#
# ÖRNEK — tick'te çift tetiklenmeyi önle:
# execute as @a run function macro:my_func
# # my_func.mcfunction içinde:
# execute run function macro:lib/tick_guard
# # return 0 gelirse çalışmaz; 1 gelirse devam eder
#
# ÖRNEK — execute as @a döngüsünde güvenli kullanım:
# execute as @a run function macro:lib/tick_guard
# # Guard geçilen entity'ler işlemi yalnızca bir kez alır
#
# NOT: Guard tick sonunda otomatik geçersiz olur ($epoch her tick +1).
# Manüel temizlemek için macro:lib/tick_guard_clear kullanın.
# ============================================

# Bu tick'te zaten guard set edilmişse dur
execute if score @s macro.tick_guard = $epoch macro.time run return 0

# İlk kez: guard'ı bu tick'in epoch değerine eşitle
scoreboard players operation @s macro.tick_guard = $epoch macro.time

return 1
