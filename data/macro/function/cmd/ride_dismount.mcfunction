# ============================================
# macro:cmd/ride_dismount
# ============================================
# Oyuncuyu veya entity'yi bindiği araçtan indirir.
#
# INPUT: macro:input { player:"<binici>" }
# ============================================

# BUG FIX v3.5: @a[name=...] selector kullanılmalı
$ride @a[name=$(player),limit=1] dismount
