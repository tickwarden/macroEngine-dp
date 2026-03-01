# ============================================
# macro:lib/process_queue
# ============================================
# Her tick çağrılır, queue[0]'ın delay'ini azaltır.
# delay <= 0 olunca fonksiyonu çalıştırır ve siler.
# BUG FIX v2.5: Aynı tick'te birden fazla delay=0 item varsa hepsi işlenir.
# BUG FIX v3.0: $pq_depth ile tick başına 256 özyineleme limiti — stack overflow engeli.
# ============================================

# Özyineleme derinlik kontrolü
scoreboard players add $pq_depth macro.tmp 1
execute if score $pq_depth macro.tmp matches 257.. run return 0

execute unless data storage macro:engine queue[0] run return 0

execute store result score $qdel macro.tmp run data get storage macro:engine queue[0].delay

scoreboard players remove $qdel macro.tmp 1
execute store result storage macro:engine queue[0].delay int 1 run scoreboard players get $qdel macro.tmp

# delay <= 0 ise çalıştır, sil, ve bir sonraki item için tekrar çalış
execute if score $qdel macro.tmp matches ..0 run function macro:lib/internal/queue_fire
execute if score $qdel macro.tmp matches ..0 run function macro:lib/process_queue
