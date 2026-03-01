# ============================================
# macro:cmd/damage_typed
# ============================================
# Özel damage type ile hasar verir.
# macro:damage_type/ altındaki JSON'ları kullanır.
#
# INPUT: macro:input { player:"<ad>", amount:<float>, damage_type:"<namespace:id>" }
#
# MEVCUT DAMAGE TYPES (macro namespace):
#   macro:magic         — Büyü hasarı, armor bypass, scaling yok
#   macro:true_damage   — Generic mesaj, scaling yok
#   macro:void_custom   — Void benzeri, "outOfWorld" mesajı
#   macro:fire_custom   — Ateş efekti ile hasar
#   macro:wither_custom — Wither efekti ile hasar
#
# ÖRNEK:
#   data modify storage macro:input player set value "Steve"
#   data modify storage macro:input amount set value 10.0
#   data modify storage macro:input damage_type set value "macro:magic"
#   function macro:cmd/damage_typed with storage macro:input {}
# ============================================

$damage @a[name=$(player),limit=1] $(amount) $(damage_type)
