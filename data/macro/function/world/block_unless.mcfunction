# ============================================
# macro:world/block_unless
# ============================================
# Belirtilen koordinatta istenen blok YOKSA komutu run eder.
#
# Kullanim senaryolari:
#   - Kapi kapali degilse (air varsa) gecisi engelle
#   - Platform henuz koyulmamissa uyar
#   - Blok kaldirilmis mi kontrol et
#
# INPUT: macro:input
#   x      : <int>     -- X koordinati
#   y      : <int>     -- Y koordinati
#   z      : <int>     -- Z koordinati
#   block  : <string>  -- Blok id +- state
#   action : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input x      set value 0
#   data modify storage macro:input y      set value 70
#   data modify storage macro:input z      set value 0
#   data modify storage macro:input block  set value "minecraft:barrier"
#   data modify storage macro:input action set value "say Bariyer yok!"
#   function macro:world/block_unless with storage macro:input {}
# ============================================

$execute unless block $(x) $(y) $(z) $(block) run $(action)
