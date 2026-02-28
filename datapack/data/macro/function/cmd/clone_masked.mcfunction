# ============================================
# macro:cmd/clone_masked
# ============================================
# Yalnızca hava olmayan blokları kopyalar (masked mod).
# Bina şablonları ve yapı yerleştirme için idealdir.
#
# INPUT: macro:input { x1, y1, z1, x2, y2, z2, dx, dy, dz }
# ============================================

$clone $(x1) $(y1) $(z1) $(x2) $(y2) $(z2) $(dx) $(dy) $(dz) masked
