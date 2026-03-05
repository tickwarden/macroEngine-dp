# ============================================
# macro:inv/player_slot_if_item
# ============================================
# Belirtilen oyuncunun belirtilen SLOTUNDA
# custom_data'ya sahip item VARSA komutu run eder.
#
# SLOT REFERANSI:
#   weapon.mainhand / weapon.offhand
#   armor.head / armor.chest / armor.legs / armor.feet
#   container.0-35 (envanter) / hotbar.0-8
#
# INPUT: macro:input
#   player     : <string>  -- Oyuncu adi
#   slot       : <string>  -- Slot tipi (weapon.mainhand vb.)
#   customData : <snbt>    -- Aranacak custom_data SNBT ({...})
#   action     : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input player     set value "Steve"
#   data modify storage macro:input slot       set value "weapon.mainhand"
#   data modify storage macro:input customData set value "{id:\"mymap:magic_sword\"}"
#   data modify storage macro:input action     set value "effect give @s strength 5 2 true"
#   function macro:inv/player_slot_if_item with storage macro:input {}
# ============================================

$execute as @a[name=$(player),limit=1] at @s if items entity @s $(slot) *[minecraft:custom_data=$(customData)] run $(action)
