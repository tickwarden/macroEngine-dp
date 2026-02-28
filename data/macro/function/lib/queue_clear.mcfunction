# ============================================
# macro:lib/queue_clear
# ============================================
# Bekleyen tüm kuyruk öğelerini siler.
# Mevcut tick'te çalışmakta olan iş etkilenmez.
#
# UYARI: Bu işlem geri alınamaz. Zamanlanmış tüm wait/queue_add
# çağrıları iptal edilir. Schedule'lar (macro:engine schedules)
# silinmez — onlar için schedule_cancel kullanın.
#
# INPUT:  (yok)
# OUTPUT: (yok)
#
# ÖRNEK:
#   # Oyun bitişinde bekleyen tüm işleri temizle
#   function macro:lib/queue_clear
# ============================================

data remove storage macro:engine queue
data modify storage macro:engine queue set value []
