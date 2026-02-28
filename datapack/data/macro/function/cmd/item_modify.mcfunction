# ============================================
# macro:cmd/item_modify
# ============================================
# Entity'nin belirtilen slot'undaki item'a modifier uygular.
# macro:item_modifier/ altındaki JSON'ları kullanır.
#
# INPUT: macro:input { player:"<ad>", slot:"<slot>", modifier:"<namespace:id>" }
#
# SLOT ÖRNEKLERİ:
#   weapon.mainhand   — Ana el
#   weapon.offhand    — Yardımcı el
#   armor.head        — Kask
#   armor.chest       — Göğüs zırhı
#   armor.legs        — Bacak zırhı
#   armor.feet        — Ayakkabı
#   container.0       — Envanter slot 0 (0-35)
#
# MEVCUT MODIFIER'LAR (macro namespace):
#   macro:repair_full           — Hasar sıfırla (tam tamir)
#   macro:damage_random         — Rastgele hasar uygula
#   macro:enchant_randomly      — Rastgele büyü ekle
#   macro:enchant_with_levels_5 — 5 seviyeyle büyü ekle
#   macro:enchant_with_levels_30— 30 seviyeyle büyü ekle
#   macro:set_count_1           — Miktarı 1 yap
#   macro:set_count_64          — Miktarı 64 yap
#   macro:lore_add_custom       — Lore satırı ekle (append)
#   macro:lore_clear            — Tüm lore'u sil
#   macro:glint_add             — Parlama efekti ekle
#   macro:glint_remove          — Parlama efektini kaldır
#   macro:unbreakable           — Kırılmaz yap
#   macro:hide_tooltip          — Tooltip'i gizle
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input slot set value "weapon.mainhand"
#   data modify storage macro:input modifier set value "macro:repair_full"
#   function macro:cmd/item_modify with storage macro:input {}
# ============================================

$item modify entity @a[name=$(player),limit=1] $(slot) $(modifier)
