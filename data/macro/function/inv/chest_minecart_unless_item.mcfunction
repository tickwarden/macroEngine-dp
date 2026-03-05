# ============================================
# macro:inv/chest_minecart_unless_item
# ============================================
# @a'daki her oyuncu OLARAK ve KONUMUNDA:
# 2 blok mesafede, belirtilen tag'e sahip chest_minecart'in
# belirtilen container slotunda custom_data'ya sahip item
# YOKSA belirtilen komutu run eder.
#
# Kullanim senaryolari:
#   - Kargo gonderi sistemi: slot bosaldiysa tetikle
#   - Puzzle: dogru esya koyulmadiysa reset
#   - Shop: odeme alinip alinmadigini dogrula
#
# INPUT: macro:input
#   tag        : <string>  -- Chest minecart entity tag'i
#   slot       : <int>     -- Container slot (0-26)
#   customData : <snbt>    -- Aranacak custom_data SNBT ({...})
#   action     : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input tag        set value "shop_cart_1"
#   data modify storage macro:input slot       set value 0
#   data modify storage macro:input customData set value "{id:\"mymap:payment\"}"
#   data modify storage macro:input action     set value "say Odeme alindi!"
#   function macro:inv/chest_minecart_unless_item with storage macro:input {}
# ============================================

$execute as @a at @s unless items entity @e[type=minecraft:chest_minecart,distance=..2,limit=1,tag=$(tag)] container.$(slot) *[minecraft:custom_data=$(customData)] run $(action)
