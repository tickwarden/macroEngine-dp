# ============================================
# macro:lib/tick_guard_clear
# ============================================
# @s için tick_guard'ı manuel olarak temizler.
# Normalde gerekli değildir — guard $epoch ile otomatik geçersiz olur.
# Yalnızca aynı tick içinde @s'yi guard'dan muaf tutmak istediğinizde kullanın.
#
# ÖRNEK:
# execute as <oyuncu> run function macro:lib/tick_guard_clear
# ============================================

scoreboard players set @s macro.tick_guard -1
