# ============================================
# macro:cmd/item_rename
# ============================================
# Oyuncunun belirtilen slot'undaki item'a dinamik isim verir.
# Aşama 1: İsim + renk storage'a yazılır.
# Aşama 2: macro:item_modifier/rename_to_custom.json ile uygulanır.
#
# ⚠️ NOT: /item modify komutu inline JSON kabul etmez — named item_modifier
# JSON dosyası gerektirir. Dinamik isim için önce
# macro:item_modifier/rename_to_custom.json'u istediğin isimle düzenle
# veya aşağıdaki scoreboard-NBT yöntemini kullan.
#
# INPUT: macro:input { player:"<ad>", slot:"<slot>", modifier:"<namespace:id>" }
#
# Dinamik isimlendirme için önerilen yol:
#   1. Projenin item_modifier/ altına kendi rename JSON'ını ekle
#   2. macro:cmd/item_modify ile uygula
#
# ÖRNEK (statik modifier ile):
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input slot set value "weapon.mainhand"
#   data modify storage macro:input modifier set value "macro:rename_to_custom"
#   function macro:cmd/item_rename with storage macro:input {}
# ============================================

$item modify entity @a[name=$(player),limit=1] $(slot) $(modifier)
