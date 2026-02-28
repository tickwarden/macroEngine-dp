# ============================================
# macro:cmd/ride
# ============================================
# Bir oyuncuyu veya entity'yi belirtilen vehicle'a bindirir.
# Minecraft 1.21+ ride komutu kullanır.
#
# INPUT: macro:input { player:"<binici>", vehicle:"<araç_entity_UUID_veya_selector>" }
#
# ÖRNEK — oyuncuyu en yakın ata bindir:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input vehicle set value "@e[type=minecraft:horse,limit=1,sort=nearest]"
#   function macro:cmd/ride with storage macro:input {}
# ============================================

$ride $(player) mount $(vehicle)
