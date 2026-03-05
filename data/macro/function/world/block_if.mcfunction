# ============================================
# macro:world/block_if
# ============================================
# Belirtilen koordinatta istenen blok VARSA komutu run eder.
# Block states verilirse onlari da denetler.
#
# Kullanim senaryolari:
#   - Lever acik mi kontrol et (lever[powered=true])
#   - Puzzle: dogru blok konulmus mu
#   - Redstone sinyali olmadan blok state oku
#
# INPUT: macro:input
#   x      : <int>     -- X koordinati
#   y      : <int>     -- Y koordinati
#   z      : <int>     -- Z koordinati
#   block  : <string>  -- Blok id +- state (minecraft:lever[powered=true] vb.)
#   action : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input x      set value 10
#   data modify storage macro:input y      set value 64
#   data modify storage macro:input z      set value -5
#   data modify storage macro:input block  set value "minecraft:lever[powered=true]"
#   data modify storage macro:input action set value "function mymap:door/open"
#   function macro:world/block_if with storage macro:input {}
# ============================================

$execute if block $(x) $(y) $(z) $(block) run $(action)
