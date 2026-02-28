# ============================================
# macro:cmd/spectate_stop
# ============================================
# Spectator oyuncunun hedef izlemesini sonlandırır.
#
# INPUT: macro:input { player:"<spectator_oyuncu>" }
# ============================================

# BUG FIX v3.5: "execute as $(player)" → "@a[name=...]" selector
$execute as @a[name=$(player),limit=1] run spectate
