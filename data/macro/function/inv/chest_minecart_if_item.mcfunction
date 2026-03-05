# ============================================
# macro:inv/chest_minecart_if_item
# ============================================
# @a'daki her oyuncu OLARAK ve KONUMUNDA:
# 2 blok mesafede, belirtilen tag'e sahip chest_minecart'in
# belirtilen container slotunda custom_data'ya sahip item
# VARSA belirtilen komutu run eder.
#
# Kullanim senaryolari:
#   - Item teslim alindiysa odul ver
#   - Dogru esya konulduğunda kapi ac
#   - Envanterde beklenen kargo var mi kontrol et
#
# INPUT: macro:input
#   tag        : <string>  -- Chest minecart entity tag'i
#   slot       : <int>     -- Container slot (0-26)
#   customData : <snbt>    -- Aranacak custom_data SNBT ({...})
#   action     : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input tag        set value "puzzle_cart"
#   data modify storage macro:input slot       set value 13
#   data modify storage macro:input customData set value "{id:\"mymap:key_item\"}"
#   data modify storage macro:input action     set value "setblock ~ ~1 ~ minecraft:air"
#   function macro:inv/chest_minecart_if_item with storage macro:input {}
# ============================================

$execute as @a at @s if items entity @e[type=minecraft:chest_minecart,distance=..2,limit=1,tag=$(tag)] container.$(slot) *[minecraft:custom_data=$(customData)] run $(action)
