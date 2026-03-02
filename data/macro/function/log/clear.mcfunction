# ============================================
# macro:log/clear
# ============================================
# Tüm log girişlerini temizler.
# log_display listesini sıfırlar, sayacı geri alır.
#
# ÇAĞIRIM:
# function macro:log/clear
# ============================================

data modify storage macro:engine log_display set value []
scoreboard players set $log_count macro.tmp 0
