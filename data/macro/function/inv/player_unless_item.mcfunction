# ============================================
# macro:inv/player_unless_item
# ============================================
# Belirtilen oyuncunun herhangi bir slotunda
# custom_data'ya sahip item YOKSA komutu run eder.
#
# Kullanim senaryolari:
#   - Quest item kaybolmussa uyar
#   - Anahtar olmadan gecemez kontrolu
#   - Belirli esya olmadan bolgeye girilmesini engelle
#
# INPUT: macro:input
#   player     : <string>  -- Oyuncu adi
#   customData : <snbt>    -- Aranacak custom_data SNBT ({...})
#   action     : <string>  -- Kosul saglanirsa run edilecek komut
#
# EXAMPLE:
#   data modify storage macro:input player     set value "Steve"
#   data modify storage macro:input customData set value "{id:\"mymap:quest_scroll\"}"
#   data modify storage macro:input action     set value "say Scroll'u kaybettin!"
#   function macro:inv/player_unless_item with storage macro:input {}
# ============================================

$execute as @a[name=$(player),limit=1] at @s unless items entity @s *.* *[minecraft:custom_data=$(customData)] run $(action)
