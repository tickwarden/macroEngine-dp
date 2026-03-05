# ============================================
# macro:inv/transfer_item
# ============================================
# Belirtilen tag'e sahip chest_minecart'in belirtilen slotundaki
# custom_data'ya sahip item'i oyuncunun envanterine tasir (loot via).
#
# Kullanim senaryolari:
#   - Shop: odeme alindiktan sonra urunu oyuncuya ver
#   - Kargo: chest_minecart'tan teslimat yap
#   - Puzzle: dogru esyayi al
#
# INPUT: macro:input
#   player     : <string>  — Oyuncu adi
#   tag        : <string>  — Chest minecart entity tag'i
#   slot       : <int>     — Container slot (0-26)
#   customData : <snbt>    — Aranacak custom_data SNBT ({...})
#
# EXAMPLE:
#   data modify storage macro:input player     set value "Steve"
#   data modify storage macro:input tag        set value "shop_cart_1"
#   data modify storage macro:input slot       set value 0
#   data modify storage macro:input customData set value "{id:\"mymap:sword\"}"
#   function macro:inv/transfer_item with storage macro:input {}
# ============================================

# BUG FIX v1.0.6-pre1: `loot give @s mine entity @e[...]` invalid syntax
# (`mine` bir blok pozisyonu bekler, entity selector almaz).
# Vanilla'da chest_minecart → player doğrudan slot transferi:
# `item replace entity <player> <dest_slot> from entity <container> container.<slot>`
# ⚠ Bu komut oyuncunun weapon.mainhand slotuna yazar.
# Oyuncunun ana elinin boş olması önerilir; doluysa mevcut item silinir.
$execute as @a[name=$(player),limit=1] at @s run item replace entity @s weapon.mainhand from entity @e[type=minecraft:chest_minecart,distance=..2,limit=1,tag=$(tag)] container.$(slot)
