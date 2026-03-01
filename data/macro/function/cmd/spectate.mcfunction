# ============================================
# macro:cmd/spectate
# ============================================
# Bir spectator oyuncunun bakış açısını hedef entity'ye bağlar.
# Spectator moddaki oyuncu hedefin gözünden görecektir.
#
# INPUT: macro:input { player:"<spectator_oyuncu>", target:"<hedef_selector>" }
#
# ÖRNEK:
#   data modify storage macro:input player set value "Watcher"
#   data modify storage macro:input target set value "@e[type=minecraft:creeper,limit=1,sort=nearest]"
#   function macro:cmd/spectate with storage macro:input {}
# ============================================

# BUG FIX v3.5: "execute as $(player)" → "@a[name=...]" selector
$execute as @a[name=$(player),limit=1] run spectate $(target)
