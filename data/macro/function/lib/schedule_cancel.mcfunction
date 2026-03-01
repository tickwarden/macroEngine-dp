# ============================================
# macro:lib/schedule_cancel
# ============================================
# Belirtilen schedule'ı iptal eder.
# Kuyruktaki mevcut çalışma tamamlanır ama bir daha eklenmez.
# INPUT: macro:input { key:"<schedule_id>" }
# ============================================

$data remove storage macro:engine schedules.$(key)
