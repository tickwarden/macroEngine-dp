# ============================================
# macro:cmd/advancement_revoke
# ============================================
# Oyuncudan advancement alır.
#
# INPUT: macro:input { player:"<ad>", advancement:"<namespace:id>" }
# ============================================

$advancement revoke @a[name=$(player),limit=1] only $(advancement)
